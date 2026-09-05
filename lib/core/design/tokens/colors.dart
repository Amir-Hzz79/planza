import 'package:flutter/material.dart';

abstract class PlColorScheme {
  Color get primary;
  Color get primaryLight;
  Color get primaryDark;
  Color get primaryContainer;

  Color get secondary;
  Color get secondaryLight;
  Color get secondaryDark;
  Color get secondaryContainer;

  Color get tertiary;
  Color get tertiaryLight;
  Color get tertiaryDark;
  Color get tertiaryContainer;

  Color get success;
  Color get successLight;
  Color get successDark;
  Color get successContainer;

  Color get warning;
  Color get warningLight;
  Color get warningDark;
  Color get warningContainer;

  Color get error;
  Color get errorLight;
  Color get errorDark;
  Color get errorContainer;

  Color get surface;
  Color get surfaceVariant;
  Color get surfaceContainer;
  Color get surfaceContainerHigh;
  Color get surfaceContainerHighest;

  Color get background;
  Color get onBackground;
  Color get onSurface;
  Color get onSurfaceVariant;
  Color get outline;
  Color get outlineVariant;

  Color get inverseSurface;
  Color get inverseOnSurface;
  Color get inversePrimary;

  Color get shadow;
  Color get scrim;

  Map<String, List<Color>> get unlockablePalettes;

  List<Color> getPalette(String name);
}

class PlLightColors implements PlColorScheme {
  @override
  final Color primary = const Color(0xFF4F46E5);
  @override
  final Color primaryLight = const Color(0xFF818CF8);
  @override
  final Color primaryDark = const Color(0xFF3730A3);
  @override
  final Color primaryContainer = const Color(0xFFE0E7FF);

  @override
  final Color secondary = const Color(0xFF06B6D4);
  @override
  final Color secondaryLight = const Color(0xFF67E8F9);
  @override
  final Color secondaryDark = const Color(0xFF0E7490);
  @override
  final Color secondaryContainer = const Color(0xFFCFFAFE);

  @override
  final Color tertiary = const Color(0xFFF43F5E);
  @override
  final Color tertiaryLight = const Color(0xFFFB7185);
  @override
  final Color tertiaryDark = const Color(0xFFBE123C);
  @override
  final Color tertiaryContainer = const Color(0xFFFFE4E6);

  @override
  final Color success = const Color(0xFF10B981);
  @override
  final Color successLight = const Color(0xFF34D399);
  @override
  final Color successDark = const Color(0xFF059669);
  @override
  final Color successContainer = const Color(0xFFD1FAE5);

  @override
  final Color warning = const Color(0xFFF59E0B);
  @override
  final Color warningLight = const Color(0xFFFBBF24);
  @override
  final Color warningDark = const Color(0xFFD97706);
  @override
  final Color warningContainer = const Color(0xFFFFF3CD);

  @override
  final Color error = const Color(0xFFEF4444);
  @override
  final Color errorLight = const Color(0xFFF87171);
  @override
  final Color errorDark = const Color(0xFFDC2626);
  @override
  final Color errorContainer = const Color(0xFFFEF2F2);

  @override
  final Color surface = const Color(0xFFFFFFFF);
  @override
  final Color surfaceVariant = const Color(0xFFF3F4F6);
  @override
  final Color surfaceContainer = const Color(0xFFE5E7EB);
  @override
  final Color surfaceContainerHigh = const Color(0xFFD1D5DB);
  @override
  final Color surfaceContainerHighest = const Color(0xFF9CA3AF);

  @override
  final Color background = const Color(0xFFFAFAFA);
  @override
  final Color onBackground = const Color(0xFF111827);
  @override
  final Color onSurface = const Color(0xFF111827);
  @override
  final Color onSurfaceVariant = const Color(0xFF4B5563);
  @override
  final Color outline = const Color(0xFFD1D5DB);
  @override
  final Color outlineVariant = const Color(0xFFE5E7EB);

  @override
  final Color inverseSurface = const Color(0xFF1F2937);
  @override
  final Color inverseOnSurface = const Color(0xFFF9FAFB);
  @override
  final Color inversePrimary = const Color(0xFFA5B4FC);

  @override
  final Color shadow = const Color(0xFF000000);
  @override
  final Color scrim = const Color(0xFF000000);

