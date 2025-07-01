import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

typedef DayCellBuilder = Widget Function(
  BuildContext context,
  DateTime day,
  int dayNumber,
);

class PersianCalendar extends StatelessWidget {
  const PersianCalendar({
    super.key,
    required this.focusedMonth,
    required this.onMonthChanged,
    required this.dayBuilder,
  });

  final DateTime focusedMonth;
  final Function(DateTime) onMonthChanged;
  final DayCellBuilder dayBuilder;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Jalali focusedJalali = focusedMonth.toJalali();
    final JalaliFormatter formatter = focusedJalali.formatter;

    final int daysInMonth = focusedJalali.monthLength;
    final int firstWeekdayOffset = focusedJalali.copy(day: 1).weekDay - 1;

    final List<String> weekDayNames = [
      'شنبه',
      'یکشنبه',
      'دوشنبه',
      'سه شنبه',
      'چهارشنبه',
      'پنج شنبه',
      'جمعه',
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () =>
                    onMonthChanged(focusedJalali.addMonths(-1).toDateTime()),
              ),
              Text('${formatter.mN} ${formatter.y}',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () =>
                    onMonthChanged(focusedJalali.addMonths(1).toDateTime()),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekDayNames
              .map(
                (day) =>
                    Text(day.substring(0, 1), style: theme.textTheme.bodySmall),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemCount: daysInMonth + firstWeekdayOffset,
          itemBuilder: (context, index) {
            if (index < firstWeekdayOffset) return const SizedBox.shrink();

            final dayOfMonth = index - firstWeekdayOffset + 1;

            final currentDate = Jalali(
              focusedJalali.year,
              focusedJalali.month,
              dayOfMonth,
            ).toDateTime();

            return dayBuilder(context, currentDate, dayOfMonth);
          },
        ),
      ],
    );
  }
}
