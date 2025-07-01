import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'persian_calendar.dart';

typedef DayCellBuilder = Widget Function(
  BuildContext context,
  DateTime day,
  int dayNumber,
);

class AdaptiveCalendar extends StatelessWidget {
  final DateTime focusedMonth;
  final DateTime selectedDate;
  final Function(DateTime) onDaySelected;
  final Function(DateTime) onMonthChanged;
  final DayCellBuilder dayBuilder;

  const AdaptiveCalendar({
    super.key,
    required this.focusedMonth,
    required this.selectedDate,
    required this.onDaySelected,
    required this.onMonthChanged,
    required this.dayBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final bool isFarsi = locale.languageCode == 'fa';

    return isFarsi
        ? PersianCalendar(
            focusedMonth: focusedMonth,
            onMonthChanged: onMonthChanged,
            dayBuilder: dayBuilder,
          )
        : _buildGregorianCalendar(context);
  }

  Widget _buildGregorianCalendar(BuildContext context) {
    return TableCalendar(
      locale: 'en_US',
      firstDay: DateTime.utc(2020),
      lastDay: DateTime.utc(2030),
      focusedDay: focusedMonth,
      selectedDayPredicate: (day) => isSameDay(selectedDate, day),
      onDaySelected: (selected, focused) => onDaySelected(selected),
      onPageChanged: (focused) => onMonthChanged(focused),
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, day, focusedDay) =>
            dayBuilder(context, day, day.day),
        selectedBuilder: (context, day, focusedDay) =>
            dayBuilder(context, day, day.day),
        todayBuilder: (context, day, focusedDay) =>
            dayBuilder(context, day, day.day),
        outsideBuilder: (context, day, focusedDay) =>
            dayBuilder(context, day, day.day),
      ),
    );
  }
}
