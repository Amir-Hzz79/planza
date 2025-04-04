import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF1E3A8A),
  onPrimary: Colors.white,
  primaryContainer: Color(0xFF90CAF9),
  onPrimaryContainer: Color(0xFF0D47A1),
  secondary: Color(0xFF2563EB),
  onSecondary: Colors.white,
  secondaryContainer: Color(0xFFBBDEFB),
  onSecondaryContainer: Color(0xFF0D47A1),
  tertiary: Color(0xFF4CAF50),
  onTertiary: Colors.white,
  tertiaryContainer: Color(0xFFC8E6C9),
  onTertiaryContainer: Color(0xFF1B5E20),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF1E293B),
  onSurfaceVariant: Color(0xFF5C6BC0),
  outline: Color(0xFF90A4AE),
  error: Color(0xFFB00020),
  onError: Colors.white,
  errorContainer: Color(0xFFFFDAD4),
  onErrorContainer: Color(0xFF410002),
  inverseSurface: Color(0xFF303030),
  onInverseSurface: Color(0xFFF5F5F5),
  inversePrimary: Color(0xFF82B1FF),
  shadow: Colors.black,
  scrim: Colors.black54,
  surfaceTint: Color(0xFF1E3A8A),
);

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF90CAF9),
  onPrimary: Colors.black,
  primaryContainer: Color(0xFF0D47A1),
  onPrimaryContainer: Color(0xFFBBDEFB),
  secondary: Color(0xFF42A5F5),
  onSecondary: Colors.black,
  secondaryContainer: Color(0xFF1565C0),
  onSecondaryContainer: Color(0xFFBBDEFB),
  tertiary: Color(0xFF81C784),
  onTertiary: Colors.black,
  tertiaryContainer: Color(0xFF388E3C),
  onTertiaryContainer: Color(0xFFC8E6C9),
  surface: Color(0xFF1E1E1E),
  onSurface: Color(0xFFE0E0E0),
  onSurfaceVariant: Color(0xFFB0BEC5),
  outline: Color(0xFF90A4AE),
  error: Color(0xFFCF6679),
  onError: Colors.black,
  errorContainer: Color(0xFFB00020),
  onErrorContainer: Color(0xFFFFDAD4),
  inverseSurface: Color(0xFFE0E0E0),
  onInverseSurface: Color(0xFF303030),
  inversePrimary: Color(0xFF0D47A1),
  shadow: Colors.black,
  scrim: Colors.black54,
  surfaceTint: Color(0xFF90CAF9),
);

final InputDecorationTheme inputTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: darkColorScheme.primary,
    ),
  ),
);

final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
  inputDecorationTheme: inputTheme,
);

final ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,
  inputDecorationTheme: inputTheme,
);
