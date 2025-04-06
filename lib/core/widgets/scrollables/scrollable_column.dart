import 'package:flutter/material.dart';

import 'my_single_child_scroll_view.dart';

class ScrollableColumn extends StatelessWidget {
  const ScrollableColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.scrollController,
    this.mainAxisSize,
    this.scrollPhysics = const ClampingScrollPhysics(),
    this.spacing = 0,
  });

  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final ScrollController? scrollController;
  final MainAxisSize? mainAxisSize;
  final ScrollPhysics? scrollPhysics;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return MySingleChildScrollView(
      controller: scrollController,
      scrollPhysics: scrollPhysics,
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize ?? MainAxisSize.max,
        crossAxisAlignment: crossAxisAlignment,
        spacing: spacing,
        children: children,
      ),
    );
  }
}
