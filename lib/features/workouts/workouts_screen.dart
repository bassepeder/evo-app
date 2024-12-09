import 'dart:math';

import 'package:evo/common/widgets/error_screen.dart';
import 'package:evo/features/workouts/models/membership_workouts_statistics.dart';
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Header(totalWorkouts: statistics.totalWorkouts),
                    const SizedBox(height: 32),
                    HorizontalBarChart(workoutMonths: statistics.months),
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

class Header extends StatelessWidget {
  final int totalWorkouts;

  const Header({required this.totalWorkouts});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
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
              text: totalWorkouts.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalBarChart extends StatelessWidget {
  final List<WorkoutMonth> workoutMonths;

  const HorizontalBarChart({required this.workoutMonths});

  static const workoutCountTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget build(BuildContext context) {
    // Get the maximum workouts count
    final int highestWorkouts = workoutMonths.isEmpty
        ? 0
        : workoutMonths
            .map((e) => e.totalWorkouts)
            .reduce((a, b) => a > b ? a : b);

    final sortedByWorkoutDate = List<WorkoutMonth>.from(workoutMonths)
      ..sort((a, b) {
        // First compare by year, and if they are equal, compare by month.
        if (a.year != b.year) {
          return b.year.compareTo(a.year);
        } else {
          return b.month.compareTo(a.month);
        }
      });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedByWorkoutDate.map((month) {
        final double percent = month.totalWorkouts.toDouble();

        // Get the month label text to calculate its width
        final monthLabel = _monthLabel(context, month.month);
        final double monthLabelWidth = _getTextWidth(context, monthLabel);

        // Ensure a minimum width for the bar (60px), and add space for the month name
        final double barWidth = max(
          60.0 + monthLabelWidth + 20.0,
          highestWorkouts == 0
              ? 0
              : (percent / highestWorkouts) * MediaQuery.of(context).size.width,
        );

        return Container(
          width: barWidth,
          height: 35.0,
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: percent == highestWorkouts
                ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                : Theme.of(context).colorScheme.primary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                monthLabel,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              Text(
                '${month.totalWorkouts} økter',
                style: workoutCountTextStyle,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _monthLabel(BuildContext context, int month) {
    final months = [
      context.t.workoutsScreen.months[0],
      context.t.workoutsScreen.months[1],
      context.t.workoutsScreen.months[2],
      context.t.workoutsScreen.months[3],
      context.t.workoutsScreen.months[4],
      context.t.workoutsScreen.months[5],
      context.t.workoutsScreen.months[6],
      context.t.workoutsScreen.months[7],
      context.t.workoutsScreen.months[8],
      context.t.workoutsScreen.months[9],
      context.t.workoutsScreen.months[10],
      context.t.workoutsScreen.months[11],
    ];

    return months[month - 1];
  }

  double _getTextWidth(BuildContext context, String text) {
    final textSpan = TextSpan(text: text, style: workoutCountTextStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }
}
