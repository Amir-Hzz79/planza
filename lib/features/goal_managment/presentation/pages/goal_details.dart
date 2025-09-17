import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import 'package:planza/features/goal_managment/presentation/pages/goal_entry_page.dart';
import 'package:planza/features/task_managment/presentation/widgets/task_entry_sheet.dart';

import '../../../../core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import '../../../../core/data/bloc/task_bloc/task_bloc.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../task_managment/presentation/widgets/detail_task_row.dart';
import '../widgets/delete_goal_sheet.dart';
import '../widgets/status_overview_dashboard.dart';

class GoalDetailsPage extends StatelessWidget {
  final int goalId;

  const GoalDetailsPage({super.key, required this.goalId});

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return GoalBlocBuilder(
      onDataLoaded: (goals) {
        final GoalModel? goal = goals
            .where(
              (g) => g.id == goalId,
            )
            .firstOrNull;

        if (goal == null) {
          return Scaffold(
            body: Center(
              child: Text(lang.goalDetailsPage_notExist),
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  ModalBottomSheetRoute(
                    showDragHandle: true,
                    builder: (context) => IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TaskEntrySheet(
                          initialTask: TaskModel(title: '', goal: goal),
                          onSubmit: (newTask) {
                            context
                                .read<TaskBloc>()
                                .add(TaskAddedEvent(newTask: newTask));
                          },
                        ),
                      ),
                    ),
                    isScrollControlled: true,
                  ),
                );
              },
              backgroundColor: goal.color,
              child: Icon(Icons.add, color: goal.color.matchTextColor()),
            ),
            body: CustomScrollView(
              slivers: [
                _buildSliverAppBar(context, goal),
                SliverToBoxAdapter(
                  child: StatusOverviewDashboard(goal: goal),
                ),
                if (goal.description?.isNotEmpty ?? false)
                  _buildDescription(context, goal),
                _buildTaskListHeader(context, goal),
                _buildTaskList(goal),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSliverAppBar(BuildContext context, GoalModel goal) {
    Lang lang = Lang.of(context)!;

    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      stretch: true,
      backgroundColor: goal.color.withOpacityDouble(0.8),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_rounded,
          color: goal.color.matchTextColor(),
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert_rounded,
            color: goal.color.matchTextColor(),
          ),
          onSelected: (value) {
            if (value == 'delete') {
              _showDeleteBottomSheet(context, goal);
            } else if (value == 'edit') {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GoalEntryPage(
                    initialGoal: goal,
                  ),
                ),
              );
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text(lang.goalDetailsPage_editGoal),
              ),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text(lang.goalDetailsPage_deleteGoal),
              ),
            ),
          ],
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          goal.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: goal.color.matchTextColor().withOpacityDouble(0.7),
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [goal.color.withOpacityDouble(0.6), goal.color],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
            ),
            Positioned(
              left:
                  Directionality.of(context) == TextDirection.rtl ? -20 : null,
              right:
                  Directionality.of(context) == TextDirection.rtl ? null : -20,
              bottom: -20,
              child: Icon(
                goal.icon,
                size: 200,
                color: Colors.white.withOpacityDouble(0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context, GoalModel goal) {
    Lang lang = Lang.of(context)!;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lang.general_about,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(goal.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color)),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskListHeader(BuildContext context, GoalModel goal) {
    Lang lang = Lang.of(context)!;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 8.0),
        child: Text(
          lang.general_tasksCount(goal.tasks.length),
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTaskList(GoalModel goal) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final task = goal.tasks[index];
          var a = task.copyWith(goal: goal);
          return DetailedTaskRow(
            task: a,
          );
        },
        childCount: goal.tasks.length,
      ),
    );
  }

  void _showDeleteBottomSheet(BuildContext context, GoalModel goal) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return DeleteGoalSheet(goal: goal, parentContext: context);
      },
    );
  }
}
