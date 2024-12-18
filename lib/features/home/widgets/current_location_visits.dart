import 'package:evo/features/home/models/location_statistics.dart';
import 'package:evo/features/home/viewmodels/location_controller.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentLocationVisits extends ConsumerWidget {
  const CurrentLocationVisits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final locationState = ref.watch(locationControllerProvider);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: locationState.currentLocationData.when(
        skipLoadingOnRefresh: false,
        data: (stats) {
          final double currentValue = stats!.current.toDouble();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(name: stats.name),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 225,
                    child: Chart(stats: stats),
                  ),
                  Text(
                    currentValue.toStringAsFixed(0),
                    style: TextStyle(
                      fontSize: 32,
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                name: ref.read(locationControllerProvider).locationName,
              ),
              const SizedBox(height: 20),
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  strokeWidth: 3,
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
        error: (error, stack) => Center(
          child: Text(
            context.t.errors.failedToLoadLocationData,
            style: TextStyle(color: colorScheme.onSurface),
          ),
        ),
      ),
    );
  }
}

class Chart extends StatelessWidget {
  final EvoLocationStatistics stats;

  const Chart({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return PieChart(
      PieChartData(
        startDegreeOffset: 270,
        sections: [
          PieChartSectionData(
            value: stats.percentageUsed,
            color: colorScheme.primary,
            radius: 50,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 100 - stats.percentageUsed,
            color: colorScheme.surfaceContainerHighest,
            radius: 50,
            showTitle: false,
          ),
        ],
        centerSpaceRadius: 70,
      ),
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
  }
}

class Header extends StatelessWidget {
  final String name;

  const Header({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.t.homeScreen.currentLocationStatisticsTitle,
          style: TextStyle(
            fontSize: 14,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            fontSize: 24,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
