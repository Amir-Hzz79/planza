import 'package:flutter/foundation.dart';
import '../utils/custom_shared_preferences.dart';

class ThemePreferenceService {
  final String _key = 'dark_mode';

  Future<void> saveThemeMode(Brightness themeMode) async {
    final prefs = await CustomSharedPreferences.getInstance();
    await prefs.setBool(_key, themeMode == Brightness.dark);
  }

  Future<Brightness?> getThemeMode() async {
    final prefs = await CustomSharedPreferences.getInstance();
    final bool? isDark = prefs.getBool(_key);

    return isDark == null
        ? null
        : (isDark ? Brightness.dark : Brightness.light);
  }
}