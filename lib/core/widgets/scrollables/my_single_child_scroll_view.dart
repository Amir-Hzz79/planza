import 'package:flutter/material.dart';

class MySingleChildScrollView extends StatelessWidget {
  const MySingleChildScrollView({
    super.key,
    required this.child,
    this.direction = Axis.vertical,
    this.controller,
    this.scrollPhysics = const BouncingScrollPhysics(),
  });

  final Widget child;
  final Axis direction;
  final ScrollController? controller;
  final ScrollPhysics? scrollPhysics;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: scrollPhysics,
      scrollDirection: direction,
      controller: controller,
      child: child,
    );
  }
}
