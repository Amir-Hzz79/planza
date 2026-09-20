# Design System

## Overview

Planza uses a custom **Material 3** design system with 8 unlockable color palettes.

---

## Tokens

### Colors

```dart
// 8 unlockable palettes + light/dark
class PlColors {
  // Primary, secondary, tertiary, surface, background, error, etc.
}

// 8 unlockable palettes
class PlColorPalettes {
  static const List<PlColorScheme> palettes = [
    PlColorScheme.default(),      // Default blue
    PlColorScheme.forest(),       // Green
    PlColorScheme.ocean(),        // Blue
    PlColorScheme.sunset(),       // Orange/Red
    PlColorScheme.lavender(),     // Purple
    PlColorScheme.rose(),         // Pink
    PlColorScheme.amber(),        // Yellow/Orange
    PlColorScheme.midnight(),     // Dark blue
  ];
}
```

### Spacing
```dart
class PlSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  
  static const EdgeInsets pagePadding = EdgeInsets.all(md);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: lg, vertical: sm);
}
```

### Typography
```dart
class PlTypography {
  static const TextStyle headlineLarge = TextStyle(fontSize: 32, fontWeight: FontWeight.w700);
  static const TextStyle headlineMedium = TextStyle(fontSize: 28, fontWeight: FontWeight.w600);
  static const TextStyle titleLarge = TextStyle(fontSize: 22, fontWeight: FontWeight.w600);
  static const TextStyle titleMedium = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle bodyLarge = TextStyle(fontSize: 16);
  static const TextStyle bodyMedium = TextStyle(fontSize: 14);
  static const TextStyle bodySmall = TextStyle(fontSize: 12);
  static const TextStyle labelLarge = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const TextStyle labelMedium = TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
  static const TextStyle labelSmall = TextStyle(fontSize: 11, fontWeight: FontWeight.w500);
}
```

### Border Radius
```dart
class PlBorderRadius {
  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double full = 9999;
}
```

### Motion
```dart
class PlMotion {
  static const Duration instant = Duration(milliseconds: 0);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  
  static const Curve standard = Curves.easeInOut;
  static const Curve emphasized = Curves.easeOutCubic;
  static const Curve decelerated = Curves.easeOutQuart;
}
```

### Elevation
```dart
class PlElevation {
  static const List<BoxShadow> shadow0 = [];
  static const List<BoxShadow> shadow1 = [BoxShadow(color: Color(0x1A000000), blurRadius: 2, offset: Offset(0, 1))];
  static const List<BoxShadow> shadow2 = [...];
  // ... shadow5
}
```

---

## Primitives

### PlButton
```dart
PlButton(
  label: 'Save',
  onPressed: () {},
  style: PlButtonStyle.filled,      // filled, filledTonal, outlined, text, destructive
  size: PlButtonSize.md,            // sm, md, lg
  icon: Icons.save,
  trailingIcon: Icons.arrow_forward,
  isLoading: false,
  isFullWidth: false,
)
```

### PlCard
```dart
PlCard(
  child: content,
  style: PlCardStyle.elevated,      // elevated, outlined, filled, glass
  padding: PlSpacing.cardPadding,
  onTap: () {},
)
```

### PlTextField
```dart
PlTextField(
  controller: controller,
  label: 'Email',
  hint: 'Enter email',
  prefixIcon: Icons.email,
  obscureText: false,
  keyboardType: TextInputType.emailAddress,
  onChanged: (value) {},
  validator: (value) => value?.isEmpty == true ? 'Required' : null,
)
```

### PlChip
```dart
PlChip(
  label: 'Work',
  onTap: () {},
  isSelected: true,
  onDeleted: () {},
  avatar: Icons.work,
)
```

---

## Composites

### GoalCard
```dart
GoalCard(
  goal: goalModel,
  onTap: () {},
  onLongPress: () {},
  showProgress: true,
  trailing: Icon(Icons.more_vert),
)
```

### TaskTile
```dart
TaskTile(
  task: taskModel,
  onTap: () {},
  onCheckboxChanged: (value) {},
  trailing: PopupMenuButton(...),
)
```

### ProgressRing
```dart
ProgressRing(
  progress: 0.65,
  size: 80,
  strokeWidth: 8,
  color: Colors.blue,
  child: Text('65%', style: PlTypography.titleLarge),
)
```

---

## Layouts

### PlScaffold
```dart
PlScaffold(
  appBar: PlAppBar(title: 'Title'),
  body: content,
  bottomNavigationBar: PlBottomNavBar(items: [...]),
  floatingActionButton: PlFAB(onPressed: () {}),
)
```

### PlPageTemplate
```dart
PlPageTemplate(
  title: 'Page Title',
  subtitle: 'Optional subtitle',
  action: IconButton(...),
  child: content,
)
```

---

## Theme Controller

```dart
class ThemeController extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  PlColorScheme currentPalette = PlColorScheme.default();
  
  void setThemeMode(ThemeMode mode) { ... }
  void setPalette(PlColorScheme palette) { ... }
  void unlockPalette(PlColorScheme palette) { ... }
}
```

---

## Unlockable Themes

| Palette | Unlock Condition |
|---------|------------------|
| Default | Always available |
| Forest | Level 5 |
| Ocean | Level 10 |
| Sunset | Level 15 |
| Lavender | Level 20 |
| Rose | Level 25 |
| Amber | Level 30 |
| Midnight | Level 50 |

---

## RTL Support

```dart
// Automatic RTL for Persian locale
MaterialApp(
  locale: localeState.locale,
  supportedLocales: [Locale('en'), Locale('fa')],
  builder: (context, child) => Directionality(
    textDirection: locale == 'fa' ? TextDirection.rtl : TextDirection.ltr,
    child: child!,
  ),
)
```

---

## Usage

```dart
// In widget
PlButton.primary(
  label: 'Save',
  onPressed: () {},
)

// With theme
Theme.of(context).colorScheme.primary
PlColors.primary

// Spacing
Padding(edgeInsets: PlSpacing.pagePadding)
SizedBox(height: PlSpacing.md)
```