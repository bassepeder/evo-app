import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;

import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:evo/common/preloaded_data.dart';
import 'package:evo/constants.dart';
import 'package:evo/features/auth/providers/auth_session.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart'
    show
        BaseClient,
        BaseRequest,
        BaseResponse,
        Client,
        ClientException,
        Request,
        Response,
        StreamedResponse;
import 'package:http/io_client.dart';
import 'package:http/retry.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http.g.dart';

final _logger = Logger('HttpClient');

const _maxCacheSize = 2 * 1024 * 1024;

Uri evoUri(String path, [Map<String, dynamic>? queryParameters]) =>
    Uri.https(kBaseApiUrl, path, queryParameters);

/// Creates the appropriate http client for the platform.
///
/// Do not use directly, use [defaultClient] or [evoClient] instead.
class HttpClientFactory {
  Client call() {
    const userAgent = 'EVO Mobile';
    if (Platform.isAndroid) {
      final engine = CronetEngine.build(
        cacheMode: CacheMode.memory,
        cacheMaxSize: _maxCacheSize,
        userAgent: userAgent,
      );
      return CronetClient.fromCronetEngine(engine);
    }

    if (Platform.isIOS || Platform.isMacOS) {
      final config = URLSessionConfiguration.ephemeralSessionConfiguration()
        ..cache = URLCache.withCapacity(memoryCapacity: _maxCacheSize)
        ..httpAdditionalHeaders = {'User-Agent': userAgent};
      return CupertinoClient.fromSessionConfiguration(config);
    }

    return IOClient(HttpClient()..userAgent = userAgent);
  }
}

@Riverpod(keepAlive: true)
HttpClientFactory httpClientFactory(Ref _) => HttpClientFactory();

/// The default http client.
///
/// This client is used for all requests that don't go to the lichess server, for
/// example, requests to lichess CDN, or other APIs.
/// Only one instance of this client is created and kept alive for the whole app.
@Riverpod(keepAlive: true)
Client defaultClient(Ref ref) {
  final client = LoggingClient(ref.read(httpClientFactoryProvider)());
  ref.onDispose(() => client.close());
  return client;
}

/// The http client configured to make requests to the EVO API.
///
/// Only one instance of this client is created and kept alive for the whole app.
@Riverpod(keepAlive: true)
EvoClient evoClient(Ref ref) {
  final client = EvoClient(
    // Retry just once, after 500ms, on 429 Too Many Requests.
    RetryClient(
      ref.read(httpClientFactoryProvider)(),
      retries: 1,
      delay: _defaultDelay,
      when: (response) => response.statusCode == 429,
    ),
    ref,
  );
  ref.onDispose(() => client.close());
  return client;
}

Duration _defaultDelay(int retryCount) =>
    const Duration(milliseconds: 900) * math.pow(1.5, retryCount);

@Riverpod(keepAlive: true)
String userAgent(Ref ref) {
  final session = ref.watch(authSessionProvider);

  return makeUserAgent(
    ref.read(preloadedDataProvider).requireValue.packageInfo,
    ref.read(preloadedDataProvider).requireValue.deviceInfo,
  );
}

/// Creates a user-agent string with the app version, build number, and device info and possibly the user ID if a user is logged in.
String makeUserAgent(
  PackageInfo info,
  BaseDeviceInfo deviceInfo,
) {
  final base = 'EVO Mobile/${info.version} as:${'anon'}';

  if (deviceInfo is AndroidDeviceInfo) {
    return '$base os:Android/${deviceInfo.version.release} dev:${deviceInfo.model}';
  } else if (deviceInfo is IosDeviceInfo) {
    return '$base os:iOS/${deviceInfo.systemVersion} dev:${deviceInfo.model}';
  }

  return base;
}

/// A [Client] that logs all requests.
class LoggingClient extends BaseClient {
  LoggingClient(this._inner);

  final Client _inner;

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    _logger.info('${request.method} ${request.url}');
    return _inner.send(request);
  }
}

/// EVO HTTP client.
///
/// * All requests made with [head], [get], [post], [put], [patch], [delete] target
/// the EVO server, defined in [kBaseApiUrl]. It does not apply to the low-level
/// [send] method.
/// * Sets the Authorization header when a token has been stored.
/// * Sets the user-agent header with the app version, build number, and device info. If the user is logged in, it also includes the user's id.
/// * Logs all requests and responses with status code >= 400.
/// * When a response has the 401 status, checks if the session token is still valid,
/// and deletes the session if it's not.
class EvoClient implements Client {
  EvoClient(this._inner, this._ref);

  final Ref _ref;
  final Client _inner;

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final session = _ref.read(authSessionProvider);

