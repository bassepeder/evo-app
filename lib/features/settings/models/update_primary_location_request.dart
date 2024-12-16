import 'package:evo/common/id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_primary_location_request.freezed.dart';
part 'update_primary_location_request.g.dart';

@freezed
class UpdatePrimaryLocationRequest with _$UpdatePrimaryLocationRequest {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UpdatePrimaryLocationRequest({
    required LocationId locationId,
  }) = _UpdatePrimaryLocationRequest;

  factory UpdatePrimaryLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePrimaryLocationRequestFromJson(json);
}
