import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';

extension GoalListExtention on List<GoalModel> {
  List<GoalModel> filterOnDate(DateTime date) {
    return where(
      (goal) => goal.deadline == null ? false : goal.deadline!.sameDay(date),
    ).toList();
  }

  List<GoalModel> get hasIncompleteTask => where(
        (goal) => goal.tasks
            .where(
              (task) => !task.isCompleted,
            )
            .isNotEmpty,
      ).toList();
}
