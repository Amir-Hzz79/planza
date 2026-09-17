import 'package:intl/intl.dart';
import 'calendar_system.dart';

class GregorianCalendar extends CalendarSystem {
  @override
  String get localeCode => 'en_US';

  @override
  String get displayName => 'Gregorian';

  @override
  DateTime toGregorian(DateTime local) => local;

  @override
  DateTime fromGregorian(DateTime gregorian) => gregorian;

  @override
  String formatFullDate(DateTime date) {
    return DateFormat.yMMMMd(localeCode).format(date);
  }

  @override
  String formatShortDate(DateTime date) {
    return DateFormat('MMd', localeCode).format(date);
  }

  @override
  String formatMonthYear(DateTime date) {
    return DateFormat.yMMMM(localeCode).format(date);
  }

  @override
  String formatDayMonth(DateTime date) {
    return DateFormat.Md(localeCode).format(date);
  }

  @override
  String formatWeekday(DateTime date) {
    return DateFormat.EEEE(localeCode).format(date);
  }

  @override
  List<DateTime> getWeekDays(DateTime weekStart) {
    return List.generate(7, (i) => weekStart.add(Duration(days: i)));
  }

  @override
  int getDaysInMonth(int year, int month) {
    if (month == 12) {
      return DateTime(year + 1, 1, 0).day;
    }
    return DateTime(year, month + 1, 0).day;
  }

  @override
  int getWeeksInMonth(int year, int month) {
    final firstDay = DateTime(year, month, 1);
    final lastDay = DateTime(year, month + 1, 0);
    final firstWeekday = firstDay.weekday;
    final daysInMonth = lastDay.day;
    return ((firstWeekday - 1 + daysInMonth) / 7).ceil();
  }

  @override
  DateTime getFirstDayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  @override
  DateTime getLastDayOfWeek(DateTime date) {
    return date.add(Duration(days: 7 - date.weekday));
  }

  @override
  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  bool isBeforeToday(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compareDate = DateTime(date.year, date.month, date.day);
    return compareDate.isBefore(today);
  }

  @override
  bool isAfterToday(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compareDate = DateTime(date.year, date.month, date.day);
    return compareDate.isAfter(today);
  }

  @override
  DateTime addDays(DateTime date, int days) => date.add(Duration(days: days));

  @override
  DateTime addMonths(DateTime date, int months) {
    var year = date.year;
    var month = date.month + months;
    while (month > 12) {
      month -= 12;
      year++;
    }
    while (month < 1) {
      month += 12;
      year--;
    }
    final daysInTargetMonth = getDaysInMonth(year, month);
    final day = date.day.clamp(1, daysInTargetMonth);
    return DateTime(year, month, day, date.hour, date.minute, date.second,
        date.millisecond, date.microsecond);
  }

  @override
  DateTime addYears(DateTime date, int years) {
    final newYear = date.year + years;
    final daysInFeb = getDaysInMonth(newYear, 2);
    final day = date.month == 2 && date.day > daysInFeb ? daysInFeb : date.day;
    return DateTime(newYear, date.month, day, date.hour, date.minute,
        date.second, date.millisecond, date.microsecond);
  }

  @override
  DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  @override
  DateTime endOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day, 23, 59, 59, 999);

  @override
  DateTime startOfMonth(int year, int month) => DateTime(year, month, 1);

  @override
  DateTime endOfMonth(int year, int month) =>
      DateTime(year, month + 1, 0, 23, 59, 59, 999);

  @override
  DateTime startOfYear(int year) => DateTime(year, 1, 1);

  @override
  DateTime endOfYear(int year) => DateTime(year, 12, 31, 23, 59, 59, 999);
}
