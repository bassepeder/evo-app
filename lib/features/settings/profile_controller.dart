import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/features/membership/models/membership_details.dart';
import 'package:evo/features/settings/models/update_profile_details_request.dart';
import 'package:evo/features/settings/profile_repository.dart';
import 'package:evo/network/http.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.freezed.dart';
part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  ProfileState build() {
    final membership = getMembershipDetails();

    return ProfileState(
      email: membership.profile.email,
      address: membership.profile.address,
      isLoading: false,
      hasChanged: false,
      success: false,
      error: null,
    );
  }

  Future<void> updateProfileDetails() async {
    state = state.copyWith(
      isLoading: true,
      success: false,
      error: null,
    );

    try {
      final request = UpdateProfileDetailsRequest(
        firstName: 'Bastian',
        lastName: 'Tangedal Pedersen',
        email: state.email,
        address: state.address,
        mobile: const Mobile(number: '45472336', prefix: '+47'),
      );

      await ref.withClient(
        (client) => ProfileRepository(client).updateProfileDetails(request),
      );

      state = state.copyWith(
        isLoading: false,
        hasChanged: false,
        success: true,
      );

      ref.invalidate(membershipDetailsProvider);

      state = state.copyWith(
        success: false,
      );
    } on Exception catch (e) {
      state = state.copyWith(error: e);
    }
  }

  void updateEmail(String email) {
    state = state.copyWith(
      email: email.trim(),
      hasChanged: email.trim() != getMembershipDetails().profile.email.trim(),
    );
  }

  void updateStreetAddress(String address) {
    state = state.copyWith(
      address: Address(
        street: address.trim(),
        postalLocation: state.address.postalLocation.trim(),
        postalCode: state.address.postalCode.trim(),
      ),
      hasChanged:
          address != getMembershipDetails().profile.address.street.trim(),
    );
  }

  void updateCity(String city) {
    state = state.copyWith(
      address: Address(
        street: state.address.street.trim(),
        postalLocation: city.trim(),
        postalCode: state.address.postalCode.trim(),
      ),
      hasChanged: city.trim() !=
          getMembershipDetails().profile.address.postalLocation.trim(),
    );
  }

  void updatePostalCode(String code) {
    state = state.copyWith(
      address: Address(
        street: state.address.street.trim(),
        postalLocation: state.address.postalLocation.trim(),
        postalCode: code.trim(),
      ),
      hasChanged: code.trim() !=
          getMembershipDetails().profile.address.postalCode.trim(),
    );
  }

  MembershipDetails getMembershipDetails() =>
      ref.read(membershipDetailsProvider).requireValue!;
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required String email,
    required Address address,
    required bool isLoading,
    required bool hasChanged,
    required bool success,
    required Exception? error,
  }) = _ProfileState;
}
