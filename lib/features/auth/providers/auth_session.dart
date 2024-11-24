import 'package:evo/common/preloaded_data.dart';
import 'package:evo/features/auth/session_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

@Riverpod(keepAlive: true)
class AuthSession extends _$AuthSession {
  @override
  AuthSessionState? build() {
    return ref.read(preloadedDataProvider).requireValue.userSession;
  }

  Future<void> update(AuthSessionState session) async {
    final sessionStorage = ref.read(sessionStorageProvider);
    await sessionStorage.write(session);
    state = session;
  }

  Future<void> delete() async {
    final sessionStorage = ref.read(sessionStorageProvider);
    await sessionStorage.delete();
    state = null;
  }
}

@Freezed(fromJson: true, toJson: true)
class AuthSessionState with _$AuthSessionState {
  const factory AuthSessionState({
    required String token,
    required String email,
    required String password,
  }) = _AuthSessionState;

  factory AuthSessionState.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionStateFromJson(json);
}
