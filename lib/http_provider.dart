import 'package:dio/dio.dart';
import 'package:evo/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final httpClientProvider = Provider<Dio>((ref) {
  final client = Dio(BaseOptions(baseUrl: kBaseApiUrl));

  client.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      /*
      final authToken = await ref.read(authTokenProvider
          .future); // Replace with actual token retrieval logic
      var authToken = 'hello';
      if (authToken != null && authToken.isNotEmpty) {
        options.headers['Authorization'] = authToken;
      }

       */
      return handler.next(options);
    },
  ));

  return client;
});
