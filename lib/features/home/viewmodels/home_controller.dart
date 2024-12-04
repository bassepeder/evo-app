import 'package:evo/features/home/location_repository.dart';
import 'package:evo/features/home/models/location_statistics_timeline.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.freezed.dart';
part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  HomeState build() {
    return HomeState(
      timelineOverviewDateFilter: DateTime.now(),
      timelineData: const AsyncValue.loading(),
    );
  }

  Future<void> fetchTimelineData() async {
    final locationId = ref.read(membershipDetailsProvider).value!.location.id;
    state = state.copyWith(timelineData: const AsyncValue.loading());

    final data = await ref.read(
      locationStatisticsTimelineProvider(
        locationId,
        state.timelineOverviewDateFilter,
      ).future,
    );
    state = state.copyWith(timelineData: AsyncValue.data(data));
  }

  void goToNextDay() {
    final nextDay =
        state.timelineOverviewDateFilter.add(const Duration(days: 1));
    state = state.copyWith(timelineOverviewDateFilter: nextDay);
    fetchTimelineData();
  }

  void goToPreviousDay() {
    final prevDay =
        state.timelineOverviewDateFilter.subtract(const Duration(days: 1));
    state = state.copyWith(timelineOverviewDateFilter: prevDay);
    fetchTimelineData();
  }
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required DateTime timelineOverviewDateFilter,
    required AsyncValue<EvoLocationStatisticsTimeline?> timelineData,
  }) = _HomeState;
}