    if (session != null && !request.headers.containsKey('Authorization')) {
      request.headers['Authorization'] = session.token;
    }
    request.headers['User-Agent'] = makeUserAgent(
      _ref.read(preloadedDataProvider).requireValue.packageInfo,
      _ref.read(preloadedDataProvider).requireValue.deviceInfo,
    );

    _logger.info(
      '${request.method} ${request.url} ${request.headers['User-Agent']}',
    );

    try {
      final response = await _inner.send(request);

      _logIfError(response);

      if (response.statusCode == 401 && session != null) {
        _checkSessionToken(session);
      }

      return response;
    } catch (e, st) {
      _logger.warning('Request to ${request.url} failed: $e', e, st);
      rethrow;
    }
  }

  /// Checks if the session token is still valid, and delete session if it's not.
  Future<void> _checkSessionToken(AuthSessionState session) async {
    final defaultClient = _ref.read(defaultClientProvider);
    // TODO: Implement this
    final data = await defaultClient
        .postReadJson(
          evoUri('/api/token/test'),
          mapper: (json) => json,
          body: session.token,
        )
        .timeout(const Duration(seconds: 5));
    if (data[session.token] == null) {
      _logger.fine('Session is not active. Deleting it.');
      await _ref.read(authSessionProvider.notifier).delete();
    }
  }

  void _logIfError(BaseResponse response) {
    if (response.request != null && response.statusCode >= 400) {
      final request = response.request!;
      final method = request.method;
      final url = request.url;
      _logger.warning(
        '$method $url responded with status ${response.statusCode} ${response.reasonPhrase}',
      );
    }
  }

  @override
  void close() {
    _inner.close();
  }

  @override
  Future<Response> head(
    Uri url, {
    Map<String, String>? headers,
  }) =>
      _sendUnstreamed('HEAD', url, headers);

  @override
  Future<Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) =>
      _sendUnstreamed('GET', url, headers);

  @override
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('POST', url, headers, body, encoding);

  @override
  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('PUT', url, headers, body, encoding);

  @override
  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('PATCH', url, headers, body, encoding);

  @override
  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) =>
      _sendUnstreamed('DELETE', url, headers, body, encoding);

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    final response = await get(url, headers: headers);
    _checkResponseSuccess(url, response);
    return response.body;
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    final response = await get(url, headers: headers);
    _checkResponseSuccess(url, response);
    return response.bodyBytes;
  }

  /// Sends a non-streaming [Request] and returns a non-streaming [Response].
  Future<Response> _sendUnstreamed(
    String method,
    Uri url,
    Map<String, String>? headers, [
    Object? body,
    Encoding? encoding,
  ]) async {
    final request = Request(
      method,
      evoUri(url.path, url.hasQuery ? url.queryParameters : null),
    );

    if (headers != null) request.headers.addAll(headers);
    if (encoding != null) request.encoding = encoding;
    if (body != null) {
      if (body is String) {
        request.body = body;
      } else if (body is List) {
        request.bodyBytes = body.cast<int>();
      } else if (body is Map) {
        request.bodyFields = body.cast<String, String>();
      } else {
        throw ArgumentError('Invalid request body "$body".');
      }
    }

    return Response.fromStream(await send(request));
  }
}

/// An exception thrown when the server responds with a status code >= 400.
class ServerException extends ClientException {
  final int statusCode;
  final Map<String, dynamic>? jsonError;

  ServerException(
    this.statusCode,
    super.message,
    Uri super.url,
    this.jsonError,
  );
}

/// Throws an error if [response] is not successful.
void _checkResponseSuccess(Uri url, Response response) {
  if (response.statusCode < 400) return;
  var message = 'Request to $url failed with status ${response.statusCode}';
  if (response.reasonPhrase != null) {
    message = '$message: ${response.reasonPhrase}';
  }
  Map<String, dynamic>? jsonError;
  if (response.body.isNotEmpty) {
    try {
      final json = jsonDecode(response.body);
      if (json is Map<String, dynamic>) {
        jsonError = json;
        if (json.containsKey('error')) {
          message = '$message: ${json['error']}';
        }
      }
    } catch (e) {
      _logger.warning('Could not decode error response from $url: $e');
    }
  }
  throw ServerException(response.statusCode, '$message.', url, jsonError);
}

/// A JSON decoder that decodes UTF-8 bytes.
///
/// This is a fusion of [Utf8Decoder] and [JsonDecoder] which is more efficient
/// than decoding the bytes to a string and then parsing the JSON.
final jsonUtf8Decoder = const Utf8Decoder().fuse(const JsonDecoder());

