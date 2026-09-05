import 'package:flutter/material.dart';
import 'package:planza/core/design/primitives/index.dart';
import 'package:planza/core/design/tokens/index.dart';
import '../../data/models/tag_model.dart';

class TagChip extends StatelessWidget {
  final TagModel tag;
  final VoidCallback? onTap;
  final VoidCallback? onDeleted;
  final bool isSelected;
  final bool showColor;

  const TagChip({
    super.key,
    required this.tag,
    this.onTap,
    this.onDeleted,
    this.isSelected = false,
    this.showColor = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final tagColor = Color(tag.id * 0x1000000 % 0xFFFFFF | 0xFF000000);

    return PlChip(
      label: '#${tag.name}',
      isSelected: isSelected,
      onTap: onTap,
      onDeleted: onDeleted,
      style: showColor ? PlChipStyle.filled : PlChipStyle.outlined,
      color: showColor ? tagColor.withOpacity(0.15) : null,
      labelColor: showColor ? tagColor : null,
      icon: showColor ? Icons.label : null,
    );
  }
}

class TagChips extends StatelessWidget {
  final List<TagModel> tags;
  final ValueChanged<TagModel>? onTap;
  final ValueChanged<TagModel>? onDelete;
  final int maxVisible;
  final bool showColor;

  const TagChips({
    super.key,
    required this.tags,
    this.onTap,
    this.onDelete,
    this.maxVisible = 5,
    this.showColor = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    final visibleTags = tags.take(maxVisible).toList();
    final hiddenCount = tags.length - maxVisible;

    return Wrap(
      spacing: PlSpacing.xs,
      runSpacing: PlSpacing.xs,
      children: [
        ...visibleTags.map((tag) => TagChip(
              tag: tag,
              onTap: onTap != null ? () => onTap!(tag) : null,
              onDeleted: onDelete != null ? () => onDelete!(tag) : null,
              showColor: showColor,
            )),
        if (hiddenCount > 0)
          PlChip(
            label: '+$hiddenCount',
            style: PlChipStyle.outlined,
            icon: Icons.more_horiz,
          ),
      ],
    );
  }
}
