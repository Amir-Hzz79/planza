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
  final VoidCallback? onExportToFile;
  final VoidCallback? onShare;
  final VoidCallback? onUse;
  final VoidCallback? onQRCode;

  const TemplateCard({
    super.key,
    required this.template,
    this.onTap,
    this.onExport,
    this.onExportToFile,
    this.onShare,
    this.onUse,
    this.onQRCode,
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
                Wrap(
                  spacing: PlSpacing.sm,
                  runSpacing: PlSpacing.sm,
                  children: [
                    if (onUse != null)
                      _ActionButton(
                        icon: Icons.add,
                        label: 'Use',
                        onPressed: onUse!,
                      ),
                    if (onExport != null)
                      _ActionButton(
                        icon: Icons.download,
                        label: 'Export',
                        onPressed: onExport!,
                      ),
                    if (onExportToFile != null)
                      _ActionButton(
                        icon: Icons.save_alt,
                        label: 'File',
                        onPressed: onExportToFile!,
                      ),
                    if (onShare != null)
                      _ActionButton(
                        icon: Icons.share,
                        label: 'Share',
                        onPressed: onShare!,
                      ),
                    if (onQRCode != null)
                      _ActionButton(
                        icon: Icons.qr_code,
                        label: 'QR',
                        onPressed: onQRCode!,
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

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        minimumSize: const Size(70, 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}