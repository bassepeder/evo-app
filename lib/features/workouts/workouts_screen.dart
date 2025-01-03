import 'dart:collection';
import 'dart:math';

import 'package:evo/common/widgets/error_screen.dart';
import 'package:evo/features/settings/brightness.dart';
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
    final isDarkMode = ref.watch(
      currentBrightnessProvider
          .select((brightness) => brightness == Brightness.dark),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(context.t.workoutsScreen.appBar),
        centerTitle: true,
      ),
      body: state.workoutStatistics.when(
        data: (statistics) {
          final groupedMonths = <int, List<WorkoutMonth>>{};
          for (final month in statistics.months.where(
            (m) => m.totalWorkouts > 0,
          )) {
            groupedMonths.putIfAbsent(month.year, () => []).add(month);
          }

          final sortedGroupedMonths = LinkedHashMap.fromEntries(
            groupedMonths.entries.toList()
              ..sort((a, b) => b.key.compareTo(a.key)),
          );

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
                    ...sortedGroupedMonths.entries
                        .toList()
                        .asMap()
                        .entries
                        .map((entry) {
                      final int index = entry.key;
                      final int year = entry.value.key;
                      final List<WorkoutMonth> months = entry.value.value;
                      final bool isLast =
                          index == groupedMonths.entries.length - 1;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            year.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          HorizontalBarChart(
                            workoutMonths: months,
                            isDarkMode: isDarkMode,
                          ),
                          if (!isLast) const SizedBox(height: 32),
                        ],
                      );
                    }),
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
                subtitle: context.t.errors.failedToLoadWorkoutStatistics,
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
    final randomEncouragement = context.t.workoutsScreen.encouragements[
        Random().nextInt(context.t.workoutsScreen.encouragements.length)];

    return Text.rich(
      TextSpan(
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: 16,
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
            n: totalWorkouts,
          ),
          if (totalWorkouts > 0)
            TextSpan(
              text: '... $randomEncouragement 💪',
            ),
        ],
      ),
    );
  }
}

class HorizontalBarChart extends StatelessWidget {
  final List<WorkoutMonth> workoutMonths;
  final bool isDarkMode;

  const HorizontalBarChart({
    required this.workoutMonths,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
              : (percent / highestWorkouts) * MediaQuery.sizeOf(context).width,
        );

        return Container(
          width: barWidth,
          height: 35.0,
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: percent == highestWorkouts
                ? colorScheme.primary.withValues(alpha: 0.8)
                : colorScheme.primary
                    .withValues(alpha: isDarkMode ? 0.65 : 0.5),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                monthLabel,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                ),
              ),
              Text.rich(
                context.t.workoutsScreen.monthStatisticBar(
                  workoutsCount: TextSpan(
                    text: month.totalWorkouts.toString(),
                  ),
                  n: month.totalWorkouts,
                ),
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
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
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    return textPainter.width;
  }
}
