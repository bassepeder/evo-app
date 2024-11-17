import 'package:riverpod/riverpod.dart';

import '../models/auth_state.dart';
import '../repositories/auth_repository.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthViewModel(this._authRepository) : super(const AuthState());

  Future<void> signIn() async {
    state = state.copyWith(
      loading: true,
      errorMessage: null,
    );

    try {
      await Future.delayed(Duration(seconds: 5));
      final response = await _authRepository.signInWithEmailAndPassword(
        state.email,
        state.password,
      );

      // Update state with the new token and set loading to false
      state = state.copyWith(
        success: true,
        loading: false,
        errorMessage: '',
      );

      // Optionally, you can save the token to SharedPreferences or use another state management strategy
    } catch (e) {
      state = state.copyWith(
        loading: false,
        errorMessage: e.toString(),
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
