import 'package:evo/features/membership/models/membership_details.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_profile_details_request.freezed.dart';
part 'update_profile_details_request.g.dart';

@freezed
class UpdateProfileDetailsRequest with _$UpdateProfileDetailsRequest {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UpdateProfileDetailsRequest({
    required String firstName,
    required String lastName,
    required String email,
    required Address address,
    required Mobile mobile,
  }) = _UpdateProfileDetailsRequest;

  factory UpdateProfileDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileDetailsRequestFromJson(json);
}