  @override
  final Map<String, List<Color>> unlockablePalettes = {
    'ocean': [
      const Color(0xFF0EA5E9),
      const Color(0xFF0284C7),
      const Color(0xFF0369A1),
      const Color(0xFFE0F2FE),
    ],
    'sunset': [
      const Color(0xFFF97316),
      const Color(0xFFEA580C),
      const Color(0xFFC2410C),
      const Color(0xFFFFEDD5),
    ],
    'forest': [
      const Color(0xFF22C55E),
      const Color(0xFF16A34A),
      const Color(0xFF15803D),
      const Color(0xFFDCFCE7),
    ],
    'midnight': [
      const Color(0xFF6366F1),
      const Color(0xFF4F46E5),
      const Color(0xFF4338CA),
      const Color(0xFFE0E7FF),
    ],
    'rose': [
      const Color(0xFFEC4899),
      const Color(0xFFDB2777),
      const Color(0xFFBE185D),
      const Color(0xFFFCE7F3),
    ],
    'amber': [
      const Color(0xFFF59E0B),
      const Color(0xFFD97706),
      const Color(0xFFB45309),
      const Color(0xFFFFF3CD),
    ],
    'violet': [
      const Color(0xFF8B5CF6),
      const Color(0xFF7C3AED),
      const Color(0xFF6D28D9),
      const Color(0xFFF3E8FF),
    ],
    'emerald': [
      const Color(0xFF10B981),
      const Color(0xFF059669),
      const Color(0xFF047857),
      const Color(0xFFD1FAE5),
    ],
  };
  @override
  List<Color> getPalette(String name) {
    return unlockablePalettes[name] ??
        [primary, primaryLight, primaryDark, primaryContainer];
  }
}

class PlDarkColors implements PlColorScheme {
  @override
  final Color primary = const Color(0xFF818CF8);
  @override
  final Color primaryLight = const Color(0xFFC7D2FE);
  @override
  final Color primaryDark = const Color(0xFF6366F1);
  @override
  final Color primaryContainer = const Color(0xFF312E81);

  @override
  final Color secondary = const Color(0xFF22D3EE);
  @override
  final Color secondaryLight = const Color(0xFFA5F3FC);
  @override
  final Color secondaryDark = const Color(0xFF06B6D4);
  @override
  final Color secondaryContainer = const Color(0xFF164E63);

  @override
  final Color tertiary = const Color(0xFFFDA4AF);
  @override
  final Color tertiaryLight = const Color(0xFFFEC9D6);
  @override
  final Color tertiaryDark = const Color(0xFFF43F5E);
  @override
  final Color tertiaryContainer = const Color(0xFF781F36);

  @override
  final Color success = const Color(0xFF34D399);
  @override
  final Color successLight = const Color(0xFF6EE7B7);
  @override
  final Color successDark = const Color(0xFF10B981);
  @override
  final Color successContainer = const Color(0xFF064E3B);

  @override
  final Color warning = const Color(0xFFFBBF24);
  @override
  final Color warningLight = const Color(0xFFFDE047);
  @override
  final Color warningDark = const Color(0xFFF59E0B);
  @override
  final Color warningContainer = const Color(0xFF78350F);

  @override
  final Color error = const Color(0xFFF87171);
  @override
  final Color errorLight = const Color(0xFFFC9A9A);
  @override
  final Color errorDark = const Color(0xFFEF4444);
  @override
  final Color errorContainer = const Color(0xFF7F1D1D);

  @override
  final Color surface = const Color(0xFF111827);
  @override
  final Color surfaceVariant = const Color(0xFF1F2937);
  @override
  final Color surfaceContainer = const Color(0xFF374151);
  @override
  final Color surfaceContainerHigh = const Color(0xFF4B5563);
  @override
  final Color surfaceContainerHighest = const Color(0xFF6B7280);

  @override
  final Color background = const Color(0xFF030712);
  @override
  final Color onBackground = const Color(0xFFF9FAFB);
  @override
  final Color onSurface = const Color(0xFFF9FAFB);
  @override
  final Color onSurfaceVariant = const Color(0xFFD1D5DB);
  @override
  final Color outline = const Color(0xFF4B5563);
  @override
  final Color outlineVariant = const Color(0xFF374151);

  @override
  final Color inverseSurface = const Color(0xFFF3F4F6);
  @override
  final Color inverseOnSurface = const Color(0xFF111827);
  @override
  final Color inversePrimary = const Color(0xFF4F46E5);

  @override
  final Color shadow = const Color(0xFF000000);
  @override
  final Color scrim = const Color(0xFF000000);

