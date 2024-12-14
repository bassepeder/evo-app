import 'package:deep_pick/deep_pick.dart';
import 'package:evo/common/id.dart';
import 'package:evo/common/pick.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'evo_location.freezed.dart';
part 'evo_location.g.dart';

@freezed
class EvoLocation with _$EvoLocation {
  const EvoLocation._();

  const factory EvoLocation({
    required LocationId id,
    required String name,
    required String street,
    required DateTime openingDate,
    required DateTime? closingDate,
  }) = _EvoLocation;

  factory EvoLocation.fromJson(Map<String, dynamic> json) =>
      EvoLocation.fromPick(pick(json).required());

  factory EvoLocation.fromPick(RequiredPick pick) {
    return EvoLocation(
      id: pick('id').asLocationIdOrThrow(),
      name: pick('name').asStringOrThrow(),
      street: pick('street').asStringOrThrow(),
      openingDate: pick('opening_date').asDateOrThrow(),
      closingDate: pick('closing_date').asDateOrNull(),
    );
  }
}
