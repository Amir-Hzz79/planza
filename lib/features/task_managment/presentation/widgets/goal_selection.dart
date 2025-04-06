import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/locale/app_localization.dart';

import '../../../home/bloc/goal_bloc.dart';
import '../../../home/bloc/goal_state.dart';

class GoalSelection extends StatefulWidget {
  const GoalSelection({super.key, required this.onChanged, this.validator});

  final void Function(GoalModel? selectedGoal) onChanged;
  final String? Function(GoalModel?)? validator;

  @override
  State<GoalSelection> createState() => _GoalSelectionState();
}

class _GoalSelectionState extends State<GoalSelection> {
  GoalModel? selectedGoal;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(builder: (context, state) {
      if (state is GoalLoadedState) {
        return SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField(
            hint: Text(
              AppLocalizations.of(context).translate('goal'),
            ),
            value: selectedGoal,
            items: List.generate(
              state.goals.length,
              (index) => DropdownMenuItem(
                value: state.goals[index],
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 80,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CircleAvatar(
                          backgroundColor: state.goals[index].color,
                          radius: 10,
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Text(
                          state.goals[index].name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: state.goals[index] == selectedGoal
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      ),
                    ],

                    /*   selected: state.goals[index] == selectedGoal,
                    leading: ,
                    title: , */
                  ),
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedGoal = value;
                widget.onChanged.call(selectedGoal);
              });
            },
            validator: widget.validator,
          ),
        );
      } else if (state is GoalErrorState) {
        return Text('Error: ${state.message}');
      } else {
        return Container(
          width: double.infinity,
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
