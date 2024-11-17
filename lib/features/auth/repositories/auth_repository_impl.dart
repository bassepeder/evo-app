import 'package:dio/dio.dart';
import 'package:evo/features/auth/models/auth_response.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final response = await _client.post(
      'api/v1/auth/authenticate',
      data: {
        'username': email,
        'password': password,
      },
    );

    return AuthResponse.fromJson(response.data);
  }
}
