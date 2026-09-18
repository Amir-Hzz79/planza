import 'package:flutter/material.dart';
import 'package:planza/core/data/models/template_model.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/tokens/border_radius.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';

class TemplateCard extends StatelessWidget {
  final TemplateModel template;
  final VoidCallback? onTap;
  final VoidCallback? onExport;
  final VoidCallback? onShare;
  final VoidCallback? onUse;

  const TemplateCard({
    super.key,
    required this.template,
    this.onTap,
    this.onExport,
    this.onShare,
    this.onUse,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PlCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and category
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: template.color?.withValues(alpha: 0.15) ?? colorScheme.primaryContainer,
              borderRadius: PlBorderRadius.topMd,
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    template.icon ?? Icons.extension,
                    size: 48,
                    color: template.color ?? colorScheme.primary,
                  ),
                ),
                Positioned(
                  top: PlSpacing.sm,
                  right: PlSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.9),
                      borderRadius: PlBorderRadius.radiusSm,
                    ),
                    child: Text(
                      _getCategoryDisplayName(template.category),
                      style: PlTypography.labelSmall.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(PlSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  template.name,
                  style: PlTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (template.description != null) ...[
                  const SizedBox(height: PlSpacing.xs),
                  Text(
                    template.description!,
                    style: PlTypography.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: PlSpacing.md),

                // Action buttons
                Row(
                  children: [
                    if (onUse != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onUse,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Use'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: PlSpacing.sm),
                          ),
                        ),
                      ),
                    if (onUse != null && (onExport != null || onShare != null))
                      const SizedBox(width: PlSpacing.sm),
                    if (onExport != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onExport,
                          icon: const Icon(Icons.download, size: 18),
                          label: const Text('Export'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: PlSpacing.sm),
                          ),
                        ),
                      ),
                    if (onExport != null && onShare != null)
                      const SizedBox(width: PlSpacing.sm),
                    if (onShare != null)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onShare,
                          icon: const Icon(Icons.share, size: 18),
                          label: const Text('Share'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: PlSpacing.sm),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryDisplayName(String category) {
    switch (category.toLowerCase()) {
      case 'habit':
        return 'Habit';
      case 'project':
        return 'Project';
      case 'learning':
        return 'Learning';
      case 'fitness':
        return 'Fitness';
      case 'custom':
        return 'Custom';
      default:
        return category;
    }
  }
}