import 'package:deep_pick/deep_pick.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'membership_workouts_statistics.freezed.dart';
part 'membership_workouts_statistics.g.dart';

@freezed
class MembershipWorkoutsStatistics with _$MembershipWorkoutsStatistics {
  const MembershipWorkoutsStatistics._();

  const factory MembershipWorkoutsStatistics({
    required int totalWorkouts,
    required List<WorkoutMonth> months,
  }) = _MembershipWorkoutsStatistics;

  factory MembershipWorkoutsStatistics.fromJson(Map<String, dynamic> json) =>
      MembershipWorkoutsStatistics.fromPick(pick(json).required());

  factory MembershipWorkoutsStatistics.fromPick(RequiredPick pick) {
    return MembershipWorkoutsStatistics(
      totalWorkouts: pick('total_workouts').asIntOrThrow(),
      months: pick('workout_months').asListOrEmpty(
        (month) => WorkoutMonth.fromPick(
          month.required(),
        ),
      ),
    );
  }
}

@freezed
class WorkoutMonth with _$WorkoutMonth {
  const WorkoutMonth._();

  const factory WorkoutMonth({
    required int totalWorkouts,
    required int year,
    required int month,
  }) = _WorkoutMonth;

  factory WorkoutMonth.fromJson(Map<String, dynamic> json) =>
      WorkoutMonth.fromPick(pick(json).required());

  factory WorkoutMonth.fromPick(RequiredPick pick) {
    return WorkoutMonth(
      totalWorkouts: pick('total_workouts').asIntOrThrow(),
      year: pick('year').asIntOrThrow(),
      month: pick('month').asIntOrThrow(),
    );
  }
}
