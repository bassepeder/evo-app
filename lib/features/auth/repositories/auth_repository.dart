import 'package:evo/features/auth/models/auth_response.dart';

abstract interface class AuthRepository {
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  );
}
