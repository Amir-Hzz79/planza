import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../../core/utils/app_date_formatter.dart';
import '../../../../core/widgets/calendar/adaptive_calendar.dart';
import 'task_entry_sheet.dart';
import 'glassy_task_tile.dart';

class CalendarTaskView extends StatefulWidget {
  final List<TaskModel> tasks;
  const CalendarTaskView({super.key, required this.tasks});

  @override
  State<CalendarTaskView> createState() => _CalendarTaskViewState();
}

class _CalendarTaskViewState extends State<CalendarTaskView> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  final double _snapInitial = 0.15;
  final double _snapMiddle = 0.45;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  Map<DateTime, List<TaskModel>> _tasksByDay = {};
  List<TaskModel> _selectedDayTasks = [];

  @override
  void initState() {
    super.initState();
    _groupTasksByDay();
    _selectedDayTasks = _getTasksForDay(_selectedDay);
  }

  @override
  void didUpdateWidget(covariant CalendarTaskView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tasks != oldWidget.tasks) {
      _groupTasksByDay();
      setState(() {
        _selectedDayTasks = _getTasksForDay(_selectedDay);
      });
    }
  }

  void _groupTasksByDay() {
    _tasksByDay = {};
    for (final task in widget.tasks) {
      if (task.dueDate != null) {
        final dayKey = DateTime.utc(
            task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
        _tasksByDay.putIfAbsent(dayKey, () => []).add(task);
      }
    }
  }

  List<TaskModel> _getTasksForDay(DateTime day) {
    return _tasksByDay[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  void _onDaySelected(DateTime selectedDay) {
    if (!mounted) return;
    setState(() {
      _selectedDay = selectedDay;
      _selectedDayTasks = _getTasksForDay(selectedDay);
    });

    Future.delayed(Duration.zero, () {
      if (_sheetController.isAttached) {
        final targetSnap =
            _selectedDayTasks.isNotEmpty ? _snapMiddle : _snapInitial;
        _sheetController.animateTo(
          targetSnap,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The Adaptive Calendar
        Column(
          children: [
            AdaptiveCalendar(
              focusedMonth: _focusedDay,
              selectedDate: _selectedDay,
              onDaySelected: _onDaySelected,
              onMonthChanged: (day) => setState(() => _focusedDay = day),
              dayBuilder: (context, day, dayNumber) {
                return _CustomDayCell(
                  dayNumber: dayNumber,
                  tasks: _getTasksForDay(day),
                  isSelected: isSameDay(_selectedDay, day),
                  isToday: isSameDay(DateTime.now(), day),
                  onTap: () => _onDaySelected(day),
                );
              },
            ),
          ],
        ),

        // The Draggable Task Panel
        _DraggableTaskSheet(
          controller: _sheetController,
          selectedDay: _selectedDay,
          tasks: _selectedDayTasks,
        ),
      ],
    );
  }
}

class _DraggableTaskSheet extends StatelessWidget {
  final DraggableScrollableController controller;
  final DateTime selectedDay;
  final List<TaskModel> tasks;

  const _DraggableTaskSheet({
    required this.controller,
    required this.selectedDay,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return DraggableScrollableSheet(
      controller: controller,
      initialChildSize: 0.25,
      minChildSize: 0.25,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        final theme = Theme.of(context);
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withOpacityDouble(0.2),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(
                    top: BorderSide(
                        color: theme.colorScheme.onSurface
                            .withOpacityDouble(0.2))),
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withOpacityDouble(0.4),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            AppDateFormatter.of(context)
                                .formatShortDate(selectedDay),
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          color: theme.colorScheme.primary,
                          tooltip: lang.tasksPage_calendar_addTask_toolTip,
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (ctx) => TaskEntrySheet(
                                initialTask:
                                    TaskModel(title: '', dueDate: selectedDay),
                                onSubmit: (newTask) {
                                  context
                                      .read<TaskBloc>()
                                      .add(TaskAddedEvent(newTask: newTask));
                                  /* showAppSnackBar(context,
                                      message:
                                          "Task '${newTask.title}' added!"); */
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: tasks.isEmpty
                        ? Center(child: Text(lang.tasksPage_calendar_noTasks))
                        : ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.only(top: 8, bottom: 80),
                            itemCount: tasks.length,
                            itemBuilder: (context, index) =>
                                GlassyTaskCard(task: tasks[index]),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CustomDayCell extends StatelessWidget {
  final int dayNumber;
  final List<TaskModel> tasks;
  final bool isSelected;
  final bool isToday;
  final VoidCallback onTap;

  const _CustomDayCell({
    required this.dayNumber,
    required this.tasks,
    required this.isSelected,
    required this.isToday,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final colors =
        tasks.map((t) => t.goal?.color).whereType<Color>().toSet().toList();

    BoxDecoration? decoration;
    TextStyle textStyle = TextStyle(color: theme.colorScheme.onSurface);

    if (isSelected) {
      final gradientColors = colors.isNotEmpty
          ? (colors.length > 1
              ? colors
              : [colors[0], colors[0].withOpacityDouble(0.6)])
          : [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacityDouble(0.6)
            ];

      decoration = BoxDecoration(
          /* border: Border.all(color: theme.colorScheme.primary, width: 1), */
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withOpacityDouble(0.4),
              blurRadius: 8.0,
            )
          ]);
      textStyle =
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    } else if (tasks.isNotEmpty && colors.isNotEmpty) {
      final gradientColors = colors.length > 1
          ? [
              colors[0].withOpacityDouble(0.3),
              colors[1].withOpacityDouble(0.3),
            ]
          : [
              colors[0].withOpacityDouble(0.3),
              colors[0].withOpacityDouble(0.2)
            ];

      decoration = BoxDecoration(
        border: isToday
            ? Border.all(color: theme.colorScheme.primary, width: 1)
            : null,
        gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        shape: BoxShape.circle,
      );
    }

    return InkResponse(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.all(6.0),
        decoration: decoration,
        child: Center(
          child: Text(
            '$dayNumber',
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
