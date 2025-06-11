import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

class WeeklyChart extends StatelessWidget {
  final Map<int, int> weeklyTasks;
  const WeeklyChart({super.key, required this.weeklyTasks});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return SliverToBoxAdapter(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: SizedBox(
            height: 150,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: (value, meta) {
                            if (value % 2 != 0) return const SizedBox.shrink();
                            return Text(value.toInt().toString(),
                                style: theme.textTheme.bodySmall);
                          })),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const style = TextStyle(fontSize: 10);
                            String text;
                            switch (value.toInt()) {
                              case 0:
                                text = 'Mon';
                                break;
                              case 1:
                                text = 'Tue';
                                break;
                              case 2:
                                text = 'Wed';
                                break;
                              case 3:
                                text = 'Thu';
                                break;
                              case 4:
                                text = 'Fri';
                                break;
                              case 5:
                                text = 'Sat';
                                break;
                              case 6:
                                text = 'Sun';
                                break;
                              default:
                                text = '';
                                break;
                            }
                            return Text(text, style: style);
                          })),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 2,
                  getDrawingHorizontalLine: (value) => FlLine(
                      color: theme.colorScheme.outline.withOpacityDouble(0.2),
                      strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                barGroups: weeklyTasks.entries.map((entry) {
                  return BarChartGroupData(x: entry.key, barRods: [
                    BarChartRodData(
                        toY: entry.value.toDouble(),
                        width: 14,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withOpacityDouble(0.7),
                            primaryColor,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ))
                  ]);
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
