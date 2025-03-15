import 'package:flutter/material.dart';
import 'package:planza/core/constants/week_days.dart';

import 'chart_column.dart';

enum ChartTimeZone {
  day,
  month,
  year,
}

class TaskChart extends StatefulWidget {
  const TaskChart({super.key});

  @override
  State<TaskChart> createState() => _TaskChartState();
}

class _TaskChartState extends State<TaskChart> {
  ChartTimeZone selectedTimeZone = ChartTimeZone.day;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
                    selectedTimeZone = ChartTimeZone.day;
                  },
                );
              },
              style: selectedTimeZone == ChartTimeZone.day
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
                'Day',
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
              7,
              (index) {
                final double containerHeight = 300;
                final double containerWidth = (screenWidth - 80) / 7;

                return ChartColumn(
                  width: containerWidth,
                  height: containerHeight,
                  text: WeekDays.values[index].name.characters.first,
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
