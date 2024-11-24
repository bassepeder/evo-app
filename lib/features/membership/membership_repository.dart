import 'package:evo/features/auth/providers/auth_session.dart';
import 'package:evo/features/membership/models/membership_details.dart';
import 'package:evo/network/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_repository.g.dart';

@riverpod
Future<MembershipDetails?> membershipDetails(Ref ref) async {
  final session = ref.watch(authSessionProvider);
  if (session == null) return null;

  return ref.withClientCacheFor(
    (client) => MembershipRepository(client).getMembershipDetails(),
    const Duration(hours: 1),
  );
}

class MembershipRepository {
  MembershipRepository(this.client);

  final EvoClient client;
  final Logger _log = Logger('MembershipRepository');

  Future<MembershipDetails> getMembershipDetails() {
    return client.readJson(
      evoUri('api/v1/membership'),
      mapper: MembershipDetails.fromServerJson,
    );
  }
}
