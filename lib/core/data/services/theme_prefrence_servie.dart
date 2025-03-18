import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferenceService {
  static const String _themeKey = 'dark_mode';

  Future<void> saveThemeMode(Brightness themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, themeMode == Brightness.dark);

    print('Prefrence $themeMode');
  }

  Future<Brightness?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isDark = prefs.getBool(_themeKey);
    print(
      'Prefrence ${isDark == null ? 'null' : isDark ? Brightness.dark : Brightness.light}',
    );

    return isDark == null
        ? null
        : (isDark ? Brightness.dark : Brightness.light);
  }
}
