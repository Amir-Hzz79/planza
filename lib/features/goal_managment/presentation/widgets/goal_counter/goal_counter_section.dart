import 'package:flutter/material.dart';
import 'package:planza/core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/widgets/scrollables/scrollable_row.dart';

import 'goal_counter_grid.dart';
import 'goal_counter_list.dart';
import 'goal_counter_list_item.dart';

class GoalCounterSection extends StatefulWidget {
  const GoalCounterSection({super.key});

  @override
  State<GoalCounterSection> createState() => _GoalCounterSectionState();
}

class _GoalCounterSectionState extends State<GoalCounterSection> {
  bool expandMode = false;

  @override
  Widget build(BuildContext context) {
    return GoalBlocBuilder(
      onDataLoaded: (goals) {
        final Size screenSize = MediaQuery.of(context).size;
        final double expandHeight = (goals.length / 2).ceil() * 70;
        final double height = 60;

        return Column(
          children: [
            Row(
              /* mainAxisAlignment: MainAxisAlignment.spaceBetween, */
              children: [
                const SizedBox(width: 15),
                Expanded(
                  flex: 8,
                  child: Text(
                    AppLocalizations.of(context).translate('goal_title'),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      setState(
                        () => expandMode = !expandMode,
                      );
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      /* width: 40,
                      height: 50, */
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onInverseSurface /*  Colors.grey[200] */,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        expandMode
                            ? Icons.more_horiz_rounded
                            : Icons.more_vert_rounded,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            IntrinsicHeight(
              child: AnimatedContainer(
                height: expandMode ? expandHeight : height,
                width: MediaQuery.of(context).size.width,
                duration: Duration(
                  milliseconds: 400,
                ),
                child: expandMode
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GoalCounterGrid(
                          items: List.generate(
                            goals.length,
                            (index) => GoalCounterItem(
                              goal: goals[index],
                              width: (screenSize.width - 40) / 2,
                            ),
                          ),
                        ),
                      )
                    : ScrollableRow(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          GoalCounterList(
                            spacing: 10,
                            items: List.generate(
                              goals.length,
                              (index) => GoalCounterItem(
                                goal: goals[index],
                                width: (screenSize.width - 40) / 2,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
