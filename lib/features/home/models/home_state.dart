import 'package:evo/features/home/models/location_statistics_timeline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required DateTime currentDate,
    required AsyncValue<EvoLocationStatisticsTimeline?> timelineData,
  }) = _HomeState;
}
