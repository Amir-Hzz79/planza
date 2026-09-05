import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../tokens/index.dart';

class ThemeController extends ChangeNotifier {
  static const String _themeModeKey = 'theme_mode';
  static const String _selectedPaletteKey = 'selected_palette';
  static const String _useCustomPaletteKey = 'use_custom_palette';

  ThemeMode _themeMode = ThemeMode.system;
  String _selectedPalette = 'default';
  bool _useCustomPalette = false;

  ThemeMode get themeMode => _themeMode;
  String get selectedPalette => _selectedPalette;
  bool get useCustomPalette => _useCustomPalette;

  List<Color> get currentPalette {
    if (_useCustomPalette) {
      return _getUnlockablePalette(_selectedPalette);
    }
    return _themeMode == ThemeMode.dark
        ? darkColors.getPalette(_selectedPalette)
        : lightColors.getPalette(_selectedPalette);
  }

  Color get primaryColor => currentPalette[0];
  Color get primaryLightColor => currentPalette[1];
  Color get primaryDarkColor => currentPalette[2];
  Color get primaryContainerColor => currentPalette[3];

  ThemeController() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = ThemeMode.values[prefs.getInt(_themeModeKey) ?? 0];
    _selectedPalette = prefs.getString(_selectedPaletteKey) ?? 'default';
    _useCustomPalette = prefs.getBool(_useCustomPaletteKey) ?? false;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
    notifyListeners();
  }

  Future<void> setPalette(String paletteName,
      {bool isUnlockable = false}) async {
    _selectedPalette = paletteName;
    _useCustomPalette = isUnlockable;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedPaletteKey, paletteName);
    await prefs.setBool(_useCustomPaletteKey, isUnlockable);
    notifyListeners();
  }

  Future<void> resetToDefault() async {
    _selectedPalette = 'default';
    _useCustomPalette = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedPaletteKey, 'default');
    await prefs.setBool(_useCustomPaletteKey, false);
    notifyListeners();
  }

  List<String> get availablePalettes {
    return ['default', ...PlColors.unlockablePalettes.keys];
  }

  List<String> getUnlockedPalettes(List<String> userUnlocked) {
    return [
      'default',
      ...userUnlocked.where((p) => PlColors.unlockablePalettes.containsKey(p))
    ];
  }

  List<Color> _getUnlockablePalette(String name) {
    final isDark = _themeMode == ThemeMode.dark;
    return isDark ? darkColors.getPalette(name) : lightColors.getPalette(name);
  }

  ThemeData get lightTheme => _buildTheme(Brightness.light);
  ThemeData get darkTheme => _buildTheme(Brightness.dark);

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;
    final palette = currentPalette;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: palette[0],
      onPrimary: isDark ? darkColors.onBackground : lightColors.onBackground,
      primaryContainer: palette[3],
      onPrimaryContainer: isDark ? darkColors.onSurface : lightColors.onSurface,
      secondary: palette[0].withOpacity(0.8),
      onSecondary: isDark ? darkColors.onBackground : lightColors.onBackground,
      secondaryContainer: palette[0].withOpacity(0.2),
      onSecondaryContainer:
          isDark ? darkColors.onSurface : lightColors.onSurface,
      tertiary: palette[0].withOpacity(0.6),
      onTertiary: isDark ? darkColors.onBackground : lightColors.onBackground,
      tertiaryContainer: palette[0].withOpacity(0.15),
      onTertiaryContainer: isDark ? darkColors.onSurface : lightColors.onSurface,
      error: colors.error,
      onError: isDark ? darkColors.onBackground : lightColors.onBackground,
      errorContainer: colors.errorContainer,
      onErrorContainer: isDark ? darkColors.onSurface : lightColors.onSurface,
      surface: colors.surface,
      onSurface: colors.onSurface,
      surfaceContainerHighest: colors.surfaceContainerHighest,
      onSurfaceVariant: colors.onSurfaceVariant,
      outline: colors.outline,
      outlineVariant: colors.outlineVariant,
      shadow: colors.shadow,
      scrim: colors.scrim,
      inverseSurface: colors.inverseSurface,
      onInverseSurface: colors.inverseOnSurface,
      inversePrimary: colors.inversePrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      fontFamily: PlTypography.fontFamily,
      scaffoldBackgroundColor: colors.background,
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusLg),
        margin: EdgeInsets.zero,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle:
            PlTypography.titleLarge.copyWith(color: colors.onSurface),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: palette[0],
        unselectedItemColor: colors.onSurfaceVariant,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: palette[0],
