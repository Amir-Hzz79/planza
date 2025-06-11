import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc_builder.dart';

import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import 'package:planza/features/task_managment/presentation/pages/task_details.dart';

import '../../../../core/data/bloc/task_bloc/task_bloc.dart';

class DetailedTaskRow extends StatefulWidget {
  final TaskModel task;

  const DetailedTaskRow({
    super.key,
    required this.task,
  });

  @override
  State<DetailedTaskRow> createState() => _DetailedTaskRowState();
}

class _DetailedTaskRowState extends State<DetailedTaskRow> {
  @override
  Widget build(BuildContext context) {
    final bool isCompleted = widget.task.isCompleted;
    final Color textColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacityDouble(0.9)
        : Colors.black.withOpacityDouble(0.9);

    return TaskBlocBuilder(onDataLoaded: (tasks) {
      return AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: isCompleted ? 0.5 : 1.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TaskDetails(task: widget.task),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surface.withOpacityDouble(0.15),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- Checkbox ---
                      Checkbox(
                        value: isCompleted,
                        onChanged: (value) => context.read<TaskBloc>().add(
                              TaskUpdatedEvent(
                                newTask: widget.task.copyWith(
                                    doneDate: value! ? DateTime.now() : null),
                              ),
                            ),
                        activeColor: widget.task.goal?.color ??
                            Theme.of(context).colorScheme.primary,
                        side: BorderSide(
                            color: textColor.withOpacityDouble(0.7), width: 2),
                      ),
                      const SizedBox(width: 8),
                      // --- Main Info Column ---
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.task.title,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            if (widget.task.description?.isNotEmpty ?? false)
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  widget.task.description!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: textColor.withOpacityDouble(0.7),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            if (widget.task.tags.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: _buildTagsRow(textColor),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // --- Status Column ---
                      _buildStatusColumn(context, textColor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTagsRow(Color textColor) {
    return Wrap(
      spacing: 6.0,
      runSpacing: 6.0,
      children: widget.task.tags
          .map((tag) => Text(
                '#${tag.name}',
                style: TextStyle(
                  color: textColor.withOpacityDouble(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ))
          .toList(),
    );
  }

  Widget _buildStatusColumn(BuildContext context, Color textColor) {
    final deadlineInfo = _getDeadlineInfo(context, widget.task.dueDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(deadlineInfo.icon, size: 14, color: deadlineInfo.color),
            const SizedBox(width: 4),
            Text(
              deadlineInfo.text,
              style: TextStyle(
                  fontSize: 12,
                  color: deadlineInfo.color,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        if (widget.task.priority != null) const SizedBox(height: 8),
        if (widget.task.priority != null) _buildPriorityIndicator(textColor),
      ],
    );
  }

  Widget _buildPriorityIndicator(Color textColor) {
    return Row(
      children: List.generate(
        widget.task.priority ?? 0,
        (index) => Icon(Icons.local_fire_department,
            size: 14, color: textColor.withOpacityDouble(0.7)),
      ),
    );
  }

  ({String text, Color color, IconData icon}) _getDeadlineInfo(
      BuildContext context, DateTime? deadline) {
    if (deadline == null) {
      return (
        text: 'No date',
        color: Theme.of(context).colorScheme.onSurface.withOpacityDouble(0.5),
        icon: Icons.calendar_today_outlined
      );
    }
    if (widget.task.isCompleted) {
      return (
        text: "Completed",
        color: Colors.green,
        icon: Icons.check_circle_outline
      );
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final deadlineDate = DateTime(deadline.year, deadline.month, deadline.day);
    final difference = deadlineDate.difference(today).inDays;

    if (difference < 0) {
      return (
        text: "Overdue",
        color: Theme.of(context).colorScheme.error,
        icon: Icons.error_outline
      );
    }
    if (difference == 0) {
      return (
        text: "Due today",
        color: Colors.orange.shade700,
        icon: Icons.warning_amber_rounded
      );
    }
    return (
      text: DateFormat.MMMd().format(deadline),
      color: Theme.of(context).colorScheme.onSurface.withOpacityDouble(0.7),
      icon: Icons.calendar_today_outlined
    );
  }
}
