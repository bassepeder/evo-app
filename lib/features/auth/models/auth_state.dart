import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool loading,
    @Default(false) bool success,
    @Default('') String email,
    @Default('') String password,
    @Default(null) Exception? error,
  }) = _AuthState;
}
