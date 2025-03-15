import 'package:flutter/material.dart';
import 'package:planza/core/constants/dummy_data.dart';
import 'package:planza/core/widgets/scrollables/scrollable_row.dart';

import 'goal_counter_grid_item.dart';
import 'goal_counter_grid.dart';
import 'goal_counter_list.dart';
import 'goal_counter_list_item.dart';

class GoalSection extends StatefulWidget {
  const GoalSection({super.key});

  @override
  State<GoalSection> createState() => _GoalSectionState();
}

class _GoalSectionState extends State<GoalSection> {
  bool expandMode = false;

  @override
  Widget build(BuildContext context) {
    final double expandHeight = 185;
    final double height = 50;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /* const SizedBox(width: 15), */
            Text(
              'Manage Your Tasks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                setState(
                  () => expandMode = !expandMode,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                /* width: 40,
                height: 50, */
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.auto_awesome_mosaic_outlined,
                ),
              ),
            ),
            /* const SizedBox(width: 10), */
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        AnimatedContainer(
          height: expandMode ? expandHeight : height,
          width: MediaQuery.of(context).size.width,
          duration: Duration(
            milliseconds: 400,
          ),
          child: expandMode
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GoalCounterGrid(
                    taskCounters: List.generate(
                      dummyGoals.length,
                      (index) => GoalCounterGridItem(
                        goal: dummyGoals[index],
                        counter: index,
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
                      spacing: 5,
                      items: List.generate(
                        dummyGoals.length,
                        (index) => GoalCounterListItem(
                          goal: dummyGoals[index],
                          counter: index,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
