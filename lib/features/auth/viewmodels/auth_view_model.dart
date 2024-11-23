import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/exceptions/http_exceptions.dart';
import '../models/auth_state.dart';
import '../repositories/auth_repository.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(const AuthState());

  Future<void> signIn() async {
    state = state.copyWith(
      loading: true,
      error: null,
    );

    try {
      final response = await _authRepository.signInWithEmailAndPassword(
        state.email,
        state.password,
      );

      state = state.copyWith(
        success: true,
        loading: false,
        error: null,
      );
    } on InvalidCredentialsException {
      state = state.copyWith(
        success: false,
        loading: false,
        error: InvalidCredentialsException(),
      );
    } catch (e) {
      state = state.copyWith(
        success: false,
        loading: false,
        error: ServerErrorException(),
      );
    }
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }
}
