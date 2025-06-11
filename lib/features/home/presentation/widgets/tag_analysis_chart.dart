import 'package:flutter/material.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

class TagAnalysisChart extends StatelessWidget {
  final Map<String, int> tagData;
  const TagAnalysisChart({super.key, required this.tagData});

  @override
  Widget build(BuildContext context) {
    if (tagData.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final int maxCount = tagData.values
        .fold(0, (prev, element) => element > prev ? element : prev);

    final colors = [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
      Colors.green.shade400,
      Colors.orange.shade400,
      Colors.purple.shade300,
    ];

    return SliverToBoxAdapter(
      child: Card(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: tagData.entries.toList().asMap().entries.map((entry) {
              final index = entry.key;
              final tagEntry = entry.value;
              return _TagProgressRow(
                label: tagEntry.key,
                value: tagEntry.value,
                totalValue: maxCount,
                color: colors[index % colors.length],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _TagProgressRow extends StatelessWidget {
  final String label;
  final int value;
  final int totalValue;
  final Color color;

  const _TagProgressRow({
    required this.label,
    required this.value,
    required this.totalValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = totalValue > 0 ? value / totalValue : 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceVariant
                            .withOpacityDouble(0.5),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      width: constraints.maxWidth * progress,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            color.withOpacityDouble(0.7),
                            color,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 30,
            child: Text(
              value.toString(),
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
