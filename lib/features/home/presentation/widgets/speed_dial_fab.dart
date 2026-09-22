import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/database/database.dart';

import 'package:planza/core/design/primitives/glassy_fab.dart';
import 'package:planza/core/design/tokens/colors.dart';
import 'package:planza/core/design/tokens/spacing.dart';

import '../../../../core/data/bloc/task_bloc/task_bloc.dart';
import '../../../../core/locale/app_localizations.dart';
import '../../../../core/locale/bloc/locale_bloc.dart';
import '../../../../core/locale/bloc/locale_state.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;
    final Lang lang = Lang.of(context)!;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Speed dial items (glassy, rotating, fading)
        if (_isOpen) ...[
          ...List.generate(3, (index) {
            final delay = Duration(milliseconds: index * 50);
            final item = _SpeedDialItem(
              label: index == 0
                  ? lang.homePage_fab_addData
                  : (index == 1
                      ? lang.homePage_fab_addGoal
                      : lang.homePage_fab_addTask),
              icon: index == 0
                  ? Icons.code_rounded
                  : (index == 1
                      ? Icons.flag_outlined
                      : Icons.task_alt_outlined),
              onPressed: () {
                _toggle();
                if (index == 0) {
                  _showAddDataConfirmation(context);
                } else if (index == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const GoalEntryPage(),
                  ));
                } else {
                  _showTaskEntrySheet(context);
                }
              },
              color: colors.primary,
            );
            return Positioned(
              right: 60.0 + (index * 4) - (index * 2),
              bottom: 80.0 + (index * 52.0),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final progress = _animationController.value;
                  final opacity =
                      (progress > 0.3 ? (progress - 0.3) / 0.7 : 0.0);
                  return Opacity(
                    opacity: opacity,
                    child: Transform.scale(
                      scale: progress > 0.3 ? (progress - 0.3) / 0.7 : 0.0,
                      child: child,
                    ),
                  );
                },
                child: item,
              ),
            );
          }).reversed.toList(),
        ],

        // Main FAB (glassy, with rotation animation)
        Positioned(
          right: 16,
          bottom: 100,
          child: GlassyFAB(
            icon: _isOpen ? Icons.close : Icons.add,
            size: 52,
            onPressed: _toggle,
          ),
        ),
      ],
    );
  }

  void _showAddDataConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16,
            16,
            16,
            MediaQuery.of(context).viewInsets.bottom + 64,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Lang.of(context)!.homePage_fab_confirmation,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(Lang.of(context)!.general_cancel),
                  ),
                  TextButton(
                    onPressed: () {
                      String localeCode = (context.read<LocaleBloc>().state
                              as LocaleLoadedState)
                          .locale
                          .languageCode;

                      if (localeCode == 'en') {
                        GetIt.instance.get<AppDatabase>().insertEnDummyData();
                      } else if (localeCode == 'fa') {
                        GetIt.instance.get<AppDatabase>().insertFaDummyData();
                      }

                      setState(() {});
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                    child: Text(Lang.of(context)!.general_deleteConfirm),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTaskEntrySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => TaskEntrySheet(
        onSubmit: (newTask) {
          context.read<TaskBloc>().add(TaskAddedEvent(newTask: newTask));
          Navigator.pop(ctx);
        },
      ),
    );
  }
}

class _SpeedDialItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const _SpeedDialItem({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Glassy label chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: colors.surfaceContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: colors.outlineVariant.withOpacity(0.2),
                width: 0.5,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: colors.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Glassy mini FAB
          InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.surface.withOpacity(0.7),
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.outlineVariant.withOpacity(0.25),
                  width: 0.5,
                ),
              ),
              child: Icon(
                icon,
                size: 20,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
