import 'package:evo/common/exceptions/http_exceptions.dart';
import 'package:evo/features/auth/models/auth_response.dart';
import 'package:evo/network/http.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final EvoClient _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _client.postReadJson(
        evoUri('api/v1/auth/authenticate'),
        body: {
          'username': email,
          'password': password,
        },
        mapper: AuthResponse.fromJson,
      );
    } on ServerException catch (e) {
      if (e.statusCode == 401) {
        throw InvalidCredentialsException();
      } else {
        throw ServerErrorException();
      }
    }
  }
}
