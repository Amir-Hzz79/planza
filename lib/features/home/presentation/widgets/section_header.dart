import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool fade;
  const SectionHeader({super.key, required this.title, this.fade = false});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: fade
                    ? Colors.grey
                    : Theme.of(context).textTheme.titleLarge?.color,
              ),
        ),
      ),
    );
  }
}
