import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:planza/core/data/bloc/goal_bloc/goal_bloc.dart';
import 'package:planza/core/data/bloc/tag_bloc/tag_bloc.dart';
import '../../../../core/locale/app_localizations.dart';
import '../pages/multi_select_page.dart';

class FilterSheet extends StatefulWidget {
  final bool initialShowCompleted;
  final Set<int> initialGoalIds;
  final Set<int> initialTagIds;

  const FilterSheet({
    super.key,
    required this.initialShowCompleted,
    required this.initialGoalIds,
    required this.initialTagIds,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late bool _showCompleted;
  late Set<int> _selectedGoalIds;
  late Set<int> _selectedTagIds;

  @override
  void initState() {
    super.initState();
    _showCompleted = widget.initialShowCompleted;
    _selectedGoalIds = widget.initialGoalIds;
    _selectedTagIds = widget.initialTagIds;
  }

  void _onApply() {
    Navigator.of(context).pop({
      'showCompleted': _showCompleted,
      'goalIds': _selectedGoalIds,
      'tagIds': _selectedTagIds,
    });
  }

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header...
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lang.tasksPage_filter_title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(
                  onPressed: () => setState(() {
                        _showCompleted = false;
                        _selectedGoalIds.clear();
                        _selectedTagIds.clear();
                      }),
                  child: Text(lang.tasksPage_filter_reset)),
            ],
          ),
          const Divider(),

          // Main filter options
          SwitchListTile(
            title: Text(lang.tasksPage_filter_showCompleted),
            value: _showCompleted,
            onChanged: (value) => setState(() => _showCompleted = value),
          ),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: Text(lang.tasksPage_filter_goal_title),
            trailing: Text(
              lang.tasksPage_filter_goal_selected(_selectedGoalIds.length),
            ),
            onTap: () async {
              final allGoals =
                  (context.read<GoalBloc>().state as GoalsLoadedState).goals;
              final selected =
                  await Navigator.of(context).push<Set<int>>(MaterialPageRoute(
                      builder: (_) => MultiSelectPage<int>(
                            title: lang.tasksPage_filter_goalSelection_title,
                            initialSelectedValues: _selectedGoalIds,
                            items: allGoals
                                .map((g) => MultiSelectItem(
                                    value: g.id!,
                                    label: g.name,
                                    color: g.color))
                                .toList(),
                          )));
              if (selected != null) setState(() => _selectedGoalIds = selected);
            },
          ),
          ListTile(
            leading: const Icon(Icons.tag),
            title: Text(lang.tasksPage_filter_tag_title),
            trailing: Text(
                lang.tasksPage_filter_tag_selected(_selectedTagIds.length)),
            onTap: () async {
              final allTags =
                  (context.read<TagBloc>().state as TagsLoadedState).tags;
              final selected =
                  await Navigator.of(context).push<Set<int>>(MaterialPageRoute(
                      builder: (_) => MultiSelectPage<int>(
                            title: lang.tasksPage_filter_tagSelection_title,
                            initialSelectedValues: _selectedTagIds,
                            items: allTags
                                .map((t) =>
                                    MultiSelectItem(value: t.id, label: t.name))
                                .toList(),
                          )));
              if (selected != null) setState(() => _selectedTagIds = selected);
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _onApply,
              child: Text(lang.tasksPage_filter_apply),
            ),
          ),
        ],
      ),
    );
  }
}
