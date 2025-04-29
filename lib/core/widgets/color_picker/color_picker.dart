import 'package:flutter/material.dart';
import 'package:planza/core/widgets/scrollables/scrollable_row.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    super.key,
    required this.onChange,
    this.initialColor,
  });

  final Color? initialColor;
  final void Function(Color? newColor) onChange;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final List<Color> colors = [
    Colors.grey,
    Color(0xFFffc8dd),
    Color(0xFFbde0fe),
    Color(0xFFa2d2ff),
    Color(0xFFffafcc),
    Color(0xFFcdb4db),
    Color(0xFFb9fbc0),
    Color(0xFFffd6a5),
    Color(0xFFf4a261),
    Color(0xFFe9c46a),
    Colors.cyan,
    Colors.orangeAccent,
    Colors.pinkAccent,
  ];

  Color? selectedColor;

  @override
  void initState() {
    selectedColor = widget.initialColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollableRow(
      spacing: 10,
      children: List.generate(
        colors.length,
        (index) => InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: () {
            setState(() {
              selectedColor = colors[index];

              widget.onChange.call(selectedColor);
            });
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: selectedColor == colors[index]
                  ? Border.all(
                      color: Theme.of(context).colorScheme.onSurface,
                      width: 1.5,
                    )
                  : null,
            ),
            child: CircleAvatar(
              backgroundColor: colors[index],
              radius: 15,
            ),
          ),
        ),
      ),
    );
  }
}
