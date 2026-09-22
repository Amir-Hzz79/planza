import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/data/models/hobby_model.dart';

import 'package:planza/core/design/composites/highlights_strip.dart';
import 'package:planza/core/design/primitives/glassy_container.dart'
    as glassy_container;
import 'package:planza/core/design/primitives/glassy_container.dart';
import 'package:planza/core/design/primitives/glassy_fab.dart';
import 'package:planza/core/design/tokens/colors.dart';
import 'package:planza/core/design/tokens/spacing.dart';
import 'package:planza/core/design/tokens/border_radius.dart';
import 'package:planza/core/design/tokens/index.dart';
import 'package:planza/features/hobbies_habits/presentation/bloc/hobbies_bloc_builder.dart';

import 'package:planza/features/home/presentation/widgets/section_header.dart';
import 'package:planza/features/home/presentation/widgets/goals_carousel.dart';
import 'package:planza/features/home/presentation/widgets/tag_analysis_chart.dart';
import 'package:planza/features/home/presentation/widgets/drawer/drawer_section.dart';

import '../../../../core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import '../../../../core/data/bloc/goal_bloc/goal_bloc.dart';
import '../../../../core/data/bloc/task_bloc/task_bloc_builder.dart';
import '../../../../core/data/bloc/task_bloc/task_bloc.dart';
import '../../../../core/data/bloc/user_stats_bloc/user_stats_bloc.dart';
import '../../../../core/locale/bloc/locale_bloc.dart';
import '../../../../core/locale/bloc/locale_state.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../../core/utils/app_date_formatter.dart';
import '../../../../core/utils/extention_methods/date_time_extentions.dart';
import '../../../../core/data/database/database.dart';

