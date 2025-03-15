import 'package:flutter/material.dart';
import 'package:planza/core/constants/month_names.dart';
import 'package:planza/core/constants/week_days.dart';
import 'package:planza/core/data/models/goal_model.dart';

import 'chart_column.dart';

enum ChartTimeZone {
  week,
  month,
  year,
}

class TaskChart extends StatefulWidget {
  const TaskChart({super.key, required this.goals});

  final List<GoalModel> goals;

  @override
  State<TaskChart> createState() => _TaskChartState();
}

class _TaskChartState extends State<TaskChart> {
  ChartTimeZone selectedTimeZone = ChartTimeZone.week;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    int columnCount = selectedTimeZone == ChartTimeZone.week
        ? 7
        : selectedTimeZone == ChartTimeZone.month
            ? 30
            : 12;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.calendar_month_outlined),
            ),
            const SizedBox(
              width: 5,
            ),
            FilledButton.tonal(
              onPressed: () {
                setState(
                  () {
                    selectedTimeZone = ChartTimeZone.week;
                  },
                );
              },
              style: selectedTimeZone == ChartTimeZone.week
                  ? FilledButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      //foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    )
                  : FilledButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
              child: Text(
                'Week',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            FilledButton.tonal(
              onPressed: () {
                setState(
                  () {
                    selectedTimeZone = ChartTimeZone.month;
                  },
                );
              },
              style: selectedTimeZone == ChartTimeZone.month
                  ? FilledButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      //foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    )
                  : FilledButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
              child: Text(
                'Month',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            FilledButton.tonal(
              onPressed: () {
                setState(
                  () {
                    selectedTimeZone = ChartTimeZone.year;
                  },
                );
              },
              style: selectedTimeZone == ChartTimeZone.year
                  ? FilledButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      //foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    )
                  : FilledButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
              child: Text(
                'Year',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 5,
            ),
            ...List.generate(
              columnCount,
              (index) {
                final double containerHeight = 300;
                //final double containerWidth = (screenWidth - 80) / columnCount;

                String columnText = selectedTimeZone == ChartTimeZone.week
                    ? WeekDays.values[index].name.characters.first
                    : selectedTimeZone == ChartTimeZone.month
                        ? '$index'
                        : Months.values[index].name.characters.first;
                double spacing = selectedTimeZone == ChartTimeZone.week
                    ? 7
                    : selectedTimeZone == ChartTimeZone.month
                        ? 2
                        : 5;

                DateTime dateTime = selectedTimeZone == ChartTimeZone.week
                    ? DateTime.now().add(Duration(days: index))
                    : selectedTimeZone == ChartTimeZone.month
                        ? DateTime(
                            DateTime.now().year, DateTime.now().month, index)
                        : DateTime(DateTime.now().year, index);
                
                return Expanded(
                  child: ChartColumn(
                    spacing: spacing,
                    height: containerHeight,
                    text: columnText,
                    goals: widget.goals
                        .where(
                          (element) => element.tasks.any(
                            (element) =>
                                selectedTimeZone == ChartTimeZone.week ||
                                        selectedTimeZone == ChartTimeZone.month
                                    ? element.dueDate == dateTime
                                    : element.dueDate?.month == dateTime.month,
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ],
    );
  }
}
