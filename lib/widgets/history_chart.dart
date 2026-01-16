import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../res/colors.dart';
import '../view_models/history_controller.dart';

class HistoryChart extends StatelessWidget {
  final List<BmiRecord> records;

  const HistoryChart({Key? key, required this.records}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text("No history yet")),
      );
    }

    // Sort by date (oldest first) for the chart
    final reversedRecords = records.reversed.toList();

    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
          color: AppColors.background,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 18,
            left: 12,
            top: 24,
            bottom: 12,
          ),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 5,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Color(0xffeaeaea),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: const FlTitlesData(
                show: true,
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 5,
                    reservedSize: 40,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: (reversedRecords.length - 1).toDouble(),
              minY: 10,
              maxY: 40,
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(reversedRecords.length, (index) {
                    return FlSpot(index.toDouble(), reversedRecords[index].bmi);
                  }),
                  isCurved: true,
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  barWidth: 5,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary.withOpacity(0.3),
                        AppColors.primary.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
