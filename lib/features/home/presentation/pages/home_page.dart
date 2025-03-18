import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

import 'package:planza/features/home/presentation/widgets/appbart/home_page_app_bar.dart';
import 'package:planza/features/home/presentation/widgets/drawer/drawer_section.dart';
import 'package:planza/features/home/presentation/widgets/goal_counter/goal_counter_section.dart';

import '../../../../core/widgets/scrollables/scrollable_column.dart';
import '../../bloc/goal_bloc.dart';
import '../../bloc/goal_evet.dart';
import '../../bloc/goal_state.dart';
import '../widgets/task_chart/task_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /* late Future<List<GoalModel>> futureGoals; */

  @override
  void initState() {
    context.read<GoalBloc>().add(LoadGoalsEvent());
    super.initState();
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        /* toolbarHeight: kToolbarHeight + 50, */
        leading: ,
        actions: [
        ],
      ), */
      drawer: DrawerSection(),
      body: ScrollableColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          HomePageAppBar(),
          const SizedBox(
            height: 20,
          ),
          EasyDateTimeLinePicker(
            focusedDate: selectedDate,
            firstDate: DateTime(DateTime.now().year, 1, 1),
            lastDate: DateTime(DateTime.now().year, 12, 31),
            onDateChange: (date) {
              setState(
                () {
                  selectedDate = date;
                },
              );
            },
            selectionMode: SelectionMode.autoCenter(),
            ignoreUserInteractionOnAnimating: true,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<GoalBloc, GoalState>(
            builder: (context, state) {
              if (state is GoalLoadedState) {
                return GoalCounterSection(
                  goals: state.goals,
                );
              } else if (state is GoalErrorState) {
                return Text('Error: ${state.message}');
              } else {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<GoalBloc, GoalState>(
            builder: (context, state) {
              if (state is GoalLoadedState) {
                return TaskChart(
                  goals: state.goals,
                );
              } else if (state is GoalErrorState) {
                return Text('Error: ${state.message}');
              } else {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 1000,
          ),
        ],
      ),
    );
  }
}
