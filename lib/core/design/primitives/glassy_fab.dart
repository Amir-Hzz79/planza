import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/colors.dart';
import 'package:planza/core/design/tokens/border_radius.dart';

import 'glassy_container.dart';

/// A Liquid Glass FAB — a translucent, blurred, rounded floating action button.
/// Used as the primary create action button.
///
/// Usage:
/// ```dart
/// GlassyFAB(
///   icon: Icons.add,
///   onPressed: () => ...,
/// )
/// ```
class GlassyFAB extends StatelessWidget {
  final IconData icon;
  final Color? activeColor;
  final double size;
  final VoidCallback? onPressed;

  const GlassyFAB({
    super.key,
    required this.icon,
    this.activeColor,
    this.size = 52,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;
    final effectiveColor = activeColor ?? colors.primary;

    return GlassyContainer(
      blur: 18,
      opacity: 0.5,
      borderRadius: PlBorderRadius.radiusLiquid,
      onTap: onPressed,
      tintColor: effectiveColor.withOpacity(0.08),
      shadows: [
        BoxShadow(
          color: effectiveColor.withOpacity(0.25),
          offset: const Offset(0, 6),
          blurRadius: 18,
          spreadRadius: 0,
        ),
      ],
      padding: const EdgeInsets.all(10),
      child: Icon(
        icon,
        size: size * 0.45,
        color: effectiveColor,
      ),
    );
  }
}

/// A Liquid Glass Speed Dial FAB — translucent, blurred, with rotating dial items.
///
/// The FAB is a glassy translucent button that opens a speed-dial with glassy
/// items (rotation + fade animation). Each dial item is a glassy surface with
/// icon + label. Used for quick access to create actions.
///
/// Usage:
/// ```dart
/// SpeedDial(
///   icon: Icons.add,
///   destination: const Offset(0, 0), // FAB position
///   items: const [
///     SpeedDialItem(
///       icon: Icons.task_alt,
///       label: 'Add task',
///       onTap: () => ...,
///     ),
///     SpeedDialItem(
///       icon: Icons.golf_course,
///       label: 'Add goal',
///       onTap: () => ...,
///     ),
///     ...
///   ],
/// )
/// ```
class SpeedDial extends StatefulWidget {
  final IconData icon;
  final Offset destination;
  final List<SpeedDialItem> items;
  final Color? activeColor;
  final bool closeOnPop;

  const SpeedDial({
    super.key,
    required this.icon,
    this.destination = const Offset(0, 0),
    required this.items,
    this.activeColor,
    this.closeOnPop = true,
  });

  @override
  State<SpeedDial> createState() => _SpeedDialState();
}

class _SpeedDialState extends State<SpeedDial>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  late AnimationController _controller;
  final double _itemSpacing = 56.0;
  final List<Animation<double>> _scaleAnimations = [];
  final List<Animation<double>> _alphaAnimations = [];
  final List<Animation<double>> _rotateAnimations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    for (int i = 0; i < widget.items.length; i++) {
      _scaleAnimations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0 + (i * 0.06), 0.45 + (i * 0.04),
                curve: Curves.easeOutBack),
          ),
        ),
      );
      _alphaAnimations.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.1 + (i * 0.05), 0.55 + (i * 0.04),
                curve: Curves.easeOut),
          ),
        ),
      );
      _rotateAnimations.add(
        Tween<double>(begin: -0.5, end: 0.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.1 + (i * 0.05), 0.45 + (i * 0.04),
                curve: Curves.easeOut),
          ),
        ),
      );
    }

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed &&
          widget.closeOnPop) {
        setState(() => _isOpen = false);
      } else if (_controller.status == AnimationStatus.dismissed) {
        setState(() => _isOpen = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_isOpen) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => _isOpen = !_isOpen);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;
    final effectiveColor = widget.activeColor ?? colors.primary;

    return Positioned(
      left: widget.destination.dx,
      top: widget.destination.dy,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          alignment: Alignment.topLeft,
          clipBehavior: Clip.none,
          children: [
            // Tap outside to close
            if (_isOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _toggle,
                  child: Container(),
                ),
              ),

            // Dial items (above FAB)
            if (_isOpen)
              for (int i = widget.items.length - 1; i >= 0; i--)
                Positioned(
                  left: -_itemSpacing - 10,
                  top: 56.0 + (i * 56.0),
                  child: Transform.scale(
                    scale: _scaleAnimations[i].value,
                    child: Opacity(
                      opacity: _alphaAnimations[i].value,
                      child: _DialItem(
                        item: widget.items[i],
                        isActive: i == 0,
                        color: effectiveColor,
                        rotate: _rotateAnimations[i].value,
                      ),
                    ),
                  ),
                ),

            // FAB (at the bottom)
            Positioned(
              left: 0,
              top: 0,
              child: InkWell(
                onTap: _toggle,
                borderRadius: PlBorderRadius.radiusLiquid,
                child: GlassyFAB(
                  icon: _isOpen ? Icons.close : widget.icon,
                  size: 52,
                  activeColor: effectiveColor,
                  onPressed: _toggle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpeedDialItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const SpeedDialItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });
}

class _DialItem extends StatelessWidget {
  final SpeedDialItem item;
  final bool isActive;
  final Color color;
  final double rotate;

  const _DialItem({
    required this.item,
    required this.isActive,
    required this.color,
    required this.rotate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Transform.rotate(
      angle: rotate,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.08) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Background circle (glassy)
            Positioned.fill(
              child: GlassyContainer(
                blur: 8,
                opacity: isActive ? 0.4 : 0.3,
                borderRadius: PlBorderRadius.radiusLiquid,
                tintColor: isActive ? color.withOpacity(0.1) : null,
                shadows: [
                  BoxShadow(
                    color: isActive
                        ? color.withOpacity(0.15)
                        : colors.shadow.withOpacity(0.1),
                    offset: const Offset(0, 2),
                    blurRadius: 12,
                  ),
                ],
                padding: const EdgeInsets.all(12),
                child: Icon(
                  item.icon,
                  size: 20,
                  color: isActive ? color : colors.onSurfaceVariant,
                ),
              ),
            ),
            // Label
            Positioned(
              left: 34,
              top: 13,
              child: Text(
                item.label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isActive ? color : colors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