foregroundColor:
              isDark ? darkColors.onBackground : lightColors.onBackground,
        shape: RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusFull),
        elevation: 4,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: palette[0],
          foregroundColor:
              isDark ? darkColors.onBackground : lightColors.onBackground,
          shape:
              RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusFull),
          padding: PlSpacing.buttonPadding,
          textStyle: PlTypography.buttonMedium,
          elevation: 1,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: palette[0],
          foregroundColor:
              isDark ? darkColors.onBackground : lightColors.onBackground,
          shape:
              RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusFull),
          padding: PlSpacing.buttonPadding,
          textStyle: PlTypography.buttonMedium,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette[0],
          side: BorderSide(color: palette[0], width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusFull),
          padding: PlSpacing.buttonPadding,
          textStyle: PlTypography.buttonMedium,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: palette[0],
          shape:
              RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusFull),
          padding: PlSpacing.buttonPaddingSm,
          textStyle: PlTypography.buttonMedium,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: PlSpacing.md, vertical: PlSpacing.sm),
        border: OutlineInputBorder(
          borderRadius: PlBorderRadius.radiusMd,
          borderSide: BorderSide(color: colors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: PlBorderRadius.radiusMd,
          borderSide: BorderSide(color: colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: PlBorderRadius.radiusMd,
          borderSide: BorderSide(color: palette[0], width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: PlBorderRadius.radiusMd,
          borderSide: BorderSide(color: colors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: PlBorderRadius.radiusMd,
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: PlBorderRadius.radiusMd,
          borderSide: BorderSide(color: colors.outlineVariant),
        ),
        labelStyle:
            PlTypography.bodyMedium.copyWith(color: colors.onSurfaceVariant),
        hintStyle: PlTypography.bodyMedium
            .copyWith(color: colors.onSurfaceVariant.withOpacity(0.5)),
        errorStyle: PlTypography.bodySmall.copyWith(color: colors.error),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceVariant,
        selectedColor: palette[3],
        disabledColor: colors.surfaceContainerHighest,
        padding: const EdgeInsets.symmetric(
            horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
        labelStyle: PlTypography.labelMedium,
        secondaryLabelStyle: PlTypography.labelMedium.copyWith(
            color: isDark ? darkColors.onBackground : lightColors.onBackground),
        shape: RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusFull),
        side: BorderSide.none,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusLg),
        titleTextStyle:
            PlTypography.titleLarge.copyWith(color: colors.onSurface),
        contentTextStyle:
            PlTypography.bodyMedium.copyWith(color: colors.onSurface),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: PlBorderRadius.radiusXl.topLeft),
        ),
        modalBackgroundColor: colors.surface,
      ),
      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        thickness: 1,
        space: PlSpacing.sm,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: PlSpacing.listItemPadding,
        shape: RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusMd),
        tileColor: colors.surface,
        selectedTileColor: palette[3],
        iconColor: colors.onSurfaceVariant,
        textColor: colors.onSurface,
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colors.inverseSurface,
          borderRadius: PlBorderRadius.radiusSm,
          boxShadow: PlElevation.shadow2,
        ),
        textStyle:
            PlTypography.bodySmall.copyWith(color: colors.inverseOnSurface),
        padding: const EdgeInsets.symmetric(
            horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
        verticalOffset: PlSpacing.sm,
        preferBelow: true,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: palette[0],
        linearTrackColor: colors.surfaceVariant,
        circularTrackColor: colors.surfaceVariant,
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: palette[0],
        inactiveTrackColor: colors.surfaceVariant,
        thumbColor: palette[0],
        overlayColor: palette[0].withOpacity(0.2),
        valueIndicatorColor: palette[0],
        valueIndicatorTextStyle: PlTypography.bodySmall.copyWith(
            color: isDark ? darkColors.onBackground : lightColors.onBackground),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: palette[0],
        unselectedLabelColor: colors.onSurfaceVariant,
        indicatorColor: palette[0],
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: PlTypography.labelLarge,
        unselectedLabelStyle: PlTypography.labelLarge,
      ),
      extensions: <ThemeExtension<dynamic>>[
        _PlCustomThemeExtension(
          palette: palette,
          spacing: PlSpacing(),
          typography: PlTypography(),
          borderRadius: PlBorderRadius(),
          motion: PlMotion(),
        ),
      ],
    );
  }
}

class _PlCustomThemeExtension extends ThemeExtension<_PlCustomThemeExtension> {
  final List<Color> palette;
  final PlSpacing spacing;
  final PlTypography typography;
  final PlBorderRadius borderRadius;
  final PlMotion motion;

  const _PlCustomThemeExtension({
    required this.palette,
    required this.spacing,
    required this.typography,
    required this.borderRadius,
    required this.motion,
  });

  @override
  _PlCustomThemeExtension copyWith({
    List<Color>? palette,
    PlSpacing? spacing,
    PlTypography? typography,
    PlBorderRadius? borderRadius,
    PlMotion? motion,
  }) {
    return _PlCustomThemeExtension(
      palette: palette ?? this.palette,
      spacing: spacing ?? this.spacing,
      typography: typography ?? this.typography,
      borderRadius: borderRadius ?? this.borderRadius,
      motion: motion ?? this.motion,
    );
  }

  @override
  _PlCustomThemeExtension lerp(
      ThemeExtension<_PlCustomThemeExtension>? other, double t) {
    return this;
  }
}

extension PlThemeExtension on BuildContext {
  _PlCustomThemeExtension get plTheme =>
      Theme.of(this).extension<_PlCustomThemeExtension>()!;
  List<Color> get plPalette => plTheme.palette;
  PlSpacing get plSpacing => plTheme.spacing;
  PlTypography get plTypography => plTheme.typography;
  PlBorderRadius get plBorderRadius => plTheme.borderRadius;
  PlMotion get plMotion => plTheme.motion;
}


