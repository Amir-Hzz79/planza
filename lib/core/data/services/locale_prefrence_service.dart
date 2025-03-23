import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalePreferenceService {
  final String _key = 'locale';

  Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }

  Future<Locale?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? languageCode = prefs.getString(_key);

    return languageCode == null ? null : Locale(languageCode);
  }
}
