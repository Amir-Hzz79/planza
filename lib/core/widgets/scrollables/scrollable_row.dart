import 'package:flutter/material.dart';

import 'my_single_child_scroll_view.dart';

class ScrollableRow extends StatelessWidget {
  const ScrollableRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.scrollController,
    this.spacing = 0,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final ScrollController? scrollController;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return MySingleChildScrollView(
      controller: scrollController,
      direction: Axis.horizontal,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        spacing: spacing,
        children: children,
      ),
    );
  }
}
