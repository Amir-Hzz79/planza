import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:planza/core/design/tokens/colors.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/border_radius.dart';

/// A Liquid Glass persistent bottom navigation bar.
///
/// Translucent/glassy background (blur + tint), tabs with icon + label,
/// accent-highlighted active tab, soft shadow, large rounded top corners.
/// Stays visible while scrolling — the Telegram 2026-style nav bar.
///
/// Usage:
/// ```dart
/// GlassyBottomNavigationBar(
///   currentIndex: _index,
///   onTap: (i) => setState(() => _index = i),
///   tabs: const [
///     BottomNavTab(icon: Icons.home_rounded, label: 'Home'),
///     BottomNavTab(icon: Icons.task_alt_rounded, label: 'Tasks'),
///     BottomNavTab(icon: Icons.golf_course_rounded, label: 'Goals'),
///     BottomNavTab(icon: Icons.track_changes, label: 'Hobbies'),
///     BottomNavTab(icon: Icons.person_rounded, label: 'Profile'),
///   ],
/// )
/// ```
class GlassyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<BottomNavTab> tabs;
  final Color? activeColor;
  final Color? inactiveColor;
  final double barOpacity;
  final double blur;

  const GlassyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.tabs,
    this.activeColor,
    this.inactiveColor,
    this.barOpacity = 0.6,
    this.blur = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final effectiveActive = activeColor ?? colors.primary;
    final effectiveInactive = inactiveColor ?? colors.onSurfaceVariant;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              color: colors.surface.withOpacity(barOpacity),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              border: Border(
                top: BorderSide(
                  color: colors.outlineVariant.withOpacity(isDark ? 0.45 : 0.2),
                  width: 0.5,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.shadow.withOpacity(isDark ? 0.28 : 0.08),
                  offset: const Offset(0, -4),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: SizedBox(
              height: PlSpacing.xxl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(tabs.length, (index) {
                  return _NavItem(
                    tab: tabs[index],
                    isActive: index == currentIndex,
                    activeColor: effectiveActive,
                    inactiveColor: effectiveInactive,
                    onTap: () => onTap(index),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavTab {
  final IconData icon;
  final String label;
  final IconData? activeIcon;

  const BottomNavTab({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
}

class _NavItem extends StatelessWidget {
  final BottomNavTab tab;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _NavItem({
    required this.tab,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeIcon = tab.activeIcon ?? tab.icon;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 58,
        height: 48,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Active indicator pill (glassy, accent-tinted)
            if (isActive)
              Container(
                width: 22,
                height: 3,
                margin: const EdgeInsets.only(bottom: 3),
                decoration: BoxDecoration(
                  color: activeColor.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            const SizedBox(height: 1),
            // Icon
            Icon(
              activeIcon,
              size: 22,
              color: isActive ? activeColor : inactiveColor,
            ),
            const SizedBox(height: 2),
            // Label
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? activeColor : inactiveColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
