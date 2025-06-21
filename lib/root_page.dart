import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/services.dart';

import 'package:planza/features/goal_managment/presentation/pages/goals_page.dart';
import 'package:planza/features/home/presentation/pages/home_page.dart';

import 'features/task_managment/presentation/pages/tasks_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const TasksPage(),
    const GoalsPage(),
  ];

  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;

        final now = DateTime.now();
        // Check if the last press was more than 2 seconds ago (or never)
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          // If so, this is the FIRST press.
          _lastPressedAt = now;

          // Show a temporary message to the user.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // If it's the SECOND press within 2 seconds, exit the app.
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.grey[100]!,
          animationDuration: Duration(milliseconds: 300),
          height: 50,
          items: <Widget>[
            /* Icon(Icons.home_rounded, size: 30), */
            Icon(Icons.home_rounded, size: 30),
            Icon(Icons.task_alt_rounded, size: 30),
            Icon(Icons.golf_course_rounded, size: 30),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
