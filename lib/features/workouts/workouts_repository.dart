import 'package:evo/features/workouts/models/membership_workouts_statistics.dart';
import 'package:evo/network/http.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'workouts_repository.g.dart';

@riverpod
Future<MembershipWorkoutsStatistics> getWorkoutStatistics(Ref ref) async =>
    ref.withClientCacheFor(
      (client) => WorkoutsRepository(client).getWorkoutStatistics(),
      const Duration(hours: 1),
    );

class WorkoutsRepository {
  WorkoutsRepository(this.client);

  final EvoClient client;

  Future<MembershipWorkoutsStatistics> getWorkoutStatistics() async {
    return client.readJson(
      evoUri('api/v1/workouts'),
      mapper: MembershipWorkoutsStatistics.fromJson,
    );
  }
}
