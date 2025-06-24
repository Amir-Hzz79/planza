import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/bloc/task_bloc/task_bloc.dart';
import '../../../../core/locale/app_localizations.dart';
import '../../../goal_managment/presentation/pages/goal_entry_page.dart';

import '../../../task_managment/presentation/widgets/task_entry_sheet.dart';

class SpeedDialFab extends StatefulWidget {
  const SpeedDialFab({super.key});

  @override
  State<SpeedDialFab> createState() => _SpeedDialFabState();
}

class _SpeedDialFabState extends State<SpeedDialFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isOpen)
          FadeTransition(
            opacity: _animationController,
            child: ScaleTransition(
              scale: _animationController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildMiniFab(
                    label: lang.homePage_fab_addGoal,
                    icon: Icons.flag_outlined,
                    onPressed: () {
                      _toggle();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const GoalEntryPage()));
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMiniFab(
                    label: lang.homePage_fab_addTask,
                    icon: Icons.task_alt_outlined,
                    onPressed: () {
                      _toggle();
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (ctx) => TaskEntrySheet(
                          onSubmit: (newTask) {
                            context
                                .read<TaskBloc>()
                                .add(TaskAddedEvent(newTask: newTask));
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'mainSpeedDialFab',
          onPressed: _toggle,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
          ),
        ),
      ],
    );
  }

  Widget _buildMiniFab(
      {required String label,
      required IconData icon,
      required VoidCallback onPressed}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(label),
          ),
        ),
        const SizedBox(width: 8),
        FloatingActionButton.small(
          heroTag: null,
          onPressed: onPressed,
          child: Icon(icon),
        ),
      ],
    );
  }
}
