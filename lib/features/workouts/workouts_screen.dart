import 'package:evo/common/widgets/error_screen.dart';
import 'package:evo/features/workouts/workouts_controller.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutsScreen extends ConsumerWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workoutsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.workoutsScreen.appBar),
        centerTitle: true,
      ),
      body: state.workoutStatistics.when(
        data: (statistics) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text: '${context.t.workoutsScreen.subtitle}\n',
                          ),
                          context.t.workoutsScreen.title(
                            totalWorkoutsCount: TextSpan(
                              text: statistics.totalWorkouts.toString(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, _) {
          return SafeArea(
            child: Expanded(
              child: ErrorScreen(
                subtitle: context.t.errors.failedToLoadMembershipError,
                onRetryClicked: () =>
                    ref.invalidate(workoutsControllerProvider),
              ),
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          );
        },
      ),
    );
  }
}
