import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

import '../../data/models/task_model.dart';

extension TaskListExtention on List<TaskModel> {
  List<TaskModel> filterOnDate(DateTime date) {
    return where(
      (task) => task.dueDate == null ? false : task.dueDate!.sameDay(date),
    ).toList();
  }

  List<TaskModel> filterOnGoal(int? goalId) {
    if (goalId == null) {
      return this;
    }

    return where(
      (task) => task.goal == null ? false : task.goal!.id == goalId,
    ).toList();
  }

  List<TaskModel> get overdueTasks => where(
        (task) => task.dueDate?.isBeforeToday() ?? false,
      ).toList();

  List<TaskModel> get tasksDueToday => where(
        (task) => task.dueDate?.isToday() ?? false,
      ).toList();

  List<TaskModel> get upcomingTasks => where(
        (task) => task.dueDate?.isAfterToday() ?? false,
      ).toList();

  List<TaskModel> get completedTasks => where(
        (task) => task.isCompleted,
      ).toList();

  List<TaskModel> get incompleteTasks => where(
        (task) => !task.isCompleted,
      ).toList();

  List<TaskModel> recentTasks(Duration duration) => where(
        (task) {
          if (task.doneDate == null) {
            return false;
          }

          return task.doneDate!.isAfter(
                DateTime.now().subtract(duration),
              ) /* &&
              task.doneDate!.isBeforeToday() */;
        },
      ).toList();
}
