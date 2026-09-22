import 'package:flutter/material.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';

class UnlockablesSection extends StatelessWidget {
  final List<int> unlockedThemes;
  final List<int> unlockedIcons;
  final List<int> unlockedAnimations;

  const UnlockablesSection({
    super.key,
    required this.unlockedThemes,
    required this.unlockedIcons,
    required this.unlockedAnimations,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Unlockables',
              style:
                  PlTypography.titleLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: () => _showAllUnlockables(context),
              icon: const Icon(Icons.expand_more, size: 18),
              label: Text('View All', style: PlTypography.labelLarge),
            ),
          ],
        ),
        const SizedBox(height: PlSpacing.md),
        if (unlockedThemes.isEmpty &&
            unlockedIcons.isEmpty &&
            unlockedAnimations.isEmpty)
          _buildEmptyState(context)
        else
          Column(
            children: [
              if (unlockedThemes.isNotEmpty)
                _buildUnlockableCategory(
                  context: context,
                  title: 'Themes',
                  icon: Icons.palette,
                  color: Colors.purple,
                  items: unlockedThemes,
                  itemBuilder: (id) => _buildThemeItem(context, id),
                ),
              if (unlockedIcons.isNotEmpty)
                _buildUnlockableCategory(
                  context: context,
                  title: 'Icons',
                  icon: Icons.image,
                  color: Colors.blue,
                  items: unlockedIcons,
                  itemBuilder: (id) => _buildIconItem(context, id),
                ),
              if (unlockedAnimations.isNotEmpty)
                _buildUnlockableCategory(
                  context: context,
                  title: 'Animations',
                  icon: Icons.animation,
                  color: Colors.orange,
                  items: unlockedAnimations,
                  itemBuilder: (id) => _buildAnimationItem(context, id),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return PlCard(
      padding: const EdgeInsets.all(PlSpacing.xl),
      child: Column(
        children: [
          Icon(
            Icons.lock_outline,
            size: 48,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: PlSpacing.md),
          Text(
            'No Unlockables Yet',
            style: PlTypography.titleMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: PlSpacing.xs),
          Text(
            'Complete tasks, level up, and reach milestones to unlock themes, icons, and animations!',
            style: PlTypography.bodyMedium.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockableCategory({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required List<int> items,
    required Widget Function(int) itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: PlSpacing.sm),
            Text(
              '$title (${items.length})',
              style: PlTypography.titleMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: PlSpacing.md),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: PlSpacing.md),
            itemBuilder: (context, index) {
              return itemBuilder(items[index]);
            },
          ),
        ),
        const SizedBox(height: PlSpacing.lg),
      ],
    );
  }

  Widget _buildThemeItem(BuildContext context, int themeId) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Default themes (0 = default, 1-7 = unlockable palettes)
    final List<List<int>> themeColors = <List<int>>[
      <int>[
        colorScheme.primary.toARGB32(),
        colorScheme.secondary.toARGB32(),
        colorScheme.tertiary.toARGB32()
      ],
      <int>[0xFF6366F1, 0xFF8B5CF6, 0xFFEC4899],
      <int>[0xFF14B8A6, 0xFF22C55E, 0xFFEAB308],
      <int>[0xFFF97316, 0xFFEF4444, 0xFFEC4899],
      <int>[0xFF6366F1, 0xFF06B6D4, 0xFF84CC16],
      <int>[0xFFEC4899, 0xFFF97316, 0xFF22C55E],
      <int>[0xFF8B5CF6, 0xFF06B6D4, 0xFFF97316],
      <int>[0xFF14B8A6, 0xFF6366F1, 0xFFF97316],
    ];

    final List<int> colors =
        themeId < themeColors.length ? themeColors[themeId] : themeColors[0];

    return Container(
      width: 80,
      padding: const EdgeInsets.all(PlSpacing.sm),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                3,
                (i) => Container(
                      width: 16,
                      height: 16,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: Color(colors[i]),
                        shape: BoxShape.circle,
                      ),
                    )),
          ),
          const SizedBox(height: PlSpacing.xs),
          Text(
            themeId == 0 ? 'Default' : 'Theme $themeId',
            style: PlTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIconItem(BuildContext context, int iconId) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Sample icons
    final icons = [
      Icons.star,
      Icons.favorite,
      Icons.bolt,
      Icons.diamond,
      Icons.workspace_premium,
      Icons.military_tech,
      Icons.auto_awesome,
      Icons.celebration,
    ];

    final icon = iconId < icons.length ? icons[iconId] : icons[0];

    return Container(
      width: 80,
      padding: const EdgeInsets.all(PlSpacing.sm),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: colorScheme.primary, size: 32),
          const SizedBox(height: PlSpacing.xs),
          Text(
            'Icon ${iconId + 1}',
            style: PlTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationItem(BuildContext context, int animationId) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Sample animations
    final animations = [
      'Confetti',
      'Fireworks',
      'Sparkles',
      'Bounce',
      'Pulse',
      'Shake',
      'Glow',
      'Rainbow',
    ];

    final name = animationId < animations.length
        ? animations[animationId]
        : 'Animation ${animationId + 1}';

    return Container(
      width: 100,
      padding: const EdgeInsets.all(PlSpacing.sm),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.auto_awesome,
              color: colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(height: PlSpacing.xs),
          Text(
            name,
            style: PlTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAllUnlockables(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.all(PlSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: PlSpacing.lg),
                Text(
                  'All Unlockables',
                  style: PlTypography.headlineSmall
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: PlSpacing.lg),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (unlockedThemes.isNotEmpty) ...[
                          Text('Themes (${unlockedThemes.length})',
                              style: PlTypography.titleMedium
                                  .copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: PlSpacing.sm),
                          Wrap(
                            spacing: PlSpacing.md,
                            runSpacing: PlSpacing.md,
                            children: unlockedThemes
                                .map((id) => _buildThemeItem(context, id))
                                .toList(),
                          ),
                          const SizedBox(height: PlSpacing.lg),
                        ],
                        if (unlockedIcons.isNotEmpty) ...[
                          Text('Icons (${unlockedIcons.length})',
                              style: PlTypography.titleMedium
                                  .copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: PlSpacing.sm),
                          Wrap(
                            spacing: PlSpacing.md,
                            runSpacing: PlSpacing.md,
                            children: unlockedIcons
                                .map((id) => _buildIconItem(context, id))
                                .toList(),
                          ),
                          const SizedBox(height: PlSpacing.lg),
                        ],
                        if (unlockedAnimations.isNotEmpty) ...[
                          Text('Animations (${unlockedAnimations.length})',
                              style: PlTypography.titleMedium
                                  .copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: PlSpacing.sm),
                          Wrap(
                            spacing: PlSpacing.md,
                            runSpacing: PlSpacing.md,
                            children: unlockedAnimations
                                .map((id) => _buildAnimationItem(context, id))
                                .toList(),
                          ),
                        ],
                        if (unlockedThemes.isEmpty &&
                            unlockedIcons.isEmpty &&
                            unlockedAnimations.isEmpty) ...[
                          _buildEmptyState(context),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
