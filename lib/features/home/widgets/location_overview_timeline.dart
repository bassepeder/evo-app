import 'package:evo/features/home/location_repository.dart';
import 'package:evo/features/membership/membership_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationOverviewTimeline extends ConsumerWidget {
  const LocationOverviewTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final membershipAsync = ref.watch(membershipDetailsProvider);

    return membershipAsync.when(
      data: (membership) {
        final locationId = membership!.location.id;
        final timelineAsync =
            ref.watch(locationStatisticsTimelineProvider(locationId));

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
          child: timelineAsync.when(
            data: (timeline) {
              if (timeline == null) {
                return Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forvented besøk hos',
                    style: TextStyle(color: colorScheme.onPrimary),
                  ),
                  Text(
                    timeline.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 225,
                    child: BarChart(
                      BarChartData(
                        maxY: 100,
                        barGroups:
                            timeline.intervals.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          final isCurrent = item.status == 'current';

                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: item.percentageUsed,
                                // Filled percentage
                                width: 20,
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(5)),
                                color: isCurrent
                                    ? colorScheme.primary
                                        .withGreen(1)
                                        .withOpacity(0.9)
                                    : colorScheme.primary,
                                // Highlight current bar
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 100,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index >= 0 &&
                                    index < timeline.intervals.length) {
                                  return Text(
                                    timeline.intervals[index].name,
                                    // Display time (e.g., "06-10")
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                              reservedSize: 24,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        barTouchData: BarTouchData(
                          enabled: true,
                          touchTooltipData: BarTouchTooltipData(
                            getTooltipColor: (_) =>
                                Colors.black.withOpacity(0.75),
                            getTooltipItem: (group, groupIndex, rod, rodIndex) {
                              final interval =
                                  timeline.intervals[group.x.toInt()];
                              return BarTooltipItem(
                                '${interval.percentageUsed.toStringAsFixed(1)}%',
                                const TextStyle(color: Colors.white),
                              );
                            },
                          ),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                ],
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
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
        child: CircularProgressIndicator(),
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
