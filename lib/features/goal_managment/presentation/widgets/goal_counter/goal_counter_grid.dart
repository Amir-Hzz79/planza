import 'package:flutter/material.dart';

import 'goal_counter_list_item.dart';

class GoalCounterGrid extends StatelessWidget {
  const GoalCounterGrid({super.key, required this.items});

  final List<GoalCounterItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 3.5,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      shrinkWrap: false,
      children: items,
    );
  }
}
