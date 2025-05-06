import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/locale/app_localization.dart';

import 'package:planza/core/widgets/buttons/circle_back_button.dart';
import 'package:planza/core/widgets/scrollables/scrollable_column.dart';

import '../../../../core/data/bloc/task_bloc/task_bloc.dart';
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
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TasksLoadedState) {
              return ScrollableColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: AppBar(
                      leading: CircleBackButton(),
                      title: Text(
                        goal.name,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                      task: task..goal = goal,
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
