import 'package:evo/common/id.dart';
import 'package:evo/features/home/location_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationOverview extends ConsumerWidget {
  const LocationOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    final locationStatsAsync = ref.watch(locationStatisticsProvider(
        LocationId('034ce5d0-1fe3-4851-a39e-b834def14349')));

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
          final double percentage = stats.percentageUsed;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Antall personer nå inne på',
                style: TextStyle(color: colorScheme.onPrimary),
              ),
              Row(
                children: [
                  Text(
                    stats.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: colorScheme.onPrimary,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 225,
                    child: PieChart(
                      PieChartData(
                        startDegreeOffset: 270,
                        sections: [
                          PieChartSectionData(
                            value: percentage,
                            color: colorScheme.primary,
                            radius: 50,
                            title: '',
                          ),
                          PieChartSectionData(
                            value: 100 - percentage,
                            color: Colors.grey.shade300,
                            radius: 50,
                            title: '',
                          ),
                        ],
                        centerSpaceRadius: 70, // Inner space for text
                        sectionsSpace: 0, // No gap between sections
                      ),
                      duration: const Duration(milliseconds: 150),
                      curve: Curves.linear,
                    ),
                  ),
                  // Central Text
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

    /*
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Antall personer nå inne på',
            style: TextStyle(color: colorScheme.onPrimary),
          ),
          Row(
            children: [
              Text(
                'EVO Strømsø',
                style: TextStyle(
                  fontSize: 24,
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: colorScheme.onPrimary,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: colorScheme.onPrimary,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: percentage,
                        color: colorScheme.primary, // Active segment color
                        radius: 25,
                        title: '',
                      ),
                      PieChartSectionData(
                        value: 100 - percentage,
                        color: Colors.grey.shade300, // Remaining segment color
                        radius: 25,
                        title: '',
                      ),
                    ],
                    centerSpaceRadius: 80, // Inner space for text
                    sectionsSpace: 0, // No gap between sections
                  ),
                  duration: const Duration(milliseconds: 150),
                  // Smooth animation
                  curve: Curves.linear,
                ),
              ),
              // Central Text
              /*
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentValue.toStringAsFixed(0),
                    // Display the current value
                    style: TextStyle(
                      fontSize: 32,
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ER INNE PÅ SENTERET AKKURAT NÅ',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
               */
              Text(
                currentValue.toStringAsFixed(0),
                // Display the current value
                style: TextStyle(
                  fontSize: 32,
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
     */
  }
}