  @override
  final Map<String, List<Color>> unlockablePalettes = {
    'ocean': [
      const Color(0xFF38BDF8),
      const Color(0xFF0EA5E9),
      const Color(0xFF0284C7),
      const Color(0xFF1E3A5F),
    ],
    'sunset': [
      const Color(0xFFFB923C),
      const Color(0xFFF97316),
      const Color(0xFFEA580C),
      const Color(0xFF7C2D12),
    ],
    'forest': [
      const Color(0xFF4ADE80),
      const Color(0xFF22C55E),
      const Color(0xFF16A34A),
      const Color(0xFF14532D),
    ],
    'midnight': [
      const Color(0xFFA5B4FC),
      const Color(0xFF818CF8),
      const Color(0xFF6366F1),
      const Color(0xFF312E81),
    ],
    'rose': [
      const Color(0xFFFDA4AF),
      const Color(0xFFF43F5E),
      const Color(0xFFE11D48),
      const Color(0xFF881337),
    ],
    'amber': [
      const Color(0xFFFBBF24),
      const Color(0xFFF59E0B),
      const Color(0xFFD97706),
      const Color(0xFF78350F),
    ],
    'violet': [
      const Color(0xFFC4B5FD),
      const Color(0xFFA78BFA),
      const Color(0xFF8B5CF6),
      const Color(0xFF4C1D95),
    ],
    'emerald': [
      const Color(0xFF6EE7B7),
      const Color(0xFF34D399),
      const Color(0xFF10B981),
      const Color(0xFF064E3B),
    ],
  };
  @override
  List<Color> getPalette(String name) {
    return unlockablePalettes[name] ??
        [primary, primaryLight, primaryDark, primaryContainer];
  }
}

// Singleton instances for backward compatibility
final PlColorScheme lightColors = PlLightColors();
final PlColorScheme darkColors = PlDarkColors();

// Legacy aliases for backward compatibility
class PlColors {
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF3730A3);
  static const Color primaryContainer = Color(0xFFE0E7FF);

  static const Color secondary = Color(0xFF06B6D4);
  static const Color secondaryLight = Color(0xFF67E8F9);
  static const Color secondaryDark = Color(0xFF0E7490);
  static const Color secondaryContainer = Color(0xFFCFFAFE);

  static const Color tertiary = Color(0xFFF43F5E);
  static const Color tertiaryLight = Color(0xFFFB7185);
  static const Color tertiaryDark = Color(0xFFBE123C);
  static const Color tertiaryContainer = Color(0xFFFFE4E6);

  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFF34D399);
  static const Color successDark = Color(0xFF059669);
  static const Color successContainer = Color(0xFFD1FAE5);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningContainer = Color(0xFFFFF3CD);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorContainer = Color(0xFFFEF2F2);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F4F6);
  static const Color surfaceContainer = Color(0xFFE5E7EB);
  static const Color surfaceContainerHigh = Color(0xFFD1D5DB);
  static const Color surfaceContainerHighest = Color(0xFF9CA3AF);

  static const Color background = Color(0xFFFAFAFA);
  static const Color onBackground = Color(0xFF111827);
  static const Color onSurface = Color(0xFF111827);
  static const Color onSurfaceVariant = Color(0xFF4B5563);
  static const Color outline = Color(0xFFD1D5DB);
  static const Color outlineVariant = Color(0xFFE5E7EB);

  static const Color inverseSurface = Color(0xFF1F2937);
  static const Color inverseOnSurface = Color(0xFFF9FAFB);
  static const Color inversePrimary = Color(0xFFA5B4FC);

  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);

  static const Map<String, List<Color>> unlockablePalettes = {
    'ocean': [
      Color(0xFF0EA5E9),
      Color(0xFF0284C7),
      Color(0xFF0369A1),
      Color(0xFFE0F2FE),
    ],
    'sunset': [
      Color(0xFFF97316),
      Color(0xFFEA580C),
      Color(0xFFC2410C),
      Color(0xFFFFEDD5),
    ],
    'forest': [
      Color(0xFF22C55E),
      Color(0xFF16A34A),
      Color(0xFF15803D),
      Color(0xFFDCFCE7),
    ],
    'midnight': [
      Color(0xFF6366F1),
      Color(0xFF4F46E5),
      Color(0xFF4338CA),
      Color(0xFFE0E7FF),
    ],
    'rose': [
      Color(0xFFEC4899),
      Color(0xFFDB2777),
      Color(0xFFBE185D),
      Color(0xFFFCE7F3),
    ],
    'amber': [
      Color(0xFFF59E0B),
      Color(0xFFD97706),
      Color(0xFFB45309),
      Color(0xFFFFF3CD),
    ],
    'violet': [
      Color(0xFF8B5CF6),
      Color(0xFF7C3AED),
      Color(0xFF6D28D9),
      Color(0xFFF3E8FF),
    ],
    'emerald': [
      Color(0xFF10B981),
      Color(0xFF059669),
      Color(0xFF047857),
      Color(0xFFD1FAE5),
    ],
  };

  static List<Color> getPalette(String name) {
    return unlockablePalettes[name] ??
        [primary, primaryLight, primaryDark, primaryContainer];
  }
}