import '../../../task_managment/presentation/widgets/glassy_task_tile.dart';
import '../../../task_managment/presentation/widgets/task_entry_sheet.dart';
import '../../../../features/goal_managment/presentation/pages/goal_entry_page.dart';
import '../../../../features/goal_managment/presentation/pages/goal_entry_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool _searchExpanded = false;
  late AnimationController _fabAnimationController;
  bool _isFabOpen = false;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _toggleFab() {
    setState(() {
      _isFabOpen = !_isFabOpen;
      if (_isFabOpen) {
        _fabAnimationController.forward();
      } else {
        _fabAnimationController.reverse();
      }
    });
  }

  void _showAddDataConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final Lang lang = Lang.of(ctx)!;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(ctx).viewInsets.bottom + 64,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                lang.homePage_fab_confirmation,
                style: Theme.of(ctx).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: Text(lang.general_cancel),
                  ),
                  TextButton(
                    onPressed: () {
                      String localeCode =
                          (ctx.read<LocaleBloc>().state as LocaleLoadedState)
                              .locale
                              .languageCode;
                      final db = GetIt.instance.get<AppDatabase>();
                      if (localeCode == 'en') {
                        db.insertEnDummyData();
                      } else if (localeCode == 'fa') {
                        db.insertFaDummyData();
                      }
                      setState(() {});
                      Navigator.pop(ctx);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(ctx).colorScheme.error,
                    ),
                    child: Text(lang.general_deleteConfirm),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Lang lang = Lang.of(context)!;

    return GoalBlocBuilder(
      onDataLoaded: (goals) {
        return TaskBlocBuilder(
          onDataLoaded: (tasks) {
            return HobbiesBlocBuilder(
              onDataLoaded: (hobbies) {
                return BlocBuilder<UserStatsBloc, UserStatsState>(
                  builder: (context, statsState) {
                    final allGoals = goals;
                    final allTasks = tasks;
                    final allHobbies = hobbies;

                    final activeGoals =
                        allGoals.where((g) => !g.isCompleted).toList();
                    final tasksDueToday = allTasks.where((t) {
                      if (t.isCompleted || t.dueDate == null) return false;
                      return t.dueDate!.isSameDay(DateTime.now()) ||
                          t.dueDate!.isBefore(DateTime.now());
                    }).toList();

                    final tagData = _getTagCompletionData(allTasks);

                    // Build highlights strip data
                    final formatter = AppDateFormatter.of(context);
                    final pinnedGoals = _getPinnedGoals(activeGoals, formatter);
                    final todayFocus = _buildTodayFocus(tasksDueToday);
                    final streakData = _buildStreakGlance(statsState);
                    final recentSession = _buildRecentHobbySession(allHobbies);

                    final theme = Theme.of(context);
                    final isDark = theme.brightness == Brightness.dark;
                    final colors = isDark ? darkColors : lightColors;

                    return Scaffold(
                      drawer: DrawerSection(),
                      body: CustomScrollView(
                        slivers: [
                          // ── Compact Glassy Header ──
                          _buildCompactHeader(context, lang, colors, isDark),

                          // ── Highlights Strip (Telegram Stories analogue) ──
                          if (pinnedGoals.isNotEmpty ||
                              todayFocus != null ||
                              streakData != null)
                            SliverToBoxAdapter(
                              child: HighlightsStrip(
                                pinnedGoals: pinnedGoals,
                                todayFocus: todayFocus,
                                streakData: streakData,
                                recentHobbySession: recentSession,
                              ),
                            ),

                          // ── Today's Focus ──
                          SectionHeader(title: lang.homePage_todaysFocus_title),
                          _buildTasksDueToday(context, tasksDueToday),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: PlSpacing.md),
                          ),

                          // ── Active Goals Carousel ──
                          SectionHeader(
                            title: lang.homePage_activeGoalCarousel_title,
                          ),
                          GoalsCarousel(goals: activeGoals),

                          // ── Tag Analysis ──
                          SectionHeader(
                            title: lang.homePage_tagAnalysisChart_title,
                          ),
                          TagAnalysisChart(tagData: tagData),

                          const SliverToBoxAdapter(child: SizedBox(height: 80)),
                        ],
                      ),
                      floatingActionButton: _searchExpanded
                          ? null
                          : Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                // Speed Dial (glassy)
                                if (!_isFabOpen) ...[
                                  Positioned(
                                    right: 16,
                                    bottom: 100,
                                    child: GlassyFAB(
                                      icon: Icons.add,
                                      size: 52,
                                      activeColor: colors.primary,
                                      onPressed: _toggleFab,
                                    ),
                                  ),
                                ],
                                // Speed Dial items
                                if (_isFabOpen) ...[
                                  _buildFabItem(
                                    context,
                                    colors,
                                    'Add Task',
                                    Icons.task_alt,
                                    () {
                                      _toggleFab();
                                      _showTaskEntrySheet(context);
                                    },
                                    0,
                                  ),
                                  _buildFabItem(
                                    context,
                                    colors,
                                    'Add Goal',
                                    Icons.flag,
                                    () {
                                      _toggleFab();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (_) => const GoalEntryPage(),
                                      ));
                                    },
                                    1,
                                  ),
                                  _buildFabItem(
                                    context,
                                    colors,
                                    'Add Template',
                                    Icons.code,
                                    () {
                                      _toggleFab();
                                      _showAddDataConfirmation(context);
                                    },
                                    2,
                                  ),
                                ],
                              ],
                            ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFabItem(
    BuildContext context,
    PlColorScheme colors,
    String label,
    IconData icon,
    VoidCallback onTap,
    int index,
  ) {
    final progress = _fabAnimationController.value;
    final opacity = (progress > 0.3 ? (progress - 0.3) / 0.7 : 0.0);
    final translateY = -index * 56.0 * (1 - progress.clamp(0.0, 1.0));

    return Opacity(
      opacity: opacity,
      child: Transform.translate(
        offset: Offset(0, translateY),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(right: PlSpacing.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.outlineVariant.withOpacity(0.25),
                      width: 0.5,
                    ),
                  ),
                  child: Center(
                    child: GlassyContainer(
                      blur: 8,
                      opacity: 0.35,
                      borderRadius: PlBorderRadius.radiusLiquid,
                      tintColor: colors.primary.withOpacity(0.08),
                      shadows: [
                        BoxShadow(
                          color: colors.primary.withOpacity(0.15),
                          offset: const Offset(0, 2),
                          blurRadius: 12,
                        ),
                      ],
                      padding: const EdgeInsets.all(7),
                      child: Icon(icon, size: 20, color: colors.primary),
                    ),
                  ),
                ),
                const SizedBox(width: PlSpacing.sm),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Compact Header ────────────────────────────────────────────────────

  Widget _buildCompactHeader(
    BuildContext context,
    Lang lang,
    PlColorScheme colors,
    bool isDark,
  ) {
    final greeting = _getGreeting(context, lang);
    final todayDate =
        AppDateFormatter.of(context).formatFullDate(DateTime.now());

    // Actions: search toggle + overflow menu
    final actions = [
      _SearchToggle(
        isActive: _searchExpanded,
        onTap: () => setState(() => _searchExpanded = !_searchExpanded),
        colors: colors,
      ),
      const SizedBox(width: PlSpacing.xs),
      PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, size: 20),
        padding: EdgeInsets.zero,
        color: colors.surfaceContainer.withOpacity(0.6),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'theme',
            child: Row(
              children: [
                Icon(Icons.palette_rounded, size: 18, color: colors.onSurface),
                const SizedBox(width: PlSpacing.sm),
                Text('Theme', style: TextStyle(color: colors.onSurface)),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'settings',
            child: Row(
              children: [
                Icon(Icons.settings_rounded, size: 18, color: colors.onSurface),
                const SizedBox(width: PlSpacing.sm),
                Text('Settings', style: TextStyle(color: colors.onSurface)),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'calendar',
            child: Row(
              children: [
                Icon(Icons.calendar_today_rounded,
                    size: 18, color: colors.onSurface),
                const SizedBox(width: PlSpacing.sm),
                Text('Calendar', style: TextStyle(color: colors.onSurface)),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'locale',
            child: Row(
              children: [
                Icon(Icons.language_rounded, size: 18, color: colors.onSurface),
                const SizedBox(width: PlSpacing.sm),
                Text('Language', style: TextStyle(color: colors.onSurface)),
              ],
            ),
          ),
        ],
      ),
    ];

    return SliverAppBar(
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greeting,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.onSurface,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            todayDate,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              color: colors.onSurfaceVariant,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  // ── Tasks Due Today ────────────────────────────────────────────────────

  Widget _buildTasksDueToday(
    BuildContext context,
    List<TaskModel> tasks,
  ) {
    final Lang lang = Lang.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    if (tasks.isEmpty) {
      return SliverToBoxAdapter(
        child: GlassyCard(
          blur: 14,
          opacity: 0.5,
          margin: EdgeInsets.symmetric(horizontal: PlSpacing.md),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: PlSpacing.md),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 32,
                  color: colors.onSurfaceVariant,
                ),
                const SizedBox(width: PlSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.homePage_todaysFocus_empty,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: PlSpacing.xs),
                      TextButton.icon(
                        onPressed: () => _showTaskEntrySheet(context),
                        icon: const Icon(Icons.add, size: 16),
                        label: Text(lang.homePage_todaysFocus_empty_button),
                        style: TextButton.styleFrom(
                          foregroundColor: colors.primary,
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GlassyTaskCard(
          task: tasks[index],
          onTap: () {},
        ),
        childCount: tasks.length,
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────

  String _getGreeting(BuildContext context, Lang lang) {
    final hour = DateTime.now().hour;
    if (hour < 12) return lang.homePage_greeting_morning;
    if (hour < 17) return lang.homePage_greeting_afternoon;
    return lang.homePage_greeting_evening;
  }

  List<GoalHighlight> _getPinnedGoals(
      List<GoalModel> activeGoals, AppDateFormatter formatter) {
    return activeGoals.take(3).map((g) {
      final completed = g.tasks.where((t) => t.isCompleted).length;
      final total = g.tasks.length;
      return GoalHighlight(
        name: g.name,
        progress: completed,
        total: total > 0 ? completed : 0,
        dueDate:
            g.deadline != null ? formatter.formatShortDate(g.deadline!) : null,
        color: g.color,
        icon: g.icon,
      );
    }).toList();
  }

  TodayFocus? _buildTodayFocus(List<TaskModel> tasksDueToday) {
    if (tasksDueToday.isEmpty) return null;

    final overdue =
        tasksDueToday.where((t) => t.dueDate!.isBefore(DateTime.now())).length;
    final due = tasksDueToday.length - overdue;

    return TodayFocus(
      tasksDue: due,
      tasksOverdue: overdue,
      sessionsToday: 0,
      subtitle: overdue > 0 ? 'Need attention' : 'On track',
    );
  }

  StreakGlance? _buildStreakGlance(UserStatsState state) {
    if (state is! UserStatsLoaded) return null;
    final stats = state.stats;
    if (stats.currentStreak <= 0) return null;

    return StreakGlance(
      streak: stats.currentStreak,
      level: stats.level,
      xp: stats.xp,
      xpNext: stats.xpForNextLevel,
    );
  }

  RecentHobbySession? _buildRecentHobbySession(List<HobbyModel> hobbies) {
    if (hobbies.isEmpty) return null;

    final today = DateTime.now();
    final recent = hobbies.first;
    return RecentHobbySession(
      hobbyName: recent.name,
      duration: '25 min',
      date: today,
      color: Color(recent.color ?? 0xFF3B82F6),
    );
  }

  Map<int, int> _getWeeklyCompletionData(List<TaskModel> tasks) {
    final Map<int, int> weeklyData = {for (int i = 0; i < 7; i++) i: 0};
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final weekStartDay =
        DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);

    for (final task in tasks) {
      if (task.isCompleted &&
          task.doneDate != null &&
          !task.doneDate!.isBefore(weekStartDay)) {
        weeklyData[task.doneDate!.weekday - 1] =
            (weeklyData[task.doneDate!.weekday - 1] ?? 0) + 1;
      }
    }
    return weeklyData;
  }

  Map<String, int> _getTagCompletionData(List<TaskModel> tasks) {
    final Map<String, int> tagCounts = {};
    final completedTasks = tasks.where((t) => t.isCompleted);

    for (final task in completedTasks) {
      for (final tag in task.tags) {
        tagCounts.update(tag.name, (value) => value + 1, ifAbsent: () => 1);
      }
    }

    final sortedEntries = tagCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Map.fromEntries(sortedEntries);
  }

  void _showTaskEntrySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => TaskEntrySheet(
        onSubmit: (newTask) {
          context.read<TaskBloc>().add(TaskAddedEvent(newTask: newTask));
          Navigator.pop(ctx);
        },
      ),
    );
  }
}

/// A toggle button that shows/hides search in the header.
class _SearchToggle extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  final PlColorScheme colors;

  const _SearchToggle({
    required this.isActive,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: PlSpacing.sm, vertical: PlSpacing.xs),
        decoration: BoxDecoration(
          color: colors.surfaceContainer.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colors.outlineVariant.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 16,
              color: isActive ? colors.primary : colors.onSurfaceVariant,
            ),
            const SizedBox(width: PlSpacing.xs),
            Text(
              isActive ? 'Close' : 'Search',
              style: TextStyle(
                fontSize: 13,
                color: isActive ? colors.primary : colors.onSurfaceVariant,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            const SizedBox(width: PlSpacing.xs),
            Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: isActive ? colors.primary : colors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
