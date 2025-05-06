import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';

import '../../../../core/locale/app_localization.dart';
import '../../../../core/data/bloc/goal_bloc/goal_bloc.dart';

class GoalSelection extends StatefulWidget {
  const GoalSelection({
    super.key,
    this.initialGoal,
    this.iconMode = false,
    required this.onChanged,
    this.validator,
  });

  final GoalModel? initialGoal;
  final bool iconMode;
  final void Function(GoalModel? selectedGoal) onChanged;
  final String? Function(GoalModel?)? validator;

  @override
  State<GoalSelection> createState() => _GoalSelectionState();
}

class _GoalSelectionState extends State<GoalSelection> {
  GoalModel? selectedGoal;

  @override
  void initState() {
    selectedGoal = widget.initialGoal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(builder: (context, state) {
      if (state is GoalsLoadedState) {
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              ModalBottomSheetRoute(
                enableDrag: true,
                showDragHandle: true,
                useSafeArea: true,
                isDismissible: true,
                builder: (context) => Material(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedGoal = null;
                            widget.onChanged.call(null);
                          });

                          Navigator.pop(context);
                        },
                        child: ListTile(
                          selected: selectedGoal == null,
                          leading: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.grey,
                          ),
                          title: Text(
                            'None',
                          ),
                        ),
                      ),
                      ...List.generate(
                        state.goals.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedGoal = state.goals[index];
                              widget.onChanged.call(state.goals[index]);
                            });

                            Navigator.pop(context);
                          },
                          child: ListTile(
                            selected: selectedGoal == state.goals[index],
                            leading: CircleAvatar(
                              radius: 10,
                              backgroundColor: state.goals[index].color,
                            ),
                            title: Text(state.goals[index].name),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                isScrollControlled: true,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: widget.iconMode
                ? Icon(
                    Icons.golf_course_rounded,
                    color: selectedGoal?.color ?? Colors.grey,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 5,
                    children: [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: selectedGoal == null
                            ? Colors.grey
                            : selectedGoal!.color,
                      ),
                      Text(
                        selectedGoal?.name ??
                            AppLocalizations.of(context).translate('goal'),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
          ),
        );
      } else if (state is GoalErrorState) {
        return Text('Error: ${state.message}');
      } else {
        return Container(
          width: 60,
          margin: EdgeInsets.symmetric(horizontal: 10),
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }
    });
  }
}
