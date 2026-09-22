import 'package:flutter/material.dart';

import 'package:planza/core/design/tokens/colors.dart';
import 'package:planza/core/design/tokens/spacing.dart';

/// A compact, glassy app bar for the Liquid Glass design language.
///
/// Thin, translucent/glassy background, title + optional subtitle,
/// contextual actions (search, filter, add, 3-dot overflow).
/// Used as the header for each tab in the redesigned Planza.
///
/// Usage:
/// ```dart
/// GlassyAppBar(
///   title: 'Tasks',
///   actions: [
///     GlassySearchField(onChanged: ...),
///     IconButton(...),
///   ],
/// )
/// ```
class GlassyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget> actions;
  final String? subtitle;
  final VoidCallback? onSearchTap;
  final bool showBackButton;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? searchHint;

  const GlassyAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions = const [],
    this.subtitle,
    this.onSearchTap,
    this.showBackButton = false,
    this.backgroundColor,
    this.foregroundColor,
    this.searchHint,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final effectiveBg = backgroundColor ?? Colors.transparent;
    final effectiveFg = foregroundColor ?? colors.onSurface;

    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: effectiveBg,
        border: Border(
          bottom: BorderSide(
            color: colors.outlineVariant.withOpacity(isDark ? 0.4 : 0.15),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // Leading (back button or icon)
          if (showBackButton)
            Padding(
              padding: const EdgeInsets.only(left: PlSpacing.md),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 20),
                onPressed: () => Navigator.pop(context),
                color: effectiveFg,
              ),
            )
          else if (leading != null) ...[
            leading!,
            const SizedBox(width: PlSpacing.md),
          ] else
            const SizedBox(width: PlSpacing.md),

          // Title + subtitle
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: effectiveFg,
                    letterSpacing: 0.2,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 1),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: colors.onSurfaceVariant,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Actions
          if (actions.isNotEmpty) ...[
            const SizedBox(width: PlSpacing.sm),
            ...actions,
          ] else
            const SizedBox(width: PlSpacing.md),
        ],
      ),
    );
  }

  /// Returns a list of actions with a search field that can be expanded/collapsed.
  /// The search field follows the Telegram pattern: compact when collapsed,
  /// expandable when tapped.
  static List<Widget> searchActions({
    required BuildContext context,
    required String hint,
    required ValueChanged<String> onSearch,
    required String searchButtonLabel,
    required VoidCallback onSearchTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return [
      GestureDetector(
        onTap: onSearchTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: PlSpacing.sm),
          decoration: BoxDecoration(
            color: colors.surfaceContainer.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colors.outlineVariant.withOpacity(0.2),
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search, size: 16, color: Colors.grey),
              const SizedBox(width: PlSpacing.xs),
              Text(
                hint,
                style: TextStyle(
                  fontSize: 13,
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: PlSpacing.xs),
              const Icon(Icons.keyboard_arrow_down,
                  size: 14, color: Colors.grey),
            ],
          ),
        ),
      ),
    ];
  }
}

/// A compact search field that can be placed inside the GlassyAppBar actions.
/// When tapped, expands into a full-width search input.
class GlassySearchField extends StatefulWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool isExpanded;

  const GlassySearchField({
    super.key,
    this.hint = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.isExpanded = false,
  });

  @override
  State<GlassySearchField> createState() => _GlassySearchFieldState();
}

class _GlassySearchFieldState extends State<GlassySearchField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    if (widget.isExpanded) {
      return Container(
        width: 200,
        margin: const EdgeInsets.only(right: PlSpacing.sm),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: colors.onSurfaceVariant),
            filled: true,
            fillColor: colors.surfaceContainer.withOpacity(0.5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colors.outlineVariant.withOpacity(0.2),
                width: 0.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: PlSpacing.md,
              vertical: PlSpacing.sm,
            ),
          ),
          style: TextStyle(color: colors.onSurface),
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        widget.onTap?.call();
        _focusNode.requestFocus();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: PlSpacing.sm),
        decoration: BoxDecoration(
          color: colors.surfaceContainer.withOpacity(0.45),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colors.outlineVariant.withOpacity(0.15),
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search, size: 16, color: Colors.grey),
            const SizedBox(width: PlSpacing.xs),
            Text(
              widget.hint,
              style: TextStyle(
                fontSize: 13,
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: PlSpacing.xs),
            const Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
