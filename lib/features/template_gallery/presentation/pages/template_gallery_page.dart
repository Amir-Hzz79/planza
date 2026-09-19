import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/template_model.dart';
import 'package:planza/core/design/primitives/pl_app_bar.dart';
import 'package:planza/core/design/primitives/pl_button.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/primitives/pl_text_field.dart';
import 'package:planza/core/design/tokens/border_radius.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';
import 'package:planza/features/template_gallery/presentation/bloc/template_gallery_bloc.dart';
import 'package:planza/features/template_gallery/presentation/widgets/template_card.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TemplateGalleryPage extends StatefulWidget {
  const TemplateGalleryPage({super.key});

  @override
  State<TemplateGalleryPage> createState() => _TemplateGalleryPageState();
}

class _TemplateGalleryPageState extends State<TemplateGalleryPage>
    with TickerProviderStateMixin {
  final _searchController = TextEditingController();
  late TabController _tabController;
  final _categories = [
    'All',
    'Habit',
    'Project',
    'Learning',
    'Fitness',
    'Custom'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    context.read<TemplateGalleryBloc>().add(LoadTemplates());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PlAppBar(
        title: 'Template Gallery',
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showCreateTemplateDialog,
            tooltip: 'Create Template',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 60),
          child: Column(
            children: [
              // Search field
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  PlSpacing.md,
                  0,
                  PlSpacing.md,
                  PlSpacing.sm,
                ),
                child: PlTextField(
                  controller: _searchController,
                  hint: 'Search templates...',
                  prefixIcon: Icons.search,
                  onChanged: (value) {
                    context
                        .read<TemplateGalleryBloc>()
                        .add(SearchTemplates(value));
                  },
                ),
              ),
              // Category tabs
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent,
                indicatorColor: colorScheme.primary,
                labelColor: colorScheme.primary,
                unselectedLabelColor: colorScheme.onSurfaceVariant,
                labelStyle: PlTypography.labelLarge
                    .copyWith(fontWeight: FontWeight.w600),
                unselectedLabelStyle: PlTypography.labelLarge,
                tabs: _categories.map((cat) => Tab(text: cat)).toList(),
                onTap: (index) {
                  final category = _categories[index].toLowerCase();
                  if (category == 'all') {
                    context
                        .read<TemplateGalleryBloc>()
                        .add(FilterByCategory('all'));
                  } else {
                    context
                        .read<TemplateGalleryBloc>()
                        .add(FilterByCategory(category));
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<TemplateGalleryBloc>().add(RefreshTemplates());
        },
        child: BlocConsumer<TemplateGalleryBloc, TemplateGalleryState>(
          listener: (context, state) {
            if (state is TemplateGalleryActionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is TemplateGalleryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message),
                    backgroundColor: colorScheme.error),
              );
            } else if (state is TemplateExportedToFile) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Template exported to: ${state.filePath}')),
              );
            } else if (state is TemplateImportedFromFile) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Template imported from: ${state.filePath}')),
              );
            } else if (state is TemplateQRCodeGenerated) {
              _showQRCodeDialog(state.qrData);
            }
          },
          builder: (context, state) {
            if (state is TemplateGalleryLoading) {
              return _buildLoadingState();
            } else if (state is TemplateGalleryLoaded) {
              if (state.templates.isEmpty) {
                return _buildEmptyState(state.searchQuery);
              }
              return _buildTemplateGrid(state.templates);
            } else if (state is TemplateGalleryError) {
              return _buildErrorState(state.message);
            }
            return _buildEmptyState(null);
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return GridView.builder(
      padding: const EdgeInsets.all(PlSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: PlSpacing.md,
        mainAxisSpacing: PlSpacing.md,
        childAspectRatio: 0.85,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildSkeletonCard(),
    );
  }

  Widget _buildSkeletonCard() {
    return PlCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: PlBorderRadius.topMd,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(PlSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                const SizedBox(height: PlSpacing.xs),
                Container(
                  height: 14,
                  width: 150,
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
                const SizedBox(height: PlSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 36,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                    ),
                    const SizedBox(width: PlSpacing.sm),
                    Expanded(
                      child: Container(
                        height: 36,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                      ),
                    ),
                    const SizedBox(width: PlSpacing.sm),
                    Expanded(
                      child: Container(
                        height: 36,
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
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

  Widget _buildEmptyState(String? searchQuery) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PlSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery != null && searchQuery.isNotEmpty
                  ? Icons.search_off
                  : Icons.extension_off,
              size: 64,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: PlSpacing.md),
            Text(
              searchQuery != null && searchQuery.isNotEmpty
                  ? 'No templates found for "$searchQuery"'
                  : 'No templates available',
              style: PlTypography.headlineSmall.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.sm),
            Text(
              searchQuery != null && searchQuery.isNotEmpty
                  ? 'Try a different search term'
                  : 'Create your first template or import one',
              style: PlTypography.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.lg),
            PlButton(
              label: searchQuery != null && searchQuery.isNotEmpty
                  ? 'Clear Search'
                  : 'Create Template',
              style: PlButtonStyle.filled,
              onPressed: searchQuery != null && searchQuery.isNotEmpty
                  ? () {
                      _searchController.clear();
                      context
                          .read<TemplateGalleryBloc>()
                          .add(SearchTemplates(''));
                    }
                  : _showCreateTemplateDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(PlSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: colorScheme.error,
            ),
            const SizedBox(height: PlSpacing.md),
            Text(
              'Error Loading Templates',
              style: PlTypography.headlineSmall.copyWith(
                color: colorScheme.error,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.sm),
            Text(
              message,
              style: PlTypography.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.lg),
            PlButton(
              label: 'Retry',
              style: PlButtonStyle.filled,
              onPressed: () {
                context.read<TemplateGalleryBloc>().add(RefreshTemplates());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateGrid(List<TemplateModel> templates) {
    return GridView.builder(
      padding: const EdgeInsets.all(PlSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: PlSpacing.md,
        mainAxisSpacing: PlSpacing.md,
        childAspectRatio: 0.85,
      ),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return TemplateCard(
          template: template,
          onTap: () => _showTemplateDetail(template),
          onUse: () => _useTemplate(template),
          onExport: () => _exportTemplate(template),
          onExportToFile: () => _exportTemplateToFile(template),
          onShare: () => _shareTemplate(template),
          onQRCode: () => _generateQRCode(template),
        );
      },
    );
  }

  void _showCreateTemplateDialog() {
    showDialog(
      context: context,
      builder: (context) => _CreateTemplateDialog(
        onCreate: (name, category) {
          // TODO: Navigate to template editor
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Template editor coming soon!')),
          );
        },
      ),
    );
  }

  void _showTemplateDetail(TemplateModel template) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: PlBorderRadius.topLg,
      ),
      builder: (context) => _TemplateDetailSheet(template: template),
    );
  }

  void _useTemplate(TemplateModel template) {
    context.read<TemplateGalleryBloc>().add(UseTemplate(template));
  }

  void _exportTemplate(TemplateModel template) {
    context.read<TemplateGalleryBloc>().add(ExportTemplate(template.id!));
  }

  void _exportTemplateToFile(TemplateModel template) {
    context.read<TemplateGalleryBloc>().add(ExportTemplateToFile(template.id!));
  }

  void _shareTemplate(TemplateModel template) {
    context.read<TemplateGalleryBloc>().add(ShareTemplate(template.id!));
  }

  void _generateQRCode(TemplateModel template) {
    context
        .read<TemplateGalleryBloc>()
        .add(GenerateTemplateQRCode(template.id!));
  }

  void _showQRCodeDialog(String qrData) {
    showDialog(
      context: context,
      builder: (context) => _QRCodeDialog(qrData: qrData),
    );
  }
}

class _CreateTemplateDialog extends StatefulWidget {
  final Function(String name, String category) onCreate;

  const _CreateTemplateDialog({required this.onCreate});

  @override
  State<_CreateTemplateDialog> createState() => _CreateTemplateDialogState();
}

class _CreateTemplateDialogState extends State<_CreateTemplateDialog> {
  final _nameController = TextEditingController();
  String _selectedCategory = 'Custom';

  final _categories = ['Habit', 'Project', 'Learning', 'Fitness', 'Custom'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Text('Create Template', style: PlTypography.headlineSmall),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PlTextField(
            controller: _nameController,
            label: 'Template Name',
            hint: 'e.g., Morning Routine',
          ),
          const SizedBox(height: PlSpacing.md),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(
                borderRadius: PlBorderRadius.radiusMd,
              ),
            ),
            items: _categories
                .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                .toList(),
            onChanged: (value) {
              setState(() => _selectedCategory = value!);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: PlTypography.labelLarge),
        ),
        PlButton(
          label: 'Create',
          style: PlButtonStyle.filled,
          onPressed: () {
            if (_nameController.text.trim().isNotEmpty) {
              widget.onCreate(_nameController.text.trim(), _selectedCategory);
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}

class _TemplateDetailSheet extends StatelessWidget {
  final TemplateModel template;

  const _TemplateDetailSheet({required this.template});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(PlSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: PlSpacing.lg),

              // Icon and name
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: template.color?.withValues(alpha: 0.15) ??
                          colorScheme.primaryContainer,
                      borderRadius: PlBorderRadius.radiusMd,
                    ),
                    child: Icon(
                      template.icon ?? Icons.extension,
                      size: 32,
                      color: template.color ?? colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: PlSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          template.name,
                          style: PlTypography.headlineSmall
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: PlSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: PlSpacing.sm,
                            vertical: PlSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: PlBorderRadius.radiusSm,
                          ),
                          child: Text(
                            _getCategoryDisplayName(template.category),
                            style: PlTypography.labelSmall.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: PlSpacing.lg),

              // Description
              if (template.description != null) ...[
                Text('Description', style: PlTypography.titleMedium),
                const SizedBox(height: PlSpacing.sm),
                Text(
                  template.description!,
                  style: PlTypography.bodyMedium.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: PlSpacing.lg),
              ],

              // Payload preview
              Text('Template Contents', style: PlTypography.titleMedium),
              const SizedBox(height: PlSpacing.sm),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(PlSpacing.md),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: PlBorderRadius.radiusMd,
                    ),
                    child: Text(
                      _formatPayload(template.payloadJson),
                      style: PlTypography.bodySmall.copyWith(
                        fontFamily: 'monospace',
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: PlSpacing.lg),

              // Action buttons
              Wrap(
                spacing: PlSpacing.md,
                runSpacing: PlSpacing.md,
                children: [
                  Expanded(
                    child: PlButton(
                      label: 'Use Template',
                      style: PlButtonStyle.filled,
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<TemplateGalleryBloc>()
                            .add(UseTemplate(template));
                      },
                    ),
                  ),
                  Expanded(
                    child: PlButton(
                      label: 'Export',
                      style: PlButtonStyle.outlined,
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<TemplateGalleryBloc>()
                            .add(ExportTemplate(template.id!));
                      },
                    ),
                  ),
                  Expanded(
                    child: PlButton(
                      label: 'Export to File',
                      style: PlButtonStyle.outlined,
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<TemplateGalleryBloc>()
                            .add(ExportTemplateToFile(template.id!));
                      },
                    ),
                  ),
                  Expanded(
                    child: PlButton(
                      label: 'QR Code',
                      style: PlButtonStyle.outlined,
                      onPressed: () {
                        Navigator.pop(context);
                        context
                            .read<TemplateGalleryBloc>()
                            .add(GenerateTemplateQRCode(template.id!));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
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

  String _formatPayload(String payloadJson) {
    try {
      final dynamic parsed = jsonDecode(payloadJson);
      return const JsonEncoder.withIndent('  ').convert(parsed);
    } catch (_) {
      return payloadJson;
    }
  }
}

class _QRCodeDialog extends StatelessWidget {
  final String qrData;

  const _QRCodeDialog({required this.qrData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Text('Template QR Code', style: PlTypography.headlineSmall),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QrImageView(
            data: qrData,
            version: QrVersions.auto,
            size: 200,
            backgroundColor: colorScheme.surface,
          ),
          const SizedBox(height: PlSpacing.md),
          Text(
            'Scan to import template',
            style: PlTypography.bodyMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: PlSpacing.sm),
          SelectableText(
            qrData,
            style: PlTypography.bodySmall.copyWith(
              fontFamily: 'monospace',
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Close', style: PlTypography.labelLarge),
        ),
      ],
    );
  }
}
