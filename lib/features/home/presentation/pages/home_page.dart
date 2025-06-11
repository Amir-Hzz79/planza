import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:planza/features/home/presentation/widgets/section_header.dart';
import 'package:planza/features/home/presentation/widgets/metric_item.dart';
import 'package:planza/features/home/presentation/widgets/empty_section.dart';

import 'package:planza/features/home/presentation/widgets/speed_dial_fab.dart';
import 'package:planza/core/data/bloc/goal_bloc/goal_bloc.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc.dart';
import 'package:planza/core/data/models/task_model.dart';

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
    // We nest BlocBuilders to get data from both streams.
    return BlocBuilder<GoalBloc, GoalState>(
      builder: (context, goalState) {
        return BlocBuilder<TaskBloc, TaskState>(
          builder: (context, taskState) {
            // Handle loading and error states first.
            if (goalState is! GoalsLoadedState ||
                taskState is! TasksLoadedState) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            // Once both are loaded, we have all the data we need.
            final allGoals = goalState.goals;
            final allTasks = taskState.tasks;

            // Process the data for our dashboard sections.
            final activeGoals = allGoals.where((g) => !g.isCompleted).toList();
            final tasksDueToday = allTasks.where((t) {
              if (t.isCompleted || t.dueDate == null) return false;
              return t.dueDate!.isSameDay(DateTime.now()) ||
                  t.dueDate!.isBefore(DateTime.now());
            }).toList();

            final weeklyTaskData = _getWeeklyCompletionData(allTasks);
            final tagData = _getTagCompletionData(allTasks);
            final weeklyTaskCount =
                weeklyTaskData.values.fold(0, (a, b) => a + b);

            return Scaffold(
              drawer: DrawerSection(),
              floatingActionButton: const SpeedDialFab(),
              body: CustomScrollView(
                slivers: [
                  _buildSliverAppBar(context),
                  const SectionHeader(title: "Your Vital Signs"),
                  _buildStatsBar(context, activeGoals.length, weeklyTaskCount),
                  const SectionHeader(title: "Today's Action Plan ⚡"),
                  _buildTasksDueToday(tasksDueToday),
                  const SectionHeader(title: "Driving These Goals"),
                  GoalsCarousel(goals: activeGoals),
                  const SectionHeader(title: "Your Consistency"),
                  WeeklyChart(weeklyTasks: weeklyTaskData),
                  const SectionHeader(title: "Where Your Energy Goes"),
                  TagAnalysisChart(tagData: {
                    'vacation': 5,
                    'work': 10,
                    'health': 3,
                    'work2': 10,
                    'health2': 3,
                    'work3': 10,
                    'health3': 3
                  }),
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
    final String greeting = _getGreeting();
    final String today = DateFormat.yMMMMd().format(DateTime.now());

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

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning!';
    if (hour < 17) return 'Good Afternoon!';
    return 'Good Evening!';
  }

  Widget _buildTasksDueToday(List<TaskModel> tasks) {
    if (tasks.isEmpty) {
      return const EmptySection(
        icon: Icons.check_circle_outline,
        message: "You're all clear for today!\nReady to plan your next move?",
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
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MetricItem(
                value: "12",
                label: "Day Streak",
                icon: Icons.local_fire_department_outlined,
                color: Colors.orange),
            MetricItem(
                value: activeGoalCount.toString(),
                label: "Active Goals",
                icon: Icons.flag_outlined,
                color: Colors.blue),
            MetricItem(
                value: weeklyTaskCount.toString(),
                label: "Tasks this Week",
                icon: Icons.check_circle_outline,
                color: Colors.green),
          ],
        ),
      ),
    );
  }
}

// Helper extension for checking date equality
extension DateOnlyCompare on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.year;
  }
}
