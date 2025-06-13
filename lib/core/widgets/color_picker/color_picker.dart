import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

class ColorPicker extends StatelessWidget {
  // ... (properties remain the same)
  final List<Color> colors;
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  const ColorPicker({
    super.key,
    required this.colors,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    // --- CHANGE: Reduced height for a more compact look ---
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final color = colors[index];
          final bool isSelected = color == selectedColor;
          return GestureDetector(
            onTap: () => onColorSelected(color),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              // --- CHANGE: Reduced width and height ---
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 3,
                      )
                    : null,
              ),
              child: isSelected
                  ? Icon(Icons.check, color: color.matchTextColor(), size: 20)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
