import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// Import your models and any necessary BLoCs/widgets
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/data/models/tag_model.dart';

import '../../../../core/data/bloc/goal_bloc/goal_bloc.dart';
import '../../../../core/data/bloc/tag_bloc/tag_bloc.dart';

class AddTaskSheet extends StatefulWidget {
  final Function(TaskModel task) onSubmit;
  final GoalModel? initialGoal;
  final DateTime? initialDate;

  const AddTaskSheet({
    super.key,
    required this.onSubmit,
    this.initialGoal,
    this.initialDate,
  });

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  final _titleController = TextEditingController();
  bool _isFormValid = false;

  GoalModel? _selectedGoal;
  DateTime? _selectedDate;
  List<TagModel> _selectedTags = [];
  int? _selectedPriority;
  final _descriptionController = TextEditingController();
  bool _showDescriptionField = false;

  @override
  void initState() {
    super.initState();
    _selectedGoal = widget.initialGoal;
    _selectedDate = widget.initialDate;
    
    _titleController.addListener(() {
      if (mounted) {
        setState(() {
          _isFormValid = _titleController.text.isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // --- Picker Methods ---

  void _pickGoal() async {
    final selected = await showModalBottomSheet<GoalModel>(
      context: context,
      builder: (ctx) => _GoalSelectionSheet(
        allGoals: context.read<GoalBloc>().state is GoalsLoadedState
            ? (context.read<GoalBloc>().state as GoalsLoadedState).goals
            : [],
        initialGoal: _selectedGoal,
      ),
    );
    if (selected != null) {
      setState(() => _selectedGoal = selected);
    }
  }

  void _pickTags() async {
    final selected = await showModalBottomSheet<List<TagModel>>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      builder: (ctx) => _TagSelectionSheet(
        allTags: context.read<TagBloc>().state is TagsLoadedState
            ? (context.read<TagBloc>().state as TagsLoadedState).tags
            : [],
        initialTags: _selectedTags,
      ),
    );
    if (selected != null) {
      setState(() => _selectedTags = selected);
    }
  }

  void _pickPriority() async {
    final selected = await showModalBottomSheet<int?>(
      context: context,
      builder: (ctx) =>
          _PrioritySelectionSheet(initialPriority: _selectedPriority),
    );
    // showModalBottomSheet can return null if dismissed, so we check.
    if (selected != null) {
      // If the user selects "No Priority", the value will be -1
      setState(() => _selectedPriority = selected == -1 ? null : selected);
    }
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _saveTask() {
    if (!_isFormValid) return;
    final newTask = TaskModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.isNotEmpty
          ? _descriptionController.text.trim()
          : null,
      goal: _selectedGoal,
      dueDate: _selectedDate,
      tags: _selectedTags,
      priority: _selectedPriority,
    );
    widget.onSubmit(newTask);

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Task '${newTask.title}' added!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String priorityText = "Priority";
    if (_selectedPriority != null) {
      priorityText = "Priority $_selectedPriority";
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            autofocus: true,
            style: theme.textTheme.titleLarge,
            decoration: const InputDecoration(
              hintText: "e.g., Finish presentation by 5 PM",
              border: InputBorder.none,
            ),
            onSubmitted: (_) => _saveTask(),
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
                      style: theme.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: "Add more details...",
                        border: InputBorder.none,
                        filled: true,
                        fillColor:
                            theme.colorScheme.onSurface.withOpacity(0.05),
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
                  label: _selectedGoal?.name ?? "Add Goal",
                  icon: Icons.flag_outlined,
                  isSelected: _selectedGoal != null,
                  onTap: _pickGoal,
                ),
                const SizedBox(width: 8),
                _ActionChip(
                  label: _selectedDate != null
                      ? DateFormat.MMMd().format(_selectedDate!)
                      : "Due Date",
                  icon: Icons.calendar_today_outlined,
                  isSelected: _selectedDate != null,
                  onTap: _pickDate,
                ),
                const SizedBox(width: 8),
                _ActionChip(
                  label: "Description",
                  icon: Icons.notes_outlined,
                  isSelected: _showDescriptionField,
                  onTap: () {
                    setState(() {
                      _showDescriptionField = !_showDescriptionField;
                    });
                  },
                ),
                const SizedBox(width: 8),
                _ActionChip(
                  label: _selectedTags.isEmpty
                      ? "Tags"
                      : "${_selectedTags.length} Tags",
                  icon: Icons.tag,
                  isSelected: _selectedTags.isNotEmpty,
                  onTap: _pickTags,
                ),
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
              onPressed: _isFormValid ? _saveTask : null,
              style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text("Add Task"),
            ),
          ),
        ],
      ),
    );
  }
}

// A private helper widget for the chips in the Smart Bar
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
    final defaultColor = theme.colorScheme.onSurface.withOpacity(0.7);

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
                : theme.colorScheme.outline.withOpacity(0.5),
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

class _GoalSelectionSheet extends StatelessWidget {
  final List<GoalModel> allGoals;
  final GoalModel? initialGoal;
  const _GoalSelectionSheet({required this.allGoals, this.initialGoal});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => ListView.builder(
        controller: scrollController,
        itemCount: allGoals.length,
        itemBuilder: (context, index) {
          final goal = allGoals[index];
          return ListTile(
            title: Text(goal.name),
            leading: Icon(Icons.fitness_center_rounded, color: goal.color),
            onTap: () => Navigator.of(context).pop(goal),
          );
        },
      ),
    );
  }
}

class _TagSelectionSheet extends StatefulWidget {
  final List<TagModel> allTags;
  final List<TagModel> initialTags;
  const _TagSelectionSheet({required this.allTags, required this.initialTags});

  @override
  State<_TagSelectionSheet> createState() => _TagSelectionSheetState();
}

class _TagSelectionSheetState extends State<_TagSelectionSheet> {
  late Set<TagModel> _selectedTags;

  @override
  void initState() {
    super.initState();
    _selectedTags = Set.from(widget.initialTags);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          ...List.generate(
            widget.allTags.length,
            (index) {
              final tag = widget.allTags[index];
              final isSelected = _selectedTags.contains(tag);
              return CheckboxListTile(
                title: Text(tag.name),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(
                    () {
                      if (value == true) {
                        _selectedTags.add(tag);
                      } else {
                        _selectedTags.remove(tag);
                      }
                    },
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FilledButton(
              style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              child: const Text("Done"),
              onPressed: () =>
                  Navigator.of(context).pop(_selectedTags.toList()),
            ),
          )
        ],
      ),
    );
  }
}

class _PrioritySelectionSheet extends StatelessWidget {
  final int? initialPriority;
  const _PrioritySelectionSheet({this.initialPriority});

  @override
  Widget build(BuildContext context) {
    // A map of priority levels to display
    final priorities = {
      1: "High",
      2: "Medium",
      3: "Low",
      -1: "No Priority", // Use -1 to represent null
    };
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: priorities.entries.map((entry) {
        return ListTile(
          title: Text(entry.value),
          onTap: () => Navigator.of(context).pop(entry.key),
        );
      }).toList(),
    );
  }
}
