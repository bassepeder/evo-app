import 'package:deep_pick/deep_pick.dart';
import 'package:evo/common/id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_statistics.freezed.dart';
part 'location_statistics.g.dart';

@freezed
class EvoLocationStatistics with _$EvoLocationStatistics {
  const EvoLocationStatistics._();

  const factory EvoLocationStatistics({
    required LocationId id,
    required String name,
    required int current,
    required int maxCapacity,
    required double percentageUsed,
  }) = _EvoLocationStatistics;

  factory EvoLocationStatistics.fromJson(Map<String, dynamic> json) =>
      EvoLocationStatistics.fromPick(pick(json).required());

  factory EvoLocationStatistics.fromPick(RequiredPick pick) {
    return EvoLocationStatistics(
      id: pick('id').asLocationIdOrThrow(),
      name: pick('name').asStringOrThrow(),
      current: pick('current').asIntOrThrow(),
      maxCapacity: pick('max_capacity').asIntOrThrow(),
      percentageUsed: pick('percentage_used').asDoubleOrThrow(),
    );
  }
}
