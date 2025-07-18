import 'package:planza/core/constants/sort_ordering.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';
import 'package:planza/core/utils/extention_methods/task_list_extention.dart';

extension GoalListExtention on List<GoalModel> {
  List<GoalModel> filterOnDate(DateTime date) {
    return where(
      (goal) => goal.deadline == null ? false : goal.deadline!.isSameDay(date),
    ).toList();
  }

  List<GoalModel> get incompleteTaskGoals => where(
        (goal) => goal.tasks
            .where(
              (task) => !task.isCompleted,
            )
            .isNotEmpty,
      ).toList();

  List<GoalModel> recentCompletedTaskGoals(Duration duration) {
    return where(
      (goal) => goal.tasks.recentTasks(duration).completedTasks.isNotEmpty,
    ).toList();
  }

  void sortByName(SortOrdering sortOrdering) {
    sort((a, b) => sortOrdering == SortOrdering.ascending
        ? a.name.compareTo(b.name)
        : b.name.compareTo(a.name));
  }
}
