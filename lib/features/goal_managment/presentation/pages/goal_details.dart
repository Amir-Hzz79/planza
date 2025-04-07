import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import 'package:planza/core/utils/extention_methods/date_time_extentions.dart';
import 'package:planza/core/widgets/buttons/circle_back_button.dart';
import 'package:planza/core/widgets/scrollables/scrollable_column.dart';

import '../../../task_managment/presentation/widgets/task_tile.dart';

class GoalDetails extends StatelessWidget {
  const GoalDetails({
    super.key,
    required this.goal,
  });

  final GoalModel goal;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ScrollableColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppBar(
                leading: CircleBackButton(),
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: goal.color,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    goal.name,
                    style: TextStyle(
                      color: goal.color.matchTextColor(),
                    ),
                  ),
                ),
                actions: [
                  if (goal.deadline != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onInverseSurface,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                goal.deadline!.formatShortDate(),
                                style: TextStyle(
                                  /* color: goal.color.matchTextColor(), */
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '${goal.deadline!.difference(DateTime.now()).inDays.toString()} Days Left',
                                style: TextStyle(
                                  /* color: goal.color.matchTextColor(), */
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.timelapse_rounded),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppLocalizations.of(context).translate('tasks'),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...goal.tasks.map(
              (task) => TaskTile(
                task: task,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
