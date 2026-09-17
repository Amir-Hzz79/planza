import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../calendar/index.dart';

/// A helper class to handle all date formatting based on the user's calendar preference.
/// It correctly formats a universal `DateTime` object (Gregorian) into the selected calendar system.
class AppDateFormatter {
  final BuildContext context;
  final CalendarService _calendarService = CalendarService();

  factory AppDateFormatter.of(BuildContext context) {
    return AppDateFormatter._(context);
  }

  AppDateFormatter._(this.context) {
    initializeDateFormatting();
  }

  CalendarService get calendar => _calendarService;

  /// Formats a date into a full, readable string like "June 28, 2025" or "? ??? ????".
  String formatFullDate(DateTime? dt) {
    if (dt == null) return 'No date';
    return _calendarService.formatFullDate(dt);
  }

  /// Formats a date into a shorter version, e.g., "Jun 28" or "? ???".
  String formatShortDate(DateTime? dt) {
    if (dt == null) return 'No date';
    return _calendarService.formatShortDate(dt);
  }

  /// Formats a date into month year, e.g., "June 2025" or "??? ????".
  String formatMonthYear(DateTime? dt) {
    if (dt == null) return 'No date';
    return _calendarService.formatMonthYear(dt);
  }

  /// Formats a date into day month, e.g., "Jun 28" or "?? ???".
  String formatDayMonth(DateTime? dt) {
    if (dt == null) return 'No date';
    return _calendarService.formatDayMonth(dt);
  }

  /// Returns a relative string for a date, like "Today", "Tomorrow", or "Overdue".
  /// For other future dates, just show the formatted date.
  String formatRelativeDay(DateTime? dt) {
    if (dt == null) return 'No date';

    final now = _calendarService.now();
    final today = _calendarService.startOfDay(now);
    final tomorrow = _calendarService.addDays(today, 1);
    final checkDate = _calendarService.startOfDay(dt);

    if (_calendarService.isSameDay(checkDate, today)) return 'Today';
    if (_calendarService.isSameDay(checkDate, tomorrow)) return 'Tomorrow';
    if (checkDate.isBefore(today)) return 'Overdue';

    return formatShortDate(dt);
  }

  /// Formats with both primary and secondary calendar
  String formatWithSecondary(DateTime? dt) {
    if (dt == null) return 'No date';
    return _calendarService.formatWithSecondary(dt);
  }

  /// Gets weekday name
  String formatWeekday(DateTime? dt) {
    if (dt == null) return '';
    return _calendarService.formatWeekday(dt);
  }
}