class PlDarkColorsLegacy {
  static const Color primary = Color(0xFF818CF8);
  static const Color primaryLight = Color(0xFFC7D2FE);
  static const Color primaryDark = Color(0xFF6366F1);
  static const Color primaryContainer = Color(0xFF312E81);

  static const Color secondary = Color(0xFF22D3EE);
  static const Color secondaryLight = Color(0xFFA5F3FC);
  static const Color secondaryDark = Color(0xFF06B6D4);
  static const Color secondaryContainer = Color(0xFF164E63);

  static const Color tertiary = Color(0xFFFDA4AF);
  static const Color tertiaryLight = Color(0xFFFEC9D6);
  static const Color tertiaryDark = Color(0xFFF43F5E);
  static const Color tertiaryContainer = Color(0xFF781F36);

  static const Color success = Color(0xFF34D399);
  static const Color successLight = Color(0xFF6EE7B7);
  static const Color successDark = Color(0xFF10B981);
  static const Color successContainer = Color(0xFF064E3B);

  static const Color warning = Color(0xFFFBBF24);
  static const Color warningLight = Color(0xFFFDE047);
  static const Color warningDark = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFF78350F);

  static const Color error = Color(0xFFF87171);
  static const Color errorLight = Color(0xFFFC9A9A);
  static const Color errorDark = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFF7F1D1D);

  static const Color surface = Color(0xFF111827);
  static const Color surfaceVariant = Color(0xFF1F2937);
  static const Color surfaceContainer = Color(0xFF374151);
  static const Color surfaceContainerHigh = Color(0xFF4B5563);
  static const Color surfaceContainerHighest = Color(0xFF6B7280);

  static const Color background = Color(0xFF030712);
  static const Color onBackground = Color(0xFFF9FAFB);
  static const Color onSurface = Color(0xFFF9FAFB);
  static const Color onSurfaceVariant = Color(0xFFD1D5DB);
  static const Color outline = Color(0xFF4B5563);
  static const Color outlineVariant = Color(0xFF374151);

  static const Color inverseSurface = Color(0xFFF3F4F6);
  static const Color inverseOnSurface = Color(0xFF111827);
  static const Color inversePrimary = Color(0xFF4F46E5);

  static const Color shadow = Color(0xFF000000);
  static const Color scrim = Color(0xFF000000);

  static const Map<String, List<Color>> unlockablePalettes = {
    'ocean': [
      Color(0xFF38BDF8),
      Color(0xFF0EA5E9),
      Color(0xFF0284C7),
      Color(0xFF1E3A5F),
    ],
    'sunset': [
      Color(0xFFFB923C),
      Color(0xFFF97316),
      Color(0xFFEA580C),
      Color(0xFF7C2D12),
    ],
    'forest': [
      Color(0xFF4ADE80),
      Color(0xFF22C55E),
      Color(0xFF16A34A),
      Color(0xFF14532D),
    ],
    'midnight': [
      Color(0xFFA5B4FC),
      Color(0xFF818CF8),
      Color(0xFF6366F1),
      Color(0xFF312E81),
    ],
    'rose': [
      Color(0xFFFDA4AF),
      Color(0xFFF43F5E),
      Color(0xFFE11D48),
      Color(0xFF881337),
    ],
    'amber': [
      Color(0xFFFBBF24),
      Color(0xFFF59E0B),
      Color(0xFFD97706),
      Color(0xFF78350F),
    ],
    'violet': [
      Color(0xFFC4B5FD),
      Color(0xFFA78BFA),
      Color(0xFF8B5CF6),
      Color(0xFF4C1D95),
    ],
    'emerald': [
      Color(0xFF6EE7B7),
      Color(0xFF34D399),
      Color(0xFF10B981),
      Color(0xFF064E3B),
    ],
  };

  static List<Color> getPalette(String name) {
    return unlockablePalettes[name] ??
        [primary, primaryLight, primaryDark, primaryContainer];
  }
}
