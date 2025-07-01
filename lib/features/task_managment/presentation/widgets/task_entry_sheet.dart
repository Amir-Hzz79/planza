import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/data/models/tag_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../core/data/bloc/goal_bloc/goal_bloc.dart';
import '../../../../core/data/bloc/tag_bloc/tag_bloc.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../../core/utils/adaptive_date_picker.dart';
import '../../../../core/utils/app_date_formatter.dart';
import 'goal_selection_sheet.dart';
import 'priority_selection_sheet.dart';
import 'tag_selection_sheet.dart';

class TaskEntrySheet extends StatefulWidget {
  final Function(TaskModel task) onSubmit;
  final TaskModel? initialTask;

  const TaskEntrySheet({
    super.key,
    required this.onSubmit,
    this.initialTask,
  });

  @override
  State<TaskEntrySheet> createState() => _TaskEntrySheetState();
}

class _TaskEntrySheetState extends State<TaskEntrySheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  late bool _isEditing;
  bool _isFormValid = false;
  bool _showDescriptionField = false;

  GoalModel? _selectedGoal;
  DateTime? _selectedDate;
  List<TagModel> _selectedTags = [];
  int? _selectedPriority;

  @override
  void initState() {
    super.initState();

    _isEditing = widget.initialTask?.id != null;

    if (widget.initialTask != null) {
      final task = widget.initialTask!;
      _titleController.text = task.title;
      _descriptionController.text = task.description ?? '';
      _selectedGoal = task.goal;
      _selectedDate = task.dueDate;
      _selectedTags = List.from(task.tags);
      _selectedPriority = task.priority;

      if (task.description?.isNotEmpty ?? false) {
        _showDescriptionField = true;
      }
    }

    _updateFormValidity();
    _titleController.addListener(_updateFormValidity);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateFormValidity() {
    if (mounted) {
      setState(() {
        _isFormValid = _titleController.text.isNotEmpty;
      });
    }
  }

  void _pickGoal() async {
    final goalsState = context.read<GoalBloc>().state;
    final allGoals =
        goalsState is GoalsLoadedState ? goalsState.goals : <GoalModel>[];

    final selected = await showModalBottomSheet<GoalModel>(
      context: context,
      builder: (ctx) =>
          GoalSelectionSheet(allGoals: allGoals, initialGoal: _selectedGoal),
    );

    if (selected is GoalModel) {
      setState(() => _selectedGoal = selected);
    } else if (selected == null) {
      setState(() => _selectedGoal = null);
    }
  }

  void _pickTags() async {
    final tagsState = context.read<TagBloc>().state;
    final allTags =
        tagsState is TagsLoadedState ? tagsState.tags : <TagModel>[];

    final selected = await showModalBottomSheet<List<TagModel>>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) =>
          TagSelectionSheet(allTags: allTags, initialTags: _selectedTags),
    );
    if (selected != null) {
      setState(() => _selectedTags = selected);
    }
  }

  void _pickPriority() async {
    final selected = await showModalBottomSheet<int?>(
      context: context,
      builder: (ctx) =>
          PrioritySelectionSheet(initialPriority: _selectedPriority),
    );
    if (selected != null) {
      setState(() => _selectedPriority = selected == -1 ? null : selected);
    }
  }

  void _pickDate() async {
    final pickedDate = await showAdaptiveDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _saveTask(BuildContext context) {
    Lang lang = Lang.of(context)!;

    if (!_isFormValid) return;

    final finalTask = TaskModel(
      id: widget.initialTask?.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.isNotEmpty
          ? _descriptionController.text.trim()
          : null,
      goal: _selectedGoal,
      dueDate: _selectedDate,
      tags: _selectedTags,
      priority: _selectedPriority,
      doneDate: widget.initialTask?.doneDate,
    );

    widget.onSubmit(finalTask);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isEditing
            ? lang.addTaskSheet_edit_successMessage
            : lang.addTaskSheet_add_successMessage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    final theme = Theme.of(context);
    String priorityText = lang.general_priority;
    if (_selectedPriority != null) priorityText = _selectedPriority.toString();

    return Padding(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Text(
            _isEditing
                ? lang.addTaskSheet_title_edit
                : lang.addTaskSheet_title_add,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8), */
          TextField(
            controller: _titleController,
            autofocus: true,
            style: theme.textTheme.titleLarge,
            decoration: InputDecoration(
                hintText: lang.addTaskSheet_hint, border: InputBorder.none),
            onSubmitted: (_) => _saveTask(context),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: _showDescriptionField
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: lang.addTaskSheet_description_hint,
                        border: InputBorder.none,
                        filled: true,
                        fillColor:
                            theme.colorScheme.onSurface.withOpacityDouble(0.05),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _ActionChip(
                  label: _selectedGoal?.name ?? lang.addTaskSheet_chip_noGoal,
                  icon: Icons.flag_outlined,
                  isSelected: _selectedGoal != null,
                  onTap: _pickGoal,
                ),
                const SizedBox(width: 8),
                _ActionChip(
                  label: _selectedDate != null
                      ? AppDateFormatter.of(context)
                          .formatShortDate(_selectedDate!)
                      : lang.addTaskSheet_chip_dueDate,
                  icon: Icons.calendar_today_outlined,
                  isSelected: _selectedDate != null,
                  onTap: _pickDate,
                ),
                const SizedBox(width: 8),
                _ActionChip(
                  label: lang.general_description,
                  icon: Icons.notes_outlined,
                  isSelected: _showDescriptionField,
                  onTap: () => setState(
                      () => _showDescriptionField = !_showDescriptionField),
                ),
                const SizedBox(width: 8),
                _ActionChip(
                    label: _selectedTags.isEmpty
                        ? lang.general_tags
                        : lang.addTaskSheet_chip_tagCount(_selectedTags.length),
                    icon: Icons.tag,
                    isSelected: _selectedTags.isNotEmpty,
                    onTap: _pickTags),
                const SizedBox(width: 8),
                _ActionChip(
                  label: priorityText,
                  icon: Icons.priority_high_rounded,
                  isSelected: _selectedPriority != null,
                  onTap: _pickPriority,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _isFormValid ? () => _saveTask(context) : null,
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              child: Text(
                _isEditing
                    ? lang.addTaskSheet_button_edit
                    : lang.addTaskSheet_button_add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ActionChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.primary;
    final defaultColor = theme.colorScheme.onSurface.withOpacityDouble(0.7);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? selectedColor
                : theme.colorScheme.outline.withOpacityDouble(0.5),
          ),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 16, color: isSelected ? selectedColor : defaultColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected ? selectedColor : defaultColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
