import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/features/task_managment/bloc/task_bloc.dart';
import 'package:planza/features/task_managment/presentation/widgets/add_task_fields.dart';

import 'core/locale/app_localization.dart';
import 'core/widgets/scrollables/scrollable_column.dart';
import 'features/goal_managment/presentation/pages/add_goal_page.dart';
import 'features/goal_managment/presentation/pages/goals_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'core/widgets/appbar/general_app_bar.dart';
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
    /*  HomePage(), */
    TasksPage(),
    GoalsPage(),
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Scaffold(
      drawer: DrawerSection(),
      body: ScrollableColumn(
        children: [
          const SizedBox(
            height: 10,
          ),
          GeneralAppBar(),
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.grey[100]!,
        animationDuration: Duration(milliseconds: 300),
        items: <Widget>[
          /* Icon(Icons.home_rounded, size: 30), */
          Icon(Icons.task_alt_rounded, size: 30),
          Icon(Icons.golf_course_rounded, size: 30),
          Icon(Icons.ssid_chart_rounded, size: 30),
        ],
        onTap: (index) {
          setState(() {
            bottomNavigationBarIndex = index;
          });
        },
      ),
      floatingActionButton: bottomNavigationBarIndex == 0
          ? FloatingActionButton(
              isExtended: true,
              onPressed: () {
                Navigator.of(context).push(
                  ModalBottomSheetRoute(
                    showDragHandle: true,
                    builder: (context) => IntrinsicHeight(
                      child: SafeArea(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  ModalBottomSheetRoute(
                                    showDragHandle: true,
                                    builder: (context) => IntrinsicHeight(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: AddTaskFields(
                                          onSubmit: (newTask) {
                                            Navigator.pop(context);
                                            context.read<TaskBloc>().add(
                                                TaskAddedEvent(
                                                    newTask: newTask));
                                          },
                                        ),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Icon(Icons.task_alt_rounded),
                                title: Text(
                                  appLocalizations
                                      .translate('add_modal_task_title'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  appLocalizations
                                      .translate('add_modal_task_subtitle'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => AddGoalPage(),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Icon(Icons.golf_course_rounded),
                                title: Text(
                                  appLocalizations
                                      .translate('add_modal_goal_title'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Text(
                                  appLocalizations
                                      .translate('add_modal_goal_subtitle'),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    isScrollControlled: true,
                  ),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
