import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/bloc/user_stats_bloc/user_stats_bloc.dart';
import 'package:planza/core/data/models/user_stats_model.dart';
import 'package:planza/core/design/composites/progress_ring.dart';
import 'package:planza/core/design/composites/streak_counter.dart';
import 'package:planza/core/design/primitives/pl_app_bar.dart';
import 'package:planza/core/design/primitives/pl_card.dart';
import 'package:planza/core/design/primitives/pl_button.dart';
import 'package:planza/core/design/tokens/colors.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/typography.dart';
import 'package:planza/features/gamification/presentation/widgets/unlockables_section.dart';
import 'package:planza/features/gamification/presentation/widgets/xp_level_card.dart';
import 'package:planza/features/gamification/presentation/widgets/stats_grid.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserStatsBloc>().add(LoadUserStats());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: PlAppBar(
        title: 'Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsDialog,
            tooltip: 'Settings',
          ),
        ],
      ),
      body: BlocBuilder<UserStatsBloc, UserStatsState>(
        builder: (context, state) {
          if (state is UserStatsLoading) {
            return _buildLoadingState();
          } else if (state is UserStatsLoaded) {
            return _buildProfileContent(state.stats);
          } else if (state is UserStatsError) {
            return _buildErrorState(state.message);
          }
          return _buildLoadingState();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView(
      padding: const EdgeInsets.all(PlSpacing.md),
      children: [
        _buildSkeletonCard(height: 200),
        const SizedBox(height: PlSpacing.md),
        _buildSkeletonCard(height: 120),
        const SizedBox(height: PlSpacing.md),
        _buildSkeletonCard(height: 200),
      ],
    );
  }

  Widget _buildSkeletonCard({required double height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
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
            Icon(Icons.error_outline, size: 64, color: colorScheme.error),
            const SizedBox(height: PlSpacing.md),
            Text(
              'Failed to Load Profile',
              style: PlTypography.headlineSmall.copyWith(color: colorScheme.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.sm),
            Text(
              message,
              style: PlTypography.bodyMedium.copyWith(color: colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: PlSpacing.lg),
            PlButton(
              label: 'Retry',
              style: PlButtonStyle.filled,
              onPressed: () {
                context.read<UserStatsBloc>().add(LoadUserStats());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileContent(UserStatsModel stats) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserStatsBloc>().add(LoadUserStats());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(PlSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // XP & Level Card
            XpLevelCard(stats: stats),
            const SizedBox(height: PlSpacing.lg),

            // Stats Grid
            StatsGrid(stats: stats),
            const SizedBox(height: PlSpacing.lg),

            // Streak Counter
            StreakCounter(
              currentStreak: stats.currentStreak,
              longestStreak: stats.longestStreak,
              size: 100,
              showLabel: true,
              animated: true,
            ),
            const SizedBox(height: PlSpacing.lg),

            // Unlockables Section
            UnlockablesSection(
              unlockedThemes: stats.unlockedThemes,
              unlockedIcons: stats.unlockedIcons,
              unlockedAnimations: stats.unlockedAnimations,
            ),
            const SizedBox(height: PlSpacing.xl),
          ],
        ),
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Profile Settings', style: PlTypography.headlineSmall),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.refresh),
              title: Text('Reset Stats', style: PlTypography.titleMedium),
              subtitle: Text('Reset all XP, level, and streaks', style: PlTypography.bodySmall),
              onTap: () {
                Navigator.pop(context);
                _showResetConfirmation();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: Text('About Gamification', style: PlTypography.titleMedium),
              subtitle: Text('Learn how XP and levels work', style: PlTypography.bodySmall),
              onTap: () {
                Navigator.pop(context);
                _showGamificationInfo();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: PlTypography.labelLarge),
          ),
        ],
      ),
    );
  }

  void _showResetConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset All Stats?', style: PlTypography.headlineSmall),
        content: Text(
          'This will permanently delete all your XP, level, streaks, and unlockables. This action cannot be undone.',
          style: PlTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: PlTypography.labelLarge),
          ),
          PlButton(
            label: 'Reset',
            style: PlButtonStyle.destructive,
            onPressed: () {
              Navigator.pop(context);
              context.read<UserStatsBloc>().add(ResetStats());
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Stats reset successfully')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showGamificationInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('How Gamification Works', style: PlTypography.headlineSmall),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoSection('XP & Levels', [
                'Complete tasks to earn XP (10 XP per task)',
                'Complete goals to earn bonus XP (100 XP per goal)',
                'Create templates to earn XP (50 XP per template)',
                'Level up by accumulating XP',
                'Each level requires more XP than the previous',
              ]),
              const SizedBox(height: PlSpacing.md),
              _buildInfoSection('Streaks', [
                'Complete at least one task per day to maintain your streak',
                'Missing a day resets your current streak',
                'Your longest streak is saved',
                'Milestone rewards at 3, 7, 14, 30, 60, 100, 365 days',
              ]),
              const SizedBox(height: PlSpacing.md),
              _buildInfoSection('Unlockables', [
                'Unlock new themes at certain levels',
                'Unlock new icons and animations',
                'Access them from the unlockables section',
              ]),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Got it!', style: PlTypography.labelLarge),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: PlTypography.titleMedium.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: PlSpacing.sm),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: PlSpacing.xs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('• ', style: PlTypography.bodyMedium),
              Expanded(child: Text(item, style: PlTypography.bodyMedium)),
            ],
          ),
        )),
      ],
    );
  }
}