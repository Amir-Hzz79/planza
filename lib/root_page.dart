import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:planza/core/design/primitives/glassy_bottom_nav.dart';
import 'package:planza/features/goal_managment/presentation/pages/goals_page.dart';
import 'package:planza/features/gamification/presentation/pages/profile_page.dart';
import 'package:planza/features/home/presentation/pages/home_page.dart';
import 'package:planza/features/hobbies_habits/presentation/pages/hobbies_page.dart';

import 'core/locale/app_localizations.dart';
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
    const HobbiesPage(),
    const ProfilePage(),
  ];

  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;

        final now = DateTime.now();
        // Check if the last press was more than 2 seconds ago (or never)
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          // If so, this is the FIRST press.
          _lastPressedAt = now;

          // Show a temporary message to the user.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(lang.general_exitConfirm),
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
        bottomNavigationBar: GlassyBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          tabs: const [
            BottomNavTab(
              icon: Icons.home_rounded,
              activeIcon: Icons.home,
              label: 'Home',
            ),
            BottomNavTab(
              icon: Icons.task_alt_rounded,
              activeIcon: Icons.task_alt,
              label: 'Tasks',
            ),
            BottomNavTab(
              icon: Icons.golf_course_rounded,
              activeIcon: Icons.golf_course,
              label: 'Goals',
            ),
            BottomNavTab(
              icon: Icons.track_changes,
              activeIcon: Icons.track_changes,
              label: 'Hobbies',
            ),
            BottomNavTab(
              icon: Icons.person_rounded,
              activeIcon: Icons.person,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
