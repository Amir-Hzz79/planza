import 'package:flutter/widgets.dart';

import '../data/models/goal_model.dart';
import '../data/models/task_model.dart';

final List<TaskModel> dummyTasks = [
  TaskModel(
    id: 1,
    title: 'Save 100\$',
    isCompleted: false,
  ),
  TaskModel(
    id: 2,
    title: 'Save 1000\$',
    isCompleted: false,
  ),
  TaskModel(
    id: 3,
    title: 'Save 200\$',
    isCompleted: false,
  ),
  TaskModel(
    id: 4,
    title: 'Save 2200\$',
    isCompleted: false,
  ),
  TaskModel(
    id: 5,
    title: 'Save 2200\$',
    isCompleted: false,
  ),
  TaskModel(
    id: 6,
    title: 'Save 2200\$',
    isCompleted: false,
  ),
  TaskModel(
    id: 7,
    title: 'Save 2200\$',
    isCompleted: false,
  ),
  TaskModel(
    id: 8,
    title: 'Save 2200\$',
    isCompleted: false,
  ),
];
final List<GoalModel> dummyGoals = [
  GoalModel(
    id: 1,
    name: 'Buy a car',
    completed: true,
    color: Color(0xffcdb4db),
    tasks: [
      dummyTasks[0],
      dummyTasks[1],
    ],
  ),
  GoalModel(
    id: 2,
    name: 'Buy a bycicle',
    completed: true,
    color: Color(0xffffc8dd),
    tasks: [
      dummyTasks[3],
      dummyTasks[4],
      dummyTasks[5],
    ],
  ),
  GoalModel(
    id: 3,
    name: 'Buy a house',
    completed: true,
    color: Color(0xffffafcc),
    tasks: [
      dummyTasks[6],
    ],
  ),
  GoalModel(
    id: 3,
    name: 'Learn Programming',
    completed: true,
    color: Color(0xffbde0fe),
    tasks: [
      dummyTasks[7],
    ],
  ),
  GoalModel(
    id: 3,
    name: 'Learn English',
    completed: true,
    color: Color(0xffa2d2ff),
    tasks: [
      dummyTasks[2],
    ],
  ),
];

int get totalTaskCount {
  int taskCount = 0;
  for (var element in dummyGoals) {
    taskCount += element.tasks.length;
  }

  return taskCount;
}
