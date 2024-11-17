import 'package:evo/http_provider.dart';
import 'package:riverpod/riverpod.dart';

import '../repositories/auth_repository.dart';
import '../repositories/auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.read(httpClientProvider);
  return AuthRepositoryImpl(client);
});
