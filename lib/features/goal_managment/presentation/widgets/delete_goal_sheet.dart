import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../core/data/bloc/goal_bloc/goal_bloc.dart';
import '../../../../core/data/models/goal_model.dart';

enum _DeleteChoice { unassign, deleteAll }

class DeleteGoalSheet extends StatefulWidget {
  final GoalModel goal;
  final BuildContext parentContext; // To access the GoalBloc

  const DeleteGoalSheet({
    super.key,
    required this.goal,
    required this.parentContext,
  });

  @override
  State<DeleteGoalSheet> createState() => _DeleteGoalSheetState();
}

class _DeleteGoalSheetState extends State<DeleteGoalSheet> {
  // Default to the safer choice
  _DeleteChoice? _choice;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completedTasks = widget.goal.tasks.where((t) => t.isCompleted).length;
    final incompleteTasks = widget.goal.tasks.length - completedTasks;

    return Padding(
      // Padding handles the notch and keyboard overlap
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle for the sheet
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withOpacityDouble(0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title and informational text
          Text("Delete '${widget.goal.name}'?",
              style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            "This goal contains ${widget.goal.tasks.length} tasks ($completedTasks completed, $incompleteTasks incomplete). This action cannot be undone.",
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          Text("Please choose how to handle these tasks:",
              style: theme.textTheme.titleMedium),
          const SizedBox(height: 16),

          // --- The new List-based choices ---
          ListTile(
            title: const Text("Unassign tasks and delete goal"),
            subtitle: const Text("The tasks will be kept without a goal."),
            leading: const Icon(Icons.inbox_outlined),
            selected: _choice == _DeleteChoice.unassign,
            selectedTileColor:
                theme.colorScheme.primaryContainer.withOpacityDouble(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onTap: () => setState(() => _choice = _DeleteChoice.unassign),
          ),
          const SizedBox(height: 8),
          ListTile(
            title: const Text("Delete goal AND all of its tasks"),
            subtitle: Text(
                "All ${widget.goal.tasks.length} tasks will be permanently deleted."),
            leading: Icon(Icons.delete_forever_outlined,
                color: theme.colorScheme.error),
            selected: _choice == _DeleteChoice.deleteAll,
            selectedTileColor:
                theme.colorScheme.errorContainer.withOpacityDouble(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            onTap: () => setState(() => _choice = _DeleteChoice.deleteAll),
          ),
          const SizedBox(height: 24),

          // --- Action Buttons ---
          Row(
            children: [
              Expanded(
                child: TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                  onPressed: _choice == null
                      ? null
                      : () {
                          if (_choice == _DeleteChoice.deleteAll) {
                            widget.parentContext.read<GoalBloc>().add(
                                GoalAndItsTasksDeletedEvent(goal: widget.goal));
                          } else {
                            widget.parentContext
                                .read<GoalBloc>()
                                .add(GoalDeletedEvent(goal: widget.goal));
                          }
                          Navigator.of(context).pop(); // Close bottom sheet
                          Navigator.of(context)
                              .pop(); // Go back from details page
                        },
                  child: const Text("Confirm Delete"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
