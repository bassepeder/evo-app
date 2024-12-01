import 'package:deep_pick/deep_pick.dart';
import 'package:evo/common/id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_statistics_timeline.freezed.dart';
part 'location_statistics_timeline.g.dart';

@freezed
class EvoLocationStatisticsTimeline with _$EvoLocationStatisticsTimeline {
  const EvoLocationStatisticsTimeline._();

  const factory EvoLocationStatisticsTimeline({
    required LocationId id,
    required String name,
    required List<LocationStatisticsTimelineEntry> intervals,
  }) = _EvoLocationStatisticsTimeline;

  factory EvoLocationStatisticsTimeline.fromJson(Map<String, dynamic> json) =>
      EvoLocationStatisticsTimeline.fromPick(pick(json).required());

  factory EvoLocationStatisticsTimeline.fromPick(RequiredPick pick) {
    return EvoLocationStatisticsTimeline(
      id: pick('id').asLocationIdOrThrow(),
      name: pick('name').asStringOrThrow(),
      intervals: pick('intervals').asListOrEmpty(
        (interval) => LocationStatisticsTimelineEntry.fromPick(
          interval.required(),
        ),
      ),
    );
  }
}

@freezed
class LocationStatisticsTimelineEntry with _$LocationStatisticsTimelineEntry {
  const LocationStatisticsTimelineEntry._();

  const factory LocationStatisticsTimelineEntry({
    required String name,
    required int begin,
    required int end,
    required int maxCapacity,
    required double percentageUsed,
  }) = _LocationStatisticsTimelineEntry;

  factory LocationStatisticsTimelineEntry.fromJson(Map<String, dynamic> json) =>
      _$LocationStatisticsTimelineEntryFromJson(json);

  factory LocationStatisticsTimelineEntry.fromPick(RequiredPick pick) {
    return LocationStatisticsTimelineEntry(
      name: pick('name').asStringOrThrow(),
      begin: pick('begin').asIntOrThrow(),
      end: pick('end').asIntOrThrow(),
      maxCapacity: pick('max_capacity').asIntOrThrow(),
      percentageUsed: pick('percentage_used').asDoubleOrThrow(),
    );
  }
}
