import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../calendar/index.dart';

/// Shows a date picker that adapts to the user's calendar preference.
///
/// Uses CalendarService to determine which calendar system to show.
/// Regardless of which picker is shown, it ALWAYS returns a standard, universal
/// `DateTime` object (Gregorian), making it safe to use throughout your app's logic.
Future<DateTime?> showAdaptiveDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  CalendarType? forceCalendar,
}) async {
  final calendarService = CalendarService();
  final calendarType = forceCalendar ?? calendarService.primaryCalendar;
  final calendar = calendarType == CalendarType.jalali ? calendarService.jalali : calendarService.gregorian;

  final initial = initialDate ?? DateTime.now();
  final normalizedInitial = calendar.fromGregorian(initial);

  if (calendarType == CalendarType.jalali) {
    final jalali = Jalali.fromDateTime(normalizedInitial);
    final picked = await showPersianDatePicker(
      context: context,
      locale: const Locale('fa', 'IR'),
      initialDate: jalali,
      firstDate: Jalali(1400),
      lastDate: Jalali(1450),
    );

    if (picked != null) {
      return picked.toDateTime();
    }
  } else {
    return await showDatePicker(
      context: context,
      initialDate: normalizedInitial,
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime(2100),
    );
  }

  return null;
}

/// Shows a date picker with full calendar system support
Future<DateTime?> showCalendarDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  CalendarType? forceCalendar,
}) async {
  final calendarService = CalendarService();
  final calendarType = forceCalendar ?? calendarService.primaryCalendar;
  final calendar = calendarType == CalendarType.jalali ? calendarService.jalali : calendarService.gregorian;

  final initial = initialDate ?? DateTime.now();
  final normalizedInitial = calendar.fromGregorian(initial);
  final normalizedFirst = firstDate != null ? calendar.fromGregorian(firstDate) : null;
  final normalizedLast = lastDate != null ? calendar.fromGregorian(lastDate) : null;

  if (calendarType == CalendarType.jalali) {
    final jalaliInitial = Jalali.fromDateTime(normalizedInitial);
    final jalaliFirst = normalizedFirst != null ? Jalali.fromDateTime(normalizedFirst) : Jalali(1400);
    final jalaliLast = normalizedLast != null ? Jalali.fromDateTime(normalizedLast) : Jalali(1450);

    final picked = await showPersianDatePicker(
      context: context,
      locale: const Locale('fa', 'IR'),
      initialDate: jalaliInitial,
      firstDate: jalaliFirst,
      lastDate: jalaliLast,
    );

    if (picked != null) {
      return picked.toDateTime();
    }
  } else {
    return await showDatePicker(
      context: context,
      initialDate: normalizedInitial,
      firstDate: normalizedFirst ?? DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: normalizedLast ?? DateTime(2100),
    );
  }

  return null;
}
