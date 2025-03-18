import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/widgets/scrollables/scrollable_row.dart';

import 'goal_counter_grid.dart';
import 'goal_counter_list.dart';
import 'goal_counter_list_item.dart';

class GoalCounterSection extends StatefulWidget {
  const GoalCounterSection({super.key, required this.goals});

  final List<GoalModel> goals;
  @override
  State<GoalCounterSection> createState() => _GoalCounterSectionState();
}

class _GoalCounterSectionState extends State<GoalCounterSection> {
  bool expandMode = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double expandHeight = (widget.goals.length / 2).ceil() * 70;
    final double height = 60;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /* const SizedBox(width: 15), */
            Text(
              'Manage Your Goals',
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
                  color: Theme.of(context)
                      .colorScheme
                      .onInverseSurface /*  Colors.grey[200] */,
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
                        widget.goals.length,
                        (index) => GoalCounterListItem(
                          goal: widget.goals[index],
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
                          widget.goals.length,
                          (index) => GoalCounterListItem(
                            goal: widget.goals[index],
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
  }
}
