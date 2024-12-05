import 'package:evo/common/id.dart';
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
    final initialLocation = ref.read(membershipDetailsProvider).value!.location;
    return LocationState(
      locationId: initialLocation.id,
      locationName: initialLocation.name,
      timelineDateFilter: DateTime.now(),
      currentLocationData: const AsyncValue.loading(),
      locationTimelineData: const AsyncValue.loading(),
    );
  }

  Future<void> fetchCurrentData() async {
    state = state.copyWith(currentLocationData: const AsyncValue.loading());

    try {
      final data = await ref.read(
        currentLocationStatisticsProvider(
          state.locationId!,
        ).future,
      );

      state = state.copyWith(currentLocationData: AsyncValue.data(data));
    } catch (e, stackTrace) {
      state =
          state.copyWith(currentLocationData: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> fetchTimelineData() async {
    state = state.copyWith(locationTimelineData: const AsyncValue.loading());

    try {
      final data = await ref.read(
        locationStatisticsTimelineProvider(
          state.locationId!,
          state.timelineDateFilter,
        ).future,
      );

      state = state.copyWith(locationTimelineData: AsyncValue.data(data));
    } catch (e, stackTrace) {
      state =
          state.copyWith(locationTimelineData: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> setNewLocation(
    LocationId id,
    String name,
  ) async {
    state = state.copyWith(locationId: id, locationName: name);
    await Future.wait([
      fetchCurrentData(),
      fetchTimelineData(),
    ]);
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
    required LocationId? locationId,
    required String locationName,
    required DateTime timelineDateFilter,
    required AsyncValue<EvoLocationStatistics?> currentLocationData,
    required AsyncValue<EvoLocationStatisticsTimeline?> locationTimelineData,
  }) = _LocationState;
}
