import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WorkoutsOverview extends StatelessWidget {
  const WorkoutsOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Values for the chart
    final double currentValue = 12; // Current value
    final double maxValue = 100; // Maximum range
    final double percentage =
        (currentValue / maxValue) * 100; // Calculate percentage

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
  }
}
