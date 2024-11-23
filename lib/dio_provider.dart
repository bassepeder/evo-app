import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:evo/constants.dart';
import 'package:evo/features/auth/providers/auth_session.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@riverpod
Dio dio(Ref ref) {
  final client = Dio(BaseOptions(baseUrl: kBaseApiUrl));

  client.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final session = ref.read(authSessionProvider);
      if (session != null && !options.headers.containsKey('Authorization')) {
        options.headers['Authorization'] = session.token;
      }

      return handler.next(options);
    },
  ));

  return client;
}

extension ClientRefExtension on Ref {
  /// Runs [fn] with a [Dio].
  Future<T> withClient<T>(Future<T> Function(Dio) fn) async {
    final client = read(dioProvider);
    return await fn(client);
  }

  /// Runs [fn] with a [Dio] and keeps the provider alive for [duration].
  ///
  /// This is primarily used for caching network requests in a [FutureProvider].
  ///
  /// If [fn] throws with a [SocketException], the provider is not kept alive, this
  /// allows to retry the request later.
  Future<U> withClientCacheFor<U>(
    Future<U> Function(Dio) fn,
    Duration duration,
  ) async {
    final link = keepAlive();
    final timer = Timer(duration, link.close);
    final client = read(dioProvider);
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
