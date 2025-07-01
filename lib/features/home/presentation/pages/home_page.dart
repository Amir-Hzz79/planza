import 'package:flutter/material.dart';
import 'package:planza/core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc_builder.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

import 'package:planza/features/home/presentation/widgets/section_header.dart';
import 'package:planza/features/home/presentation/widgets/metric_item.dart';
import 'package:planza/features/home/presentation/widgets/empty_section.dart';

import 'package:planza/features/home/presentation/widgets/speed_dial_fab.dart';
import 'package:planza/core/data/models/task_model.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../../core/utils/app_date_formatter.dart';
import '../../../../core/widgets/appbar/general_app_bar.dart';
import '../../../task_managment/presentation/widgets/glassy_task_tile.dart';
import '../widgets/drawer/drawer_section.dart';
import '../widgets/goals_carousel.dart';
import '../widgets/tag_analysis_chart.dart';
import '../widgets/weekly_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Lang lang = Lang.of(context)!;

    return GoalBlocBuilder(
      onDataLoaded: (goals) {
        return TaskBlocBuilder(
          onDataLoaded: (tasks) {
            final allGoals = goals;
            final allTasks = tasks;

            final activeGoals = allGoals.where((g) => !g.isCompleted).toList();
            final tasksDueToday = allTasks.where((t) {
              if (t.isCompleted || t.dueDate == null) return false;
              return t.dueDate!.isSameDay(DateTime.now()) ||
                  t.dueDate!.isBefore(DateTime.now());
            }).toList();

            final weeklyTaskData = _getWeeklyCompletionData(allTasks);
            final tagData = _getTagCompletionData(allTasks);
            tagData.addAll({...tagData});
            final weeklyTaskCount =
                weeklyTaskData.values.fold(0, (a, b) => a + b);

            return Scaffold(
              drawer: DrawerSection(),
              floatingActionButton: const SpeedDialFab(),
              body: CustomScrollView(
                slivers: [
                  _buildSliverAppBar(context),
                  SectionHeader(title: lang.homePage_statsBar_title),
                  _buildStatsBar(context, activeGoals.length, weeklyTaskCount),
                  SectionHeader(title: lang.homePage_todaysFocus_title),
                  _buildTasksDueToday(context, tasksDueToday),
                  SectionHeader(
                    title: lang.homePage_activeGoalCarousel_title,
                  ),
                  GoalsCarousel(goals: activeGoals),
                  SectionHeader(title: lang.homePage_weeklyChart_title),
                  WeeklyChart(weeklyTasks: weeklyTaskData),
                  SectionHeader(title: lang.homePage_tagAnalysisChart_title),
                  TagAnalysisChart(tagData: tagData),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            );
          },
        );
      },
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

  Widget _buildSliverAppBar(BuildContext context) {
    final String greeting = _getGreeting(context);
    final String today =
        AppDateFormatter.of(context).formatFullDate(DateTime.now());

    return SliverAppBar(
      floating: true,
      leading: GeneralAppBar(),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(greeting,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text(today, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  String _getGreeting(BuildContext context) {
    final Lang lang = Lang.of(context)!;

    final hour = DateTime.now().hour;
    if (hour < 12) return lang.homePage_greeting_morning;
    if (hour < 17) return lang.homePage_greeting_afternoon;
    return lang.homePage_greeting_evening;
  }

  Widget _buildTasksDueToday(BuildContext context, List<TaskModel> tasks) {
    final Lang lang = Lang.of(context)!;

    if (tasks.isEmpty) {
      return EmptySection(
        icon: Icons.check_circle_outline,
        message: lang.homePage_todaysFocus_empty,
      );
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return GlassyTaskCard(task: tasks[index]);
        },
        childCount: tasks.length,
      ),
    );
  }

  Widget _buildStatsBar(
      BuildContext context, int activeGoalCount, int weeklyTaskCount) {
    final Lang lang = Lang.of(context)!;

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MetricItem(
                value: "12",
                label: lang.homePage_statsBar_streak_title,
                icon: Icons.local_fire_department_outlined,
                color: Colors.orange),
            MetricItem(
                value: activeGoalCount.toString(),
                label: lang.homePage_statsBar_activeGoals_title,
                icon: Icons.flag_outlined,
                color: Colors.blue),
            MetricItem(
                value: weeklyTaskCount.toString(),
                label: lang.homePage_statsBar_weekTasks_title,
                icon: Icons.check_circle_outline,
                color: Colors.green),
          ],
        ),
      ),
    );
  }
}
