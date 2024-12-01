import 'package:evo/features/home/location_repository.dart';
import 'package:evo/features/home/models/location_statistics.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentLocationOverview extends ConsumerWidget {
  const CurrentLocationOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final membershipAsync = ref.watch(membershipDetailsProvider);

    return membershipAsync.when(
      data: (membership) {
        final locationId = membership!.location.id;
        final locationStatsAsync =
            ref.watch(currentLocationStatisticsProvider(locationId));

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: locationStatsAsync.when(
            data: (stats) {
              if (stats == null) {
                return Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                );
              }

              final double currentValue = stats.current.toDouble();

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
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
            error: (error, stack) => Center(
              child: Text(
                'Error loading data',
                style: TextStyle(color: colorScheme.onPrimary),
              ),
            ),
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ),
      ),
      error: (error, stack) => Center(
        child: Text(
          'Error loading membership data',
          style: TextStyle(color: colorScheme.onPrimary),
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
    return PieChart(
      PieChartData(
        startDegreeOffset: 270,
        sections: [
          PieChartSectionData(
            value: stats.percentageUsed,
            color: Theme.of(context).colorScheme.primary,
            radius: 50,
            showTitle: false,
          ),
          PieChartSectionData(
            value: 100 - stats.percentageUsed,
            color: Colors.grey.shade300,
            radius: 50,
            showTitle: false,
          ),
        ],
        centerSpaceRadius: 70,
        sectionsSpace: 3,
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
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 24,
            color: colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
