import 'dart:convert';

import 'package:evo/features/settings/models/update_profile_details_request.dart';
import 'package:evo/network/http.dart';

class ProfileRepository {
  ProfileRepository(this.client);

  final EvoClient client;

  Future<void> updateProfileDetails(UpdateProfileDetailsRequest request) async {
    final response = await client.patch(
      evoUri('api/v1/membership/profile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile details');
    }
  }

  Future<void> updateProfileGdprConsent(bool hasConsent) async {
    final response = await client.put(
      evoUri('api/v1/membership/profile/gdpr'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'opt_in': hasConsent,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile GDPR consent');
    }
  }
}
