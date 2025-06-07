import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.onTap,
    required this.icon,
    this.shape = BoxShape.rectangle,
  });

  final void Function()? onTap;
  final Widget icon;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius:
              shape == BoxShape.rectangle ? BorderRadius.circular(20) : null,
          shape: shape,
        ),
        child: icon,
      ),
    );
  }
}
