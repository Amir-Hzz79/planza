import 'package:flutter/material.dart';
import 'package:planza/features/home/presentation/widgets/goal_counter/goal_counter_list_item.dart';

import '../../../../../core/widgets/scrollables/scrollable_row.dart';

class GoalCounterList extends StatelessWidget {
  const GoalCounterList(
      {super.key, required this.items, required this.spacing});

  final List<GoalCounterListItem> items;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return ScrollableRow(
      children: [
        for (int i = 0; i < items.length; i++) ...[
          items[i],
          if (i < items.length - 1) SizedBox(width: spacing),
        ],
      ],
    );
  }
}