extension ClientExtension on Client {
  /// Sends an HTTP GET request with the given headers to the given URL and
  /// returns a Future that completes to the body of the response as a JSON object
  /// mapped to [T].
  ///
  /// The Future will emit a [ClientException] if the response doesn't have a
  /// success status code or if the response body can't be read as a json object.
  Future<T> readJson<T>(
    Uri url, {
    Map<String, String>? headers,
    required T Function(Map<String, dynamic>) mapper,
  }) async {
    final response = await get(url, headers: headers);
    _checkResponseSuccess(url, response);
    final json = jsonUtf8Decoder.convert(response.bodyBytes);
    if (json is! Map<String, dynamic>) {
      _logger.severe('Could not read JSON object as $T: expected an object.');
      throw ClientException(
        'Could not read JSON object as $T: expected an object.',
        url,
      );
    }
    try {
      return mapper(json);
    } catch (e, st) {
      _logger.severe('Could not read JSON object as $T: $e', e, st);
      throw ClientException(
        'Could not read JSON object as $T: $e\n$st',
        url,
      );
    }
  }

  /// Sends an HTTP GET request with the given headers to the given URL and
  /// returns a Future that completes to the body of the response as a JSON list
  /// of objects mapped to [T].
  ///
  /// The Future will emit a [ClientException] if the response doesn't have a
  /// success status code or if the response body can't be read as a json list.
  Future<IList<T>> readJsonList<T>(
    Uri url, {
    Map<String, String>? headers,
    required T? Function(Map<String, dynamic>) mapper,
  }) async {
    final response = await get(url, headers: headers);
    _checkResponseSuccess(url, response);
    final json = jsonUtf8Decoder.convert(response.bodyBytes);
    if (json is! List<dynamic>) {
      _logger.severe('Could not read JSON object as List: expected a list.');
      throw ClientException(
        'Could not read JSON object as List: expected a list.',
        url,
      );
    }

    final List<T> list = [];
    for (final e in json) {
      if (e is! Map<String, dynamic>) {
        _logger.severe('Could not read JSON object as $T: expected an object.');
        throw ClientException(
          'Could not read JSON object as $T: expected an object.',
          url,
        );
      }
      try {
        final mapped = mapper(e);
        if (mapped != null) {
          list.add(mapped);
        }
      } catch (e, st) {
        _logger.severe('Could not read JSON object as $T: $e', e, st);
        throw ClientException('Could not read JSON object as $T: $e', url);
      }
    }
    return IList(list);
  }

  /// Sends an HTTP POST request with the given headers and body to the given URL and
  /// returns a Future that completes to the body of the response as a JSON object
  /// mapped to [T].
  ///
  /// The Future will emit a [ClientException] if the response doesn't have a
  /// success status code or if the response body can't be read as a json object.
  Future<T> postReadJson<T>(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    required T Function(Map<String, dynamic>) mapper,
  }) async {
    final response = await post(
      url,
      headers: {
        'Content-Type': 'application/json',
        ...?headers,
      },
      body: body != null ? jsonEncode(body) : null,
      encoding: encoding,
    );
    _checkResponseSuccess(url, response);
    final json = jsonUtf8Decoder.convert(response.bodyBytes);
    if (json is! Map<String, dynamic>) {
      _logger.severe('Could not read json object as $T: expected an object.');
      throw ClientException(
        'Could not read json object as $T: expected an object.',
        url,
      );
    }
    try {
      return mapper(json);
    } catch (e, st) {
      _logger.severe('Could not read json as $T: $e', e, st);
      throw ClientException(
        'Could not read json as $T: $e',
        url,
      );
    }
  }
}

extension ClientWidgetRefExtension on WidgetRef {
  /// Runs [fn] with a [EvoClient].
  Future<T> withClient<T>(Future<T> Function(EvoClient) fn) async {
    final client = read(evoClientProvider);
    return await fn(client);
  }
}

extension ClientRefExtension on Ref {
  /// Runs [fn] with a [EvoClient].
  Future<T> withClient<T>(Future<T> Function(EvoClient) fn) async {
    final client = read(evoClientProvider);
    return await fn(client);
  }

  /// Runs [fn] with a [EvoClient] and keeps the provider alive for [duration].
  ///
  /// This is primarily used for caching network requests in a [FutureProvider].
  ///
  /// If [fn] throws with a [SocketException], the provider is not kept alive, this
  /// allows to retry the request later.
  Future<U> withClientCacheFor<U>(
    Future<U> Function(EvoClient) fn,
    Duration duration,
  ) async {
    final link = keepAlive();
    final timer = Timer(duration, link.close);
    final client = read(evoClientProvider);
    onDispose(() {
      timer.cancel();
    });
    try {
      return await fn(client);
    } on SocketException catch (_) {
      link.close();
      rethrow;
    }
  }
}
