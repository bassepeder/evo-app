import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/features/membership/models/membership_details.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.freezed.dart';
part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  ProfileState build() {
    final membership = ref.read(membershipDetailsProvider).requireValue!;

    return ProfileState(
      email: membership.profile.email,
      address: membership.profile.address,
    );
  }
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required String email,
    required Address address,
  }) = _ProfileState;
}
