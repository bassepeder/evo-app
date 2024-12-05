import 'package:evo/features/home/location_repository.dart';
import 'package:evo/features/home/models/location_statistics.dart';
import 'package:evo/features/home/models/location_statistics_timeline.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_controller.freezed.dart';
part 'location_controller.g.dart';

@riverpod
class LocationController extends _$LocationController {
  @override
  LocationState build() {
    return LocationState(
      timelineDateFilter: DateTime.now(),
      currentLocationData: const AsyncValue.loading(),
      locationTimelineData: const AsyncValue.loading(),
    );
  }

  Future<void> fetchTimelineData() async {
    final locationId = ref.read(membershipDetailsProvider).value!.location.id;
    state = state.copyWith(locationTimelineData: const AsyncValue.loading());

    final data = await ref.read(
      locationStatisticsTimelineProvider(
        locationId,
        state.timelineDateFilter,
      ).future,
    );
    state = state.copyWith(locationTimelineData: AsyncValue.data(data));
  }

  void goToNextDay() {
    final nextDay = state.timelineDateFilter.add(const Duration(days: 1));
    state = state.copyWith(timelineDateFilter: nextDay);
    fetchTimelineData();
  }

  void goToPreviousDay() {
    final prevDay = state.timelineDateFilter.subtract(const Duration(days: 1));
    state = state.copyWith(timelineDateFilter: prevDay);
    fetchTimelineData();
  }
}

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    required DateTime timelineDateFilter,
    required AsyncValue<EvoLocationStatistics?> currentLocationData,
    required AsyncValue<EvoLocationStatisticsTimeline?> locationTimelineData,
  }) = _LocationState;
}
