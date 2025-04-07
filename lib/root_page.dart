import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'core/widgets/scrollables/scrollable_column.dart';
import 'features/goal_managment/presentation/pages/goal_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/widgets/appbart/home_page_app_bar.dart';
import 'features/home/presentation/widgets/drawer/drawer_section.dart';
import 'features/task_managment/presentation/pages/tasks_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int bottomNavigationBarIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    TasksPage(),
    GoalPage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerSection(),
      body: ScrollableColumn(
        children: [
          const SizedBox(
            height: 10,
          ),
          HomePageAppBar(),
          const SizedBox(
            height: 20,
          ),
          IndexedStack(
            index: bottomNavigationBarIndex,
            children: pages,
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
        backgroundColor:
            Theme.of(context).colorScheme.inverseSurface.withOpacity(0.7),
        marginR: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        paddingR: EdgeInsets.all(5),
        currentIndex: bottomNavigationBarIndex,
        onTap: (index) {
          setState(
            () {
              bottomNavigationBarIndex = index;
            },
          );
        },
        dotIndicatorColor: Theme.of(context).colorScheme.onInverseSurface,
        // enableFloatingNavBar: false
        items: [
          DotNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            unselectedColor: Theme.of(context).colorScheme.onInverseSurface,
            selectedColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.task_alt_rounded),
            unselectedColor: Theme.of(context).colorScheme.onInverseSurface,
            selectedColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.golf_course_rounded),
            unselectedColor: Theme.of(context).colorScheme.onInverseSurface,
            selectedColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.ssid_chart_rounded),
            unselectedColor: Theme.of(context).colorScheme.onInverseSurface,
            selectedColor: Theme.of(context).colorScheme.onInverseSurface,
          ),
        ],
      ),
    );
  }
}
