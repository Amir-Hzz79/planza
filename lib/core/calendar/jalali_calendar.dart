import 'package:intl/intl.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'calendar_system.dart';

class JalaliCalendar extends CalendarSystem {
  @override
  String get localeCode => 'fa_IR';

  @override
  String get displayName => 'Jalali (Solar Hijri)';

  @override
  DateTime toGregorian(DateTime local) {
    final jalali = Jalali.fromDateTime(local);
    return jalali.toDateTime();
  }

  @override
  DateTime fromGregorian(DateTime gregorian) {
    final jalali = Jalali.fromDateTime(gregorian);
    return DateTime(
        jalali.year,
        jalali.month,
        jalali.day,
        gregorian.hour,
        gregorian.minute,
        gregorian.second,
        gregorian.millisecond,
        gregorian.microsecond);
  }

  @override
  String formatFullDate(DateTime date) {
    final jalali = Jalali.fromDateTime(date);
    final formatter = DateFormat.yMMMMd(localeCode);
    return formatter.format(jalali.toDateTime());
  }

  @override
  String formatShortDate(DateTime date) {
    final jalali = Jalali.fromDateTime(date);
    final formatter = DateFormat('MMd', localeCode);
    return formatter.format(jalali.toDateTime());
  }

  @override
  String formatMonthYear(DateTime date) {
    final jalali = Jalali.fromDateTime(date);
    final formatter = DateFormat.yMMMM(localeCode);
    return formatter.format(jalali.toDateTime());
  }

  @override
  String formatDayMonth(DateTime date) {
    final jalali = Jalali.fromDateTime(date);
    final formatter = DateFormat.Md(localeCode);
    return formatter.format(jalali.toDateTime());
  }

  @override
  String formatWeekday(DateTime date) {
    final jalali = Jalali.fromDateTime(date);
    final formatter = DateFormat.EEEE(localeCode);
    return formatter.format(jalali.toDateTime());
  }

  @override
  List<DateTime> getWeekDays(DateTime weekStart) {
    return List.generate(7, (i) => weekStart.add(Duration(days: i)));
  }

  @override
  int getDaysInMonth(int year, int month) {
    final jalali = Jalali(year, month, 1);
    if (month == 12) {
      return jalali.isLeapYear() ? 30 : 29;
    }
    return month <= 6 ? 31 : 30;
  }

  @override
  int getWeeksInMonth(int year, int month) {
    final firstDay = fromGregorian(Jalali(year, month, 1).toDateTime());
    final lastDay = fromGregorian(
        Jalali(year, month, getDaysInMonth(year, month)).toDateTime());
    final firstWeekday = firstDay.weekday;
    final daysInMonth = getDaysInMonth(year, month);
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
    final jalaliNow = Jalali.fromDateTime(now);
    final jalaliDate = Jalali.fromDateTime(date);
    return jalaliNow.year == jalaliDate.year &&
        jalaliNow.month == jalaliDate.month &&
        jalaliNow.day == jalaliDate.day;
  }

  @override
  bool isSameDay(DateTime a, DateTime b) {
    final jalaliA = Jalali.fromDateTime(a);
    final jalaliB = Jalali.fromDateTime(b);
    return jalaliA.year == jalaliB.year &&
        jalaliA.month == jalaliB.month &&
        jalaliA.day == jalaliB.day;
  }

  @override
  bool isBeforeToday(DateTime date) {
    final now = DateTime.now();
    return toGregorian(date).isBefore(toGregorian(now));
  }

  @override
  bool isAfterToday(DateTime date) {
    final now = DateTime.now();
    return toGregorian(date).isAfter(toGregorian(now));
  }

  @override
  DateTime addDays(DateTime date, int days) {
    return toGregorian(date).add(Duration(days: days));
  }

  @override
  DateTime addMonths(DateTime date, int months) {
    final jalali = Jalali.fromDateTime(date);
    var year = jalali.year;
    var month = jalali.month + months;
    while (month > 12) {
      month -= 12;
      year++;
    }
    while (month < 1) {
      month += 12;
      year--;
    }
    final daysInTargetMonth = getDaysInMonth(year, month);
    final day = jalali.day.clamp(1, daysInTargetMonth);
    return Jalali(year, month, day).toDateTime();
  }

  @override
  DateTime addYears(DateTime date, int years) {
    final jalali = Jalali.fromDateTime(date);
    final newYear = jalali.year + years;
    final daysInMonth = getDaysInMonth(newYear, jalali.month);
    final day = jalali.day.clamp(1, daysInMonth);
    return Jalali(newYear, jalali.month, day).toDateTime();
  }

  @override
  DateTime startOfDay(DateTime date) {
    final jalali = Jalali.fromDateTime(date);
    return Jalali(jalali.year, jalali.month, jalali.day).toDateTime();
  }

  @override
  DateTime endOfDay(DateTime date) {
    final jalali = Jalali.fromDateTime(date);
    return Jalali(jalali.year, jalali.month, jalali.day).toDateTime().add(
        const Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999));
  }

  @override
  DateTime startOfMonth(int year, int month) {
    return Jalali(year, month, 1).toDateTime();
  }

  @override
  DateTime endOfMonth(int year, int month) {
    final days = getDaysInMonth(year, month);
    return Jalali(year, month, days).toDateTime().add(
        const Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 999));
  }

  @override
  DateTime startOfYear(int year) {
    return Jalali(year, 1, 1).toDateTime();
  }

  @override
  DateTime endOfYear(int year) {
    final days = Jalali(year, 1, 1).isLeapYear() ? 366 : 365;
    return Jalali(year, 1, 1).toDateTime().add(Duration(
        days: days - 1,
        hours: 23,
        minutes: 59,
        seconds: 59,
        milliseconds: 999));
  }
}
