import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'package:planza/core/data/models/task_model.dart';
import 'package:planza/core/data/bloc/task_bloc/task_bloc.dart';

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
  final double _snapInitial = 0.25;
  final double _snapMiddle = 0.5;
  final double _snapFull = 0.85;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late List<TaskModel> _selectedDayTasks;
  late Map<DateTime, List<TaskModel>> _tasksByDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _groupTasksByDay();
    _selectedDayTasks = _getTasksForDay(_selectedDay!);
  }

  @override
  void didUpdateWidget(covariant CalendarTaskView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tasks != oldWidget.tasks) {
      _groupTasksByDay();
      if (_selectedDay != null) {
        setState(() {
          _selectedDayTasks = _getTasksForDay(_selectedDay!);
        });
      }
    }
  }

  void _groupTasksByDay() {
    _tasksByDay = {};
    for (final task in widget.tasks) {
      if (task.dueDate != null) {
        final day = DateTime.utc(
            task.dueDate!.year, task.dueDate!.month, task.dueDate!.day);
        _tasksByDay.putIfAbsent(day, () => []).add(task);
      }
    }
  }

  List<TaskModel> _getTasksForDay(DateTime day) {
    return _tasksByDay[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  void _onScrollEnd() {
    final currentSize = _sheetController.size;
    double closestSnap = _snapInitial;

    final distToInitial = (currentSize - _snapInitial).abs();
    final distToMiddle = (currentSize - _snapMiddle).abs();
    final distToFull = (currentSize - _snapFull).abs();

    if (distToMiddle < distToInitial && distToMiddle < distToFull) {
      closestSnap = _snapMiddle;
    } else if (distToFull < distToInitial) {
      closestSnap = _snapFull;
    }

    _sheetController.animateTo(
      closestSnap,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildTableCalendar(context),
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification) {
              _onScrollEnd();
            }
            return false;
          },
          child: _buildDraggableTaskSheet(),
        ),
      ],
    );
  }

  Widget _buildTableCalendar(BuildContext context) {
    final theme = Theme.of(context);
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          _selectedDayTasks = _getTasksForDay(selectedDay);
        });
        Future.delayed(Duration.zero, () {
          if (_sheetController.isAttached) {
            if (_selectedDayTasks.isNotEmpty) {
              _sheetController.animateTo(_snapMiddle,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut);
            } else {
              _sheetController.animateTo(_snapInitial,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut);
            }
          }
        });
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle:
            theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        formatButtonVisible: false,
        leftChevronIcon:
            Icon(Icons.chevron_left, color: theme.colorScheme.primary),
        rightChevronIcon:
            Icon(Icons.chevron_right, color: theme.colorScheme.primary),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(
            color: theme.colorScheme.onSurface.withOpacityDouble(0.6)),
        weekendStyle:
            TextStyle(color: theme.colorScheme.primary.withOpacityDouble(0.8)),
      ),
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
      ),
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, day, focusedDay) {
          final tasks = _getTasksForDay(day);
          final colors = tasks
              .map((t) => t.goal?.color)
              .whereType<Color>()
              .toSet()
              .toList();

          final List<Color> gradientColors;
          if (colors.isEmpty) {
            gradientColors = [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacityDouble(0.6)
            ];
          } else if (colors.length == 1) {
            gradientColors = [colors[0], colors[0].withOpacityDouble(0.6)];
          } else {
            gradientColors = colors;
          }

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${day.day}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
        todayBuilder: (context, day, focusedDay) {
          return Center(
            child: Text(
              '${day.day}',
              style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          );
        },
        defaultBuilder: (context, day, focusedDay) {
          final tasks = _getTasksForDay(day);
          if (tasks.isNotEmpty) {
            final colors = tasks
                .map((t) => t.goal?.color)
                .whereType<Color>()
                .toSet()
                .toList();

            if (colors.isNotEmpty) {
              final List<Color> gradientColors;
              if (colors.length > 1) {
                gradientColors = [
                  colors[0].withOpacityDouble(0.3),
                  colors[1].withOpacityDouble(0.3)
                ];
              } else {
                gradientColors = [
                  colors[0].withOpacityDouble(0.3),
                  colors[0].withOpacityDouble(0.15)
                ];
              }
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(child: Text('${day.day}')),
              );
            }
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDraggableTaskSheet() {
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: _snapInitial,
      minChildSize: _snapInitial,
      maxChildSize: _snapFull,
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
                        if (_selectedDay != null)
                          Text(
                            "Tasks for ${DateFormat.MMMMd().format(_selectedDay!)}",
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        IconButton(
                          icon: const Icon(Icons.add_circle),
                          color: theme.colorScheme.primary,
                          tooltip: "Add Task for this day",
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              /* backgroundColor: Colors.transparent, */
                              builder: (ctx) => TaskEntrySheet(
                                initialTask:
                                    TaskModel(title: '', dueDate: _selectedDay),
                                onSubmit: (newTask) {
                                  context
                                      .read<TaskBloc>()
                                      .add(TaskAddedEvent(newTask: newTask));
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _selectedDayTasks.isEmpty
                        ? const Center(child: Text("No tasks scheduled."))
                        : ListView.builder(
                            controller: scrollController,
                            padding: const EdgeInsets.only(top: 8, bottom: 80),
                            itemCount: _selectedDayTasks.length,
                            itemBuilder: (context, index) {
                              return GlassyTaskCard(
                                  task: _selectedDayTasks[index]);
                            },
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
