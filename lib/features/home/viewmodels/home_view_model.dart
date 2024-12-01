import 'package:evo/features/home/location_repository.dart';
import 'package:evo/features/home/models/home_state.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    return HomeState(
      currentDate: DateTime.now(),
      timelineData: const AsyncValue.loading(),
    );
  }

  Future<void> fetchTimelineData() async {
    final locationId = ref.read(membershipDetailsProvider).value!.location.id;
    state = state.copyWith(timelineData: const AsyncValue.loading());

    final data = await ref.read(
      locationStatisticsTimelineProvider(locationId, state.currentDate).future,
    );
    state = state.copyWith(timelineData: AsyncValue.data(data));
  }

  void goToNextDay() {
    final nextDay = state.currentDate.add(const Duration(days: 1));
    state = state.copyWith(currentDate: nextDay);
    fetchTimelineData();
  }

  void goToPreviousDay() {
    final prevDay = state.currentDate.subtract(const Duration(days: 1));
    state = state.copyWith(currentDate: prevDay);
    fetchTimelineData();
  }
}
