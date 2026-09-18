import 'package:flutter/material.dart';
import 'package:planza/core/data/models/template_model.dart';
import 'package:planza/core/design/tokens/index.dart';

class TemplateCard extends StatelessWidget {
  final TemplateModel template;
  final VoidCallback? onTap;
  final VoidCallback? onExport;
  final VoidCallback? onShare;
  final VoidCallback? onDelete;

  const TemplateCard({
    super.key,
    required this.template,
    this.onTap,
    this.onExport,
    this.onShare,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: PlBorderRadius.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: PlBorderRadius.radiusLg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and color
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: template.color?.withOpacity(0.15) ?? theme.colorScheme.primaryContainer,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      template.icon ?? Icons.extension,
                      size: 48,
                      color: template.color ?? Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: PopupMenuButton<String>(
                      onSelected: (value) {
                        switch (value) {
                          case 'export':
                            break;
                          case 'share':
                            break;
                          case 'delete':
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'export',
                          child: ListTile(
                            leading: Icon(Icons.download),
                            title: Text('Export'),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'share',
                          child: ListTile(
                            leading: Icon(Icons.share),
                            title: Text('Share'),
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Icons.delete, color: Colors.red),
                            title: Text('Delete', style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          template.name,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (template.color ?? Theme.of(context).colorScheme.primary).withOpacity(0.15),
                          borderRadius: PlBorderRadius.radiusFull,
                        ),
                        child: Text(
                          template.category,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: template.color ?? Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (template.description != null && template.description!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      template.description!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (template.isBuiltin)
                        Chip(
                          label: const Text('Built-in'),
                          avatar: const Icon(Icons.verified, size: 14),
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        )
                      else
                        Chip(
                          label: const Text('Custom'),
                          avatar: const Icon(Icons.person, size: 14),
                          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                        ),
                      const SizedBox(width: 8),
                      if (template.updatedAt != null)
                        Text(
                          'Updated ${_formatDate(template.updatedAt!)}',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}