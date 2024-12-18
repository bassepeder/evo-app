import 'package:evo/features/home/models/location_statistics_timeline.dart';
import 'package:evo/features/home/viewmodels/location_controller.dart';
import 'package:evo/features/settings/brightness.dart';
import 'package:evo/i18n/translations.g.dart';
import 'package:evo/utils/formatting.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationVisitsTimeline extends ConsumerWidget {
  const LocationVisitsTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final brightness = ref.watch(currentBrightnessProvider);
    final locationState = ref.watch(locationControllerProvider);
    final dateToDisplay = ref.watch(
      locationControllerProvider.select((state) => state.timelineDateFilter),
    );

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: locationState.locationTimelineData.when(
        skipLoadingOnRefresh: false,
        data: (timeline) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(
                name: timeline!.name,
                date: dateToDisplay,
                onBackClicked: () {
                  HapticFeedback.mediumImpact();
                  ref
                      .read(locationControllerProvider.notifier)
                      .goToPreviousDay();
                },
                onForwardClicked: () {
                  HapticFeedback.mediumImpact();
                  ref.read(locationControllerProvider.notifier).goToNextDay();
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 225,
                child: Chart(
                  intervals: timeline.intervals,
                  isDarkMode: brightness == Brightness.dark,
                ),
              ),
            ],
          );
        },
        loading: () {
          return SizedBox(
            width: double.infinity,
            height: 225,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Header(
                  name: ref.read(locationControllerProvider).locationName,
                  date: dateToDisplay,
                  onBackClicked: () {},
                  onForwardClicked: () {},
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: colorScheme.primary,
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ],
            ),
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
  final List<LocationStatisticsTimelineEntry> intervals;
  final bool isDarkMode;

  const Chart({
    super.key,
    required this.intervals,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BarChart(
      BarChartData(
        maxY: 100,
        barGroups: intervals.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isCurrent = item.status == 'current';
          final isHistoric = item.status == 'historic';
          final barColor = _getBarColor(
            colorScheme,
            isCurrent,
            isHistoric,
            isDarkMode,
          );

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: item.percentageUsed > 100 ? 100 : item.percentageUsed,
                width: 40,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                color: barColor,
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
                if (index >= 0 && index < intervals.length) {
                  return Text(
                    intervals[index].name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
              reservedSize: 20,
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (_) => Colors.black.withOpacity(0.75),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final interval = intervals[group.x];
              return BarTooltipItem(
                '${intervals[group.x].name}\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${interval.percentageUsed.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      color: Colors.white, //widget.touchedBarColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}

Color _getBarColor(
  ColorScheme colorScheme,
  bool isCurrent,
  bool isHistoric,
  bool isDarkMode,
) {
  if (isCurrent) {
    return colorScheme.primary;
  }

  if (isHistoric) {
    return isDarkMode
        ? colorScheme.surfaceContainerHigh.withValues(alpha: 0.7)
        : colorScheme.onSurface.withValues(alpha: 0.4);
  }

  // Future bars
  return colorScheme.primary.withValues(alpha: 0.6);
}

class Header extends StatelessWidget {
  final String name;
  final DateTime date;
  final VoidCallback onBackClicked;
  final VoidCallback onForwardClicked;

  const Header({
    super.key,
    required this.name,
    required this.date,
    required this.onBackClicked,
    required this.onForwardClicked,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFilterIsFromYesterdayOrOlder =
        DateTime(date.year, date.month, date.day).isBefore(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                dateFilterIsFromYesterdayOrOlder
                    ? context.t.homeScreen.oldLocationTimelineTitle(
                        formattedDate: TextSpan(
                          text: formatDateTime(date),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      )
                    : context.t.homeScreen.presentOrFutureLocationTimelineTitle(
                        formattedDate: TextSpan(
                          text: formatDateTime(date),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1, // Truncate the text
                style: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 24,
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onBackClicked,
          icon: const Icon(Icons.arrow_back_ios),
          color: Theme.of(context).iconTheme.color,
        ),
        IconButton(
          onPressed: onForwardClicked,
          icon: const Icon(Icons.arrow_forward_ios),
          color: Theme.of(context).iconTheme.color,
        ),
      ],
    );
  }
}
