import 'package:flutter/material.dart';

class PrioritySelectionSheet extends StatelessWidget {
  final int? initialPriority;
  const PrioritySelectionSheet({super.key, this.initialPriority});

  @override
  Widget build(BuildContext context) {
    final priorities = {
      1: "High",
      2: "Medium",
      3: "Low",
      -1: "No Priority", // Use -1 to represent null
    };
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: priorities.entries.map((entry) {
        return ListTile(
          title: Text(entry.value),
          onTap: () => Navigator.of(context).pop(entry.key),
        );
      }).toList(),
    );
  }
}
