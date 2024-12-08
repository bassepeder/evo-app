import 'package:evo/features/workouts/models/membership_workouts_statistics.dart';
import 'package:evo/features/workouts/workouts_repository.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workouts_controller.freezed.dart';
part 'workouts_controller.g.dart';

@riverpod
class WorkoutsController extends _$WorkoutsController {
  @override
  WorkoutsState build() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchStatistics();
    });

    return const WorkoutsState(workoutStatistics: AsyncLoading());
  }

  Future<void> fetchStatistics() async {
    state = state.copyWith(workoutStatistics: const AsyncValue.loading());

    try {
      final data = await ref.read(getWorkoutStatisticsProvider.future);

      state = state.copyWith(workoutStatistics: AsyncValue.data(data));
    } catch (e, stackTrace) {
      state =
          state.copyWith(workoutStatistics: AsyncValue.error(e, stackTrace));
    }
  }
}

@freezed
class WorkoutsState with _$WorkoutsState {
  const factory WorkoutsState({
    required AsyncValue<MembershipWorkoutsStatistics> workoutStatistics,
  }) = _WorkoutsState;
}
