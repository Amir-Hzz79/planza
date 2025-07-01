import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:planza/core/data/bloc/task_bloc/task_bloc.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc_builder.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../../core/utils/app_date_formatter.dart';
import '../../../goal_managment/presentation/pages/goal_details.dart';
import '../widgets/task_entry_sheet.dart';

class TaskDetailsPage extends StatelessWidget {
  final int taskId;
  const TaskDetailsPage({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return TaskBlocBuilder(
      onDataLoaded: (tasks) {
        TaskModel? task;
        try {
          task = tasks.firstWhere((t) => t.id == taskId);
        } on StateError {
          task = null;
        }

        if (task == null) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        final subtasks = tasks.where((t) => t.parentTaskId == taskId).toList();

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _TaskDetailsAppBar(task: task),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailsPanel(task: task),
                      const SizedBox(height: 32),
                      _MarkAsCompleteButton(task: task),
                    ],
                  ),
                ),
              ),
              _SubtaskListSliver(subtasks: subtasks),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        );
      },
    );
  }
}

class _TaskDetailsAppBar extends StatelessWidget {
  final TaskModel task;
  const _TaskDetailsAppBar({required this.task});

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(lang.deleteDialog_task_title),
        content: Text(lang.deleteDialog_task_content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(lang.general_cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(lang.general_delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;
    final goal = task.goal;
    final headerColor = goal?.color ?? Theme.of(context).colorScheme.primary;

    return SliverAppBar(
      expandedHeight: 150.0,
      pinned: true,
      stretch: true,
      backgroundColor: headerColor,
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'edit') {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) => TaskEntrySheet(
                  initialTask: task,
                  onSubmit: (updatedTask) {
                    context
                        .read<TaskBloc>()
                        .add(TaskUpdatedEvent(newTask: updatedTask));
                  },
                ),
              );
            } else if (value == 'delete') {
              final bool? shouldDelete =
                  await _showDeleteConfirmationDialog(context);

              if (shouldDelete == true && context.mounted) {
                Navigator.of(context).pop();
                context.read<TaskBloc>().add(TaskDeletedEvent(task: task));
              }
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'edit',
              child: ListTile(
                leading: Icon(Icons.edit_outlined),
                title: Text(lang.general_edit),
              ),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text(lang.general_delete),
              ),
            ),
          ],
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 16),
        title: Text(
          task.title,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              shadows: [Shadow(blurRadius: 2, color: Colors.black38)]),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [headerColor.withOpacityDouble(0.6), headerColor],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
            ),
            /* if (goal?.icon != null) */
            Positioned(
              right:
                  Directionality.of(context) == TextDirection.RTL ? null : -30,
              left:
                  Directionality.of(context) == TextDirection.RTL ? -30 : null,
              bottom: -30,
              child: Icon(
                /* goal!.icon */ Icons.fitness_center_rounded,
                size: 180,
                color: Colors.white.withOpacityDouble(0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsPanel extends StatelessWidget {
  final TaskModel task;
  const _DetailsPanel({required this.task});

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withOpacityDouble(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          if (task.goal != null)
            _DetailRow(
              icon: Icons.flag_outlined,
              title: lang.taskDetailsPage_goal_label,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ActionChip(
                  avatar: Icon(
                      /* task.goal!.icon */ Icons.fitness_center_rounded,
                      size: 18,
                      color: task.goal!.color),
                  label: Text(task.goal!.name),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => GoalDetailsPage(goalId: task.goal!.id!),
                    ));
                  },
                ),
              ),
            ),
          if (task.dueDate != null)
            _DetailRow(
              icon: Icons.calendar_today_outlined,
              title: lang.taskDetailsPage_date_label,
              child: Text(
                AppDateFormatter.of(context).formatFullDate(task.dueDate!),
              ),
            ),
          if (task.priority != null)
            _DetailRow(
                icon: Icons.priority_high_rounded,
                title: lang.taskDetailsPage_priority_label,
                child:
                    Text(lang.taskDetailsPage_priorityLevel(task.priority!))),
          if (task.tags.isNotEmpty)
            _DetailRow(
                icon: Icons.tag,
                title: lang.general_tags,
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: task.tags
                      .map((tag) => Chip(label: Text(tag.name)))
                      .toList(),
                )),
          if (task.description?.isNotEmpty ?? false)
            _DetailRow(
                icon: Icons.notes_outlined,
                title: lang.general_description,
                child: Text(task.description!, softWrap: true)),
        ]
            .map((e) =>
                Padding(padding: const EdgeInsets.only(bottom: 16.0), child: e))
            .toList(),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _DetailRow(
      {required this.icon, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            size: 20,
            color:
                Theme.of(context).colorScheme.onSurface.withOpacityDouble(0.6)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 4),
              child,
            ],
          ),
        ),
      ],
    );
  }
}

class _MarkAsCompleteButton extends StatelessWidget {
  final TaskModel task;
  const _MarkAsCompleteButton({required this.task});

  @override
  Widget build(BuildContext context) {
    final Lang lang = Lang.of(context)!;
    bool isCompleted = task.isCompleted;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        icon:
            Icon(isCompleted ? Icons.check_circle : Icons.check_circle_outline),
        label: Text(isCompleted
            ? lang.taskDetailsPage_button_completed(
                AppDateFormatter.of(context).formatShortDate(task.doneDate!),
              )
            : lang.taskDetailsPage_button_unCompleted),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isCompleted
              ? Colors.green.withOpacityDouble(0.2)
              : Theme.of(context).colorScheme.primary,
          foregroundColor: isCompleted
              ? Colors.green.shade800
              : Theme.of(context).colorScheme.onPrimary,
        ),
        onPressed: isCompleted
            ? null
            : () {
                final updatedTask = task.copyWith(doneDate: DateTime.now());
                context
                    .read<TaskBloc>()
                    .add(TaskUpdatedEvent(newTask: updatedTask));
              },
      ),
    );
  }
}

class _SubtaskListSliver extends StatelessWidget {
  final List<TaskModel> subtasks;
  const _SubtaskListSliver({required this.subtasks});

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    if (subtasks.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverMainAxisGroup(slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
          child: Text(lang.taskDetailsPage_checklist_title(subtasks.length),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final subtask = subtasks[index];
            return CheckboxListTile(
              value: subtask.isCompleted,
              title: Text(subtask.title,
                  style: TextStyle(
                      decoration: subtask.isCompleted
                          ? TextDecoration.lineThrough
                          : null)),
              onChanged: (isCompleted) {
                final updatedTask = subtask.copyWith(
                  doneDate: isCompleted == true
                      ? DateTime.now()
                      : null, /* clearDoneDate: isCompleted != true */
                );
                context
                    .read<TaskBloc>()
                    .add(TaskUpdatedEvent(newTask: updatedTask));
              },
            );
          },
          childCount: subtasks.length,
        ),
      ),
    ]);
  }
}
