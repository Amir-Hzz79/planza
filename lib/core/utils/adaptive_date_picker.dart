import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

/// Shows a date picker that adapts to the current locale.
///
/// Shows a standard Material date picker for English ('en') and a
/// Persian (Shamsi/Jalali) date picker for Farsi ('fa').
///
/// Regardless of which picker is shown, it ALWAYS returns a standard, universal
/// `DateTime` object, making it safe to use throughout your app's logic.
Future<DateTime?> showAdaptiveDatePicker({
  required BuildContext context,
  DateTime? initialDate,
}) async {
  final locale = Localizations.localeOf(context);

  if (locale.languageCode == 'fa') {
    final Jalali? picked = await showPersianDatePicker(
      context: context,
      locale: locale,
      initialDate: Jalali.fromDateTime(initialDate ?? DateTime.now()),
      firstDate: Jalali(1400),
      lastDate: Jalali(1450),
    );


    if (picked != null) {
      return picked.toDateTime();
    }
  } else {
    return await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime(2100),
    );
  }

  return null;
}
