import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({
    super.key,
    required this.color,
    required this.onTap,
    required this.selected,
  });

  final Color color;
  final void Function() onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: selected
              ? Border.all(
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 1.5,
                )
              : null,
        ),
        child: CircleAvatar(
          backgroundColor: color,
          radius: 15,
        ),
      ),
    );
  }
}
