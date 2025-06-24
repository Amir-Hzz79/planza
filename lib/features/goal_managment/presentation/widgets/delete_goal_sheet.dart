import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../core/data/bloc/goal_bloc/goal_bloc.dart';
import '../../../../core/data/models/goal_model.dart';
import '../../../../core/locale/app_localizations.dart';

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
  _DeleteChoice? _choice;

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;
    final theme = Theme.of(context);
    /* final completedTasks = widget.goal.tasks.where((t) => t.isCompleted).length; */
    /* final incompleteTasks = widget.goal.tasks.length - completedTasks; */

    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text(lang.deleteDialog_goal_title(widget.goal.name),
              style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            lang.deleteDialog_goal_content(widget.goal.tasks.length),
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Text(
            lang.deleteDialog_goal_options_title,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(lang.deleteDialog_goal_option_unassign_title),
            subtitle: Text(lang.deleteDialog_goal_option_unassign_subtitle),
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
            title: Text(lang.deleteDialog_goal_option_deleteAll_title),
            subtitle: Text(
              lang.deleteDialog_goal_option_deleteAll_subtitle(
                  widget.goal.tasks.length),
            ),
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
          Row(
            children: [
              Expanded(
                child: TextButton(
                  child: Text(lang.general_cancel),
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
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                  child: Text(lang.general_deleteConfirm),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
