import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/data_access_object/goal_dao.dart';

import 'package:planza/core/data/database/database.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/features/home/presentation/widgets/appbart/home_page_app_bar.dart';
import 'package:planza/features/home/presentation/widgets/drawer/drawer_section.dart';
import 'package:planza/features/home/presentation/widgets/goal_counter/goal_counter_section.dart';

import '../../../../core/widgets/scrollables/scrollable_column.dart';
import '../widgets/task_chart/task_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoalDao goalDao = GetIt.I.get<GoalDao>();
  late Future<List<GoalModel>> futureGoals;

  @override
  void initState() {
    futureGoals = goalDao.getAllGoalsWithTasks();
    super.initState();
  }

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
          FutureBuilder(
            future: futureGoals,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.grey[200],
                );
              } else {
                return GoalCounterSection(
                  goals: snapshot.data ?? [],
                );
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: futureGoals,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  width: double.infinity,
                  height: 300,
                  color: Colors.grey[200],
                );
              } else {
                return TaskChart(
                  goals: snapshot.data ?? [],
                );
              }
            },
          ),
          TextButton(
            onPressed: () {
              AppDatabase db = GetIt.I.get<AppDatabase>();
              db.insertDummyData(db);
            },
            child: Text('Insert dummy data'),
          ),
          const SizedBox(
            height: 1000,
          ),
        ],
      ),
    );
  }
}
