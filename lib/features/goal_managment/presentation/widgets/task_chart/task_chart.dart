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
    final theme = Theme.of(context);
    int columnCount = selectedTimeZone == ChartTimeZone.week
        ? 7
        : selectedTimeZone == ChartTimeZone.month
            ? 15
            : 12;
    final double columnHeight = selectedTimeZone == ChartTimeZone.week ||
            selectedTimeZone == ChartTimeZone.year
        ? 250
        : 115;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                //Open Calendar maybe
              },
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.onInverseSurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.calendar_month_outlined),
              ),
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
                      backgroundColor: theme.colorScheme.onInverseSurface,
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
                      backgroundColor: theme.colorScheme.onInverseSurface,
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
                      backgroundColor: theme.colorScheme.onInverseSurface,
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
                String columnText = selectedTimeZone == ChartTimeZone.week
                    ? WeekDays.values[index].name.characters.first
                    : selectedTimeZone == ChartTimeZone.month
                        ? '${index + 1}'
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
                    height: columnHeight,
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
        if (selectedTimeZone == ChartTimeZone.month)
          const SizedBox(
            height: 20,
          ),
        if (selectedTimeZone == ChartTimeZone.month)
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              ...List.generate(
                columnCount,
                (i) {
                  int index = i + 15;

                  String columnText = selectedTimeZone == ChartTimeZone.week
                      ? WeekDays.values[index].name.characters.first
                      : selectedTimeZone == ChartTimeZone.month
                          ? '${index + 1}'
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
                      height: columnHeight,
                      text: columnText,
                      goals: widget.goals
                          .where(
                            (element) => element.tasks.any(
                              (element) => selectedTimeZone ==
                                          ChartTimeZone.week ||
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
