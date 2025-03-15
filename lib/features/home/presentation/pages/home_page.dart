import 'package:flutter/material.dart';
import 'package:planza/features/home/presentation/widgets/appbart/home_page_app_bar.dart';
import 'package:planza/features/home/presentation/widgets/drawer/drawer_section.dart';
import 'package:planza/features/home/presentation/widgets/goal_counter/goal_section.dart';

import '../../../../core/widgets/scrollables/scrollable_column.dart';
import '../widgets/task_chart/task_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          GoalSection(),
          const SizedBox(
            height: 20,
          ),
          TaskChart(),
          const SizedBox(
            height: 1000,
          ),
        ],
      ),
    );
  }
}
