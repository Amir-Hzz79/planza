import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalePreferenceService {
  final String _key = 'locale';

  /// Saves the complete locale (language and country code) as a single string.
  Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();

    // Combine language and country codes into a string like "fa_IR" or just "en".
    String localeString = locale.languageCode;
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      localeString += '_${locale.countryCode}';
    }

    await prefs.setString(_key, localeString);
  }

  /// Loads the saved locale string and reconstructs the full Locale object.
  Future<Locale?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? localeString = prefs.getString(_key);

    if (localeString == null || localeString.isEmpty) {
      return null;
    }

    final parts = localeString.split('_');
    if (parts.length > 1) {
      return Locale(parts[0], parts[1]);
    } else {
      return Locale(parts[0]);
    }
  }
}
