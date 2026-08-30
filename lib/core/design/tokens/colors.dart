import 'package:flutter/material.dart';

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
    return unlockablePalettes[name] ?? [primary, primaryLight, primaryDark, primaryContainer];
  }
}

class PlDarkColors {
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
    return unlockablePalettes[name] ?? [primary, primaryLight, primaryDark, primaryContainer];
  }
}