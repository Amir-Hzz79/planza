import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/bloc/goal_bloc/goal_bloc.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../../core/utils/adaptive_date_picker.dart';
import '../../../../core/utils/app_date_formatter.dart';
import '../../../../core/widgets/color_picker/color_picker.dart';
import '../../../../core/widgets/icon_picker/icon_picker.dart';
import '../widgets/thematic_goal_card.dart';

import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/data/models/task_model.dart';

class GoalEntryPage extends StatefulWidget {
  final GoalModel? initialGoal;

  const GoalEntryPage({super.key, this.initialGoal});

  @override
  State<GoalEntryPage> createState() => _GoalEntryPageState();
}

class _GoalEntryPageState extends State<GoalEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<Color> _availableColors = [
    Colors.grey,
    const Color(0xFFffc8dd),
    const Color(0xFFbde0fe),
    const Color(0xFFa2d2ff),
    const Color(0xFFffafcc),
    const Color(0xFFcdb4db),
    const Color(0xFFb9fbc0),
    const Color(0xFFffd6a5),
    const Color(0xFFf4a261),
    const Color(0xFFe9c46a),
    Colors.cyan,
    Colors.orangeAccent,
    Colors.pinkAccent,
  ];

  final List<IconData> _availableIcons = [
    Icons.flag_outlined,
    Icons.fitness_center_outlined,
    Icons.school_outlined,
    Icons.work_outline,
    Icons.favorite_border,
    Icons.lightbulb_outline
  ];

  late final bool _isEditing;

  late Color _selectedColor;
  late IconData _selectedIcon;
  DateTime? _selectedDate;

  final List<TaskModel> _tasks = [];
  final Map<int, TextEditingController> _taskControllers = {};
  final Map<int, FocusNode> _taskFocusNodes = {};
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.initialGoal != null;

    if (_isEditing) {
      final goal = widget.initialGoal!;
      _nameController.text = goal.name;
      _descriptionController.text = goal.description ?? '';
      _selectedColor = goal.color;
      _selectedIcon = goal.icon;
      _selectedDate = goal.deadline;

      for (var task in goal.tasks) {
        _tasks.add(task.copyWith());
        _createControllerForTask(task, listen: false);
      }
    } else {
      _selectedColor = _availableColors.first;
      _selectedIcon = _availableIcons.first;
    }

    _updateFormValidity();
    _nameController.addListener(_updateFormValidity);
    _addTaskField(isInitial: true);
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateFormValidity);
    _nameController.dispose();
    _descriptionController.dispose();
    for (final controller in _taskControllers.values) {
      controller.dispose();
    }
    for (final focusNode in _taskFocusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _createControllerForTask(TaskModel task, {bool listen = true}) {
    final controller = TextEditingController(text: task.title);
    if (listen) {
      controller.addListener(() {
        task = task.copyWith(title: controller.text);

        if (task.id == _tasks.last.id && task.title.isNotEmpty) {
          _addTaskField();
        }
      });
    }
    final focusNode = FocusNode();
    final key = task.id ?? task.hashCode;
    _taskControllers[key] = controller;
    _taskFocusNodes[key] = focusNode;
  }

  void _updateFormValidity() {
    setState(() {
      _isFormValid = _nameController.text.isNotEmpty;
    });
  }

  void _addTaskField({bool isInitial = false}) {
    if (!isInitial /* && (_tasks.isEmpty || _tasks.last.title.isNotEmpty) */) {
      final newTask =
          TaskModel(id: DateTime.now().millisecondsSinceEpoch, title: '');
      setState(() {
        _tasks.add(newTask);
        _createControllerForTask(_tasks.last, listen: true);
      });
    } else if (isInitial && _tasks.isEmpty) {
      final newTask =
          TaskModel(id: DateTime.now().millisecondsSinceEpoch, title: '');
      setState(() {
        _tasks.add(newTask);
        _createControllerForTask(newTask, listen: true);
      });
    }
  }

  void _removeTaskField(TaskModel task) {
    setState(() {
      final key = task.id ?? task.hashCode;
      _taskControllers.remove(key)?.dispose();
      _taskFocusNodes.remove(key)?.dispose();
      _tasks.remove(task);

      if (_tasks.isEmpty) {
        _addTaskField(isInitial: true);
      }
    });
  }

  Future<void> _pickDate() async {
    final pickedDate = await showAdaptiveDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _saveGoal() {
    if (_formKey.currentState?.validate() ?? false) {
      _taskControllers.forEach((id, controller) {
        final taskIndex = _tasks.indexWhere((t) => (t.id ?? t.hashCode) == id);
        if (taskIndex != -1) {
          _tasks[taskIndex] =
              _tasks[taskIndex].copyWith(title: controller.text);
        }
      });

      final finalTasks = _tasks.where((t) => t.title.isNotEmpty).toList();

      final goalData = GoalModel(
        id: widget.initialGoal?.id,
        name: _nameController.text,
        description: _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : null,
        color: _selectedColor,
        icon: _selectedIcon,
        deadline: _selectedDate,
        tasks: finalTasks,
      );

      if (_isEditing) {
        context.read<GoalBloc>().add(GoalUpdatedEvent(updatedGoal: goalData));
      } else {
        context.read<GoalBloc>().add(GoalAddedEvent(newGoal: goalData));
      }
      if (mounted) Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    final previewGoal = GoalModel(
      name: _nameController.text.isEmpty
          ? (_isEditing
              ? lang.addGoalPage_title_edit
              : lang.addGoalPage_title_add)
          : _nameController.text,
      color: _selectedColor,
      icon: _selectedIcon,
      tasks: _tasks,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 207,
            pinned: true,
            title: Text(_isEditing
                ? lang.addGoalPage_title_edit
                : lang.addGoalPage_title_add),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: ThematicGoalCard(
                  goal: previewGoal,
                  previewMode: true,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      validator: (value) => (value?.isEmpty ?? true)
                          ? lang.addGoalPage_name_validator
                          : null,
                      decoration: InputDecoration(
                        label: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: lang.addGoalPage_name_label),
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                    color: Theme.of(context).colorScheme.error),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 2,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        label: Text(
                            '${lang.general_description} (${lang.general_optional})'),
                        hintText: lang.addGoalPage_description_hint,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(lang.addGoalPage_color_label,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    ColorPicker(
                      colors: _availableColors,
                      selectedColor: _selectedColor,
                      onColorSelected: (color) =>
                          setState(() => _selectedColor = color),
                    ),
                    const SizedBox(height: 24),
                    Text(lang.addGoalPage_icon_label,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    IconPicker(
                      icons: _availableIcons,
                      selectedIcon: _selectedIcon,
                      onIconSelected: (icon) =>
                          setState(() => _selectedIcon = icon),
                      selectedColor: _selectedColor,
                    ),
                    const SizedBox(height: 24),
                    ListTile(
                      onTap: _pickDate,
                      leading: const Icon(Icons.calendar_today_outlined),
                      title: Text(
                          "${lang.general_deadline} (${lang.general_optional})"),
                      subtitle: Text(
                        _selectedDate == null
                            ? lang.addGoalPage_noDate
                            : AppDateFormatter.of(context)
                                .formatFullDate(_selectedDate!),
                      ),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 24),
                    ExpansionTile(
                      title: Text(lang.general_tasks),
                      initiallyExpanded: true,
                      tilePadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) {
                            final task = _tasks[index];
                            final key = task.id ?? task.hashCode;
                            final controller = _taskControllers[key]!;
                            final focusNode = _taskFocusNodes[key]!;
                            bool isLast = task == _tasks.last;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      textInputAction: controller.text.isEmpty
                                          ? TextInputAction.done
                                          : TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        if (isLast) {
                                          focusNode.unfocus();
                                        } else {
                                          final nextTask = _tasks[index + 1];
                                          final nextFocusNode = _taskFocusNodes[
                                              nextTask.id ?? nextTask.hashCode];
                                          FocusScope.of(context)
                                              .requestFocus(nextFocusNode);
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: isLast
                                            ? lang.addGoalPage_tasks_hint
                                            : lang.addGoalPage_tasks_index(
                                                index + 1),
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .colorScheme
                                            .surfaceContainer,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (/* !isLast ||
                                      (_isEditing &&
                                          controller.text.isNotEmpty) */
                                      controller.text.isNotEmpty)
                                    IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () => _removeTaskField(task),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacityDouble(0.6),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.tonal(
                        onPressed: _isFormValid ? _saveGoal : null,
                        style: FilledButton.styleFrom(
                            backgroundColor: _selectedColor,
                            padding: const EdgeInsets.symmetric(vertical: 16)),
                        child: Text(
                          _isEditing
                              ? lang.addGoalPage_button_add
                              : lang.addGoalPage_button_edit,
                          style: TextStyle(
                            color: _selectedColor.matchTextColor(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
