import 'package:flutter/material.dart';
import 'package:planza/core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import 'package:planza/core/data/models/goal_model.dart';

import '../../../../core/locale/app_localization.dart';
import '../../../../core/widgets/buttons/custom_icon_button.dart';

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
    return GoalBlocBuilder(
      onDataLoaded: (goals) {
        return CustomIconButton(
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
                        goals.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedGoal = goals[index];
                              widget.onChanged.call(goals[index]);
                            });

                            Navigator.pop(context);
                          },
                          child: ListTile(
                            selected: selectedGoal == goals[index],
                            leading: CircleAvatar(
                              radius: 10,
                              backgroundColor: goals[index].color,
                            ),
                            title: Text(goals[index].name),
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
          icon: widget.iconMode
              ? Icon(
                  Icons.golf_course_rounded,
                  color: selectedGoal?.color ?? Colors.grey,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
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
      },
    );
  }
}
