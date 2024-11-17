import 'package:evo/features/auth/providers/auth_repository_provider.dart';
import 'package:evo/features/auth/viewmodels/auth_view_model.dart';
import 'package:riverpod/riverpod.dart';

import '../models/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return AuthViewModel(authRepository);
});
