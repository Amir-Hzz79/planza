import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

class IconPicker extends StatelessWidget {
  // ... (properties remain the same)
  final List<IconData> icons;
  final IconData selectedIcon;
  final ValueChanged<IconData> onIconSelected;
  final Color selectedColor;

  const IconPicker({
    super.key,
    required this.icons,
    required this.selectedIcon,
    required this.onIconSelected,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    // --- CHANGE: Reduced height for a more compact look ---
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: icons.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final icon = icons[index];
          final bool isSelected = icon == selectedIcon;
          return GestureDetector(
            onTap: () => onIconSelected(icon),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              // --- CHANGE: Reduced width and height ---
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? selectedColor
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? selectedColor.matchTextColor()
                    : Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          );
        },
      ),
    );
  }
}