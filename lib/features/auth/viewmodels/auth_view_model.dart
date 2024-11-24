import 'package:evo/common/exceptions/http_exceptions.dart';
import 'package:evo/features/auth/models/auth_state.dart';
import 'package:evo/features/auth/providers/auth_session.dart';
import 'package:evo/features/auth/repositories/auth_repository_impl.dart';
import 'package:evo/network/http.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AuthState build() {
    return const AuthState();
  }

  Future<void> signIn() async {
    state = state.copyWith(
      loading: true,
      error: null,
    );

    try {
      final response = await ref.withClient(
        (client) => AuthRepositoryImpl(client).signInWithEmailAndPassword(
          state.email.trim(),
          state.password.trim(),
        ),
      );

      final session = AuthSessionState(
        token: response.token,
        email: state.email,
        password: state.password,
      );
      await ref.read(authSessionProvider.notifier).update(session);

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
