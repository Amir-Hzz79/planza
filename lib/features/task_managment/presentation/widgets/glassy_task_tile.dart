import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../core/data/bloc/task_bloc/task_bloc.dart';
import '../../../../core/locale/app_localizations.dart';
import '../pages/task_details_page.dart';

class GlassyTaskCard extends StatelessWidget {
  final TaskModel task;
  final ValueChanged<bool?>? onStatusChanged;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const GlassyTaskCard({
    super.key,
    required this.task,
    this.onStatusChanged,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    final bool isCompleted = task.isCompleted;

    return Dismissible(
      key: Key(task.id.toString()),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(lang.deleteDialog_task_title),
              content: Text(lang.deleteDialog_task_content),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(lang.general_cancel),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(lang.general_delete),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        context.read<TaskBloc>().add(TaskDeletedEvent(task: task));
      },
      background: _buildDismissibleBackground(context),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: isCompleted ? 0.65 : 1.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TaskDetailsPage(taskId: task.id!),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    Positioned.fill(child: _buildGradientBackground(context)),
                    /* if (task.goal?.icon != null) */ /* _buildBackgroundIcon(
                        context), */
                    _buildContent(context, isCompleted),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientBackground(BuildContext context) {
    final Color goalColor = task.goal?.color ?? Colors.grey;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            goalColor.withOpacityDouble(0.25),
            goalColor.withOpacityDouble(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  /* Widget _buildBackgroundIcon(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.RTL;
    return Positioned(
      left: isRtl ? -20 : null,
      right: isRtl ? null : -20,
      bottom: -20,
      child: Icon(
        Icons.fitness_center_rounded /* task.goal!.icon */,
        size: 110.0,
        color: Theme.of(context).colorScheme.onSurface.withOpacityDouble(0.05),
      ),
    );
  } */

  Widget _buildContent(BuildContext context, bool isCompleted) {
    final Color accentColor = task.goal?.color ?? Colors.blue;
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacityDouble(0.9)
        : Colors.black.withOpacityDouble(0.9);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: (value) {
              context.read<TaskBloc>().add(
                    TaskUpdatedEvent(
                      newTask: task.copyWith(
                        doneDate: value! ? DateTime.now() : null,
                      ),
                    ),
                  );
            },
            activeColor: accentColor,
            checkColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.black87
                : Colors.white,
            side: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withOpacityDouble(0.6),
                width: 2),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    decorationColor: textColor.withOpacityDouble(0.8),
                    decorationThickness: 2,
                  ),
                ),
                if (task.dueDate != null || task.tags.isNotEmpty)
                  const SizedBox(height: 8.0),
                _buildInfoPills(context, textColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPills(BuildContext context, Color textColor) {
    final deadlineInfo = _getDeadlineInfo(context, task.dueDate);
    final neutralPillColor =
        Theme.of(context).colorScheme.onSurface.withOpacityDouble(0.1);

    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: [
        if (task.dueDate != null)
          _InfoPill(
            icon: deadlineInfo.icon,
            text: deadlineInfo.text,
            backgroundColor: deadlineInfo.color,
            textColor: Colors.white,
          ),
        ...task.tags.map(
          (tag) => _InfoPill(
            text: tag.name,
            backgroundColor: neutralPillColor,
            textColor: textColor,
          ),
        ),
      ],
    );
  }

  ({String text, Color color, IconData icon}) _getDeadlineInfo(
      BuildContext context, DateTime? deadline) {
    final Lang lang = Lang.of(context)!;

    if (deadline == null) {
      return (text: '', color: Colors.transparent, icon: Icons.error);
    }

    final Color overdueColor = Theme.of(context).colorScheme.error;
    final Color dueSoonColor = Colors.orange.shade700;
    final Color completedColor = Colors.green.withOpacityDouble(0.8);
    final Color neutralColor =
        Theme.of(context).colorScheme.onSurface.withOpacityDouble(0.1);

    if (task.isCompleted) {
      return (
        text: lang.general_completed,
        color: completedColor,
        icon: Icons.check_circle_outline
      );
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final deadlineDate = DateTime(deadline.year, deadline.month, deadline.day);
    final difference = deadlineDate.difference(today).inDays;

    if (difference < 0) {
      return (
        text: lang.general_overdue,
        color: overdueColor,
        icon: Icons.error_outline
      );
    }
    if (difference == 0) {
      return (
        text: lang.general_dueToday,
        color: dueSoonColor,
        icon: Icons.warning_amber_rounded
      );
    }
    return (
      text: DateFormat.MMMd().format(deadline),
      color: neutralColor,
      icon: Icons.calendar_today_outlined
    );
  }

  Widget _buildDismissibleBackground(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error.withOpacityDouble(0.5),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.delete_outline, color: Colors.white),
          SizedBox(width: 8),
          Text(lang.general_delete,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;

  const _InfoPill({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              size: 12.0,
              color: textColor,
            ),
          if (icon != null) const SizedBox(width: 4.0),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 11.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
