import 'dart:convert';

import 'package:evo/common/id.dart';
import 'package:evo/features/membership/models/current_membership_referral.dart';
import 'package:evo/features/membership/models/membership_details.dart';
import 'package:evo/features/settings/models/update_primary_location_request.dart';
import 'package:evo/network/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'membership_repository.g.dart';

@riverpod
Future<MembershipDetails> membershipDetails(Ref ref) async {
  /*
  final session = ref.watch(authSessionProvider);
  if (session == null) return null;
   */

  return ref.withClient(
    (client) => MembershipRepository(client).getMembershipDetails(),
  );
}

@riverpod
Future<CurrentMembershipReferral> currentMembershipReferral(Ref ref) async {
  return ref.withClientCacheFor(
    (client) => MembershipRepository(client).getCurrentMembershipReferral(),
    const Duration(days: 1),
  );
}

class MembershipRepository {
  MembershipRepository(this.client);

  final EvoClient client;

  Future<MembershipDetails> getMembershipDetails() {
    return client.readJson(
      evoUri('api/v1/membership'),
      mapper: MembershipDetails.fromServerJson,
    );
  }

  Future<CurrentMembershipReferral> getCurrentMembershipReferral() {
    return client.readJson(
      evoUri('api/v1/membership/current-referral'),
      mapper: CurrentMembershipReferral.fromServerJson,
    );
  }

  Future<void> updatePrimaryLocation(LocationId id) {
    return client.put(
      evoUri('api/v1/membership/update-location'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(UpdatePrimaryLocationRequest(locationId: id).toJson()),
    );
  }
}
