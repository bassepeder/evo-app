import 'package:dio/dio.dart';
import 'package:evo/constants.dart';
import 'package:riverpod/riverpod.dart';

final httpClientProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: kBaseApiUrl));

  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // Assuming you have a way to get the token (e.g., from a Riverpod provider or a storage solution)
      /*
      final authToken = await ref.read(authTokenProvider
          .future); // Replace with actual token retrieval logic
       */
      var authToken = 'hello';
      if (authToken != null && authToken.isNotEmpty) {
        options.headers['Authorization'] = authToken;
      }
      return handler.next(options);
    },
  ));

  return dio;
});
