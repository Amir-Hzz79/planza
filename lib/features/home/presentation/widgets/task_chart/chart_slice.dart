import 'package:flutter/material.dart';

class ChartSlice extends StatelessWidget {
  const ChartSlice({
    super.key,
    required this.color,
    required this.height,
    required this.bottomRadius,
    required this.topRadius,
  });

  final double height;
  final Color color;
  final bool bottomRadius;
  final bool topRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      /* width: 30, */
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: topRadius ? Radius.circular(20) : Radius.circular(0),
            topRight: topRadius ? Radius.circular(20) : Radius.circular(0),
            bottomLeft: bottomRadius ? Radius.circular(20) : Radius.circular(0),
            bottomRight:
                bottomRadius ? Radius.circular(20) : Radius.circular(0),
          ),
        ),
      ),
    );
  }
}
