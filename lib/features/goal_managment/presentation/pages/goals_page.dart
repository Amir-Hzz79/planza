import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:planza/core/data/bloc/goal_bloc/goal_bloc.dart';
import 'package:planza/core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/design/composites/goal_tree_view.dart';

import '../../../../core/locale/app_localizations.dart';
import '../../../../core/widgets/appbar/general_app_bar.dart';
import '../../../home/presentation/widgets/drawer/drawer_section.dart';
import '../widgets/goal_cards/active_goal_card.dart';
import '../widgets/goal_cards/complete_goal_card.dart';
import '../widgets/goal_cards/featured_goal_card.dart';
import 'goal_entry_page.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final Set<int> _expandedGoals = {};
  final Set<int> _selectedGoals = {};

  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return Scaffold(
      drawer: DrawerSection(),
      appBar: AppBar(
        leading: GeneralAppBar(),
        title: Text(
          lang.goalsPage_title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: lang.goalsPage_addGoal_button,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const GoalEntryPage(),
              ));
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.view_module),
            tooltip: 'View Options',
            onSelected: (value) {
              // Handle view options
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'tree',
                child: ListTile(
                  leading: Icon(Icons.account_tree),
                  title: Text('Tree View'),
                ),
              ),
              PopupMenuItem(
                value: 'list',
                child: ListTile(
                  leading: Icon(Icons.list),
                  title: Text('List View'),
                ),
              ),
            ],
          ),
        ],
      ),
      body: GoalBlocBuilder(
        onDataLoaded: (goals) {
          final activeGoals = goals.where((g) => !g.isCompleted).toList();
          final completedGoals = goals.where((g) => g.isCompleted).toList();

          if (activeGoals.isEmpty && completedGoals.isEmpty) {
            return _buildEmptyState(context);
          }

          return Column(
            children: [
              // Active Goals Tree
              if (activeGoals.isNotEmpty) ...[
                _buildSectionHeader(context, lang.goalsPage_activeGoals_title),
                GoalTreeView(
                  goals: activeGoals,
                  expandedGoals: _expandedGoals,
                  onTap: (goal) => _onGoalTap(goal),
                  onReorder: _onGoalReorder,
                ),
              ],

              // Completed Goals (flat list for now)
              if (completedGoals.isNotEmpty) ...[
                _buildSectionHeader(
                  context,
                  lang.goalsPage_completedGoals_title,
                ),
                _CompletedGoalsCarousel(goals: completedGoals),
              ],
            ],
          );
        },
      ),
    );
  }

  void _onGoalTap(GoalModel goal) {
    if (_selectedGoals.contains(goal.id)) {
      _selectedGoals.remove(goal.id);
    } else {
      _selectedGoals.add(goal.id!);
    }
    setState(() {});
  }

  void _onGoalReorder(int oldIndex, int newIndex, int? parentGoalId) {
    // TODO: Handle reorder - would need bloc event
    // final goalBloc = context.read<GoalBloc>();
    // goalBloc.add(GoalReorderedEvent(
    //   goalId: oldIndex, // This would need the actual goal ID
    //   newParentId: parentGoalId,
    //   newIndex: newIndex,
    // ));
  }

  void _toggleExpand(int goalId) {
    setState(() {
      if (_expandedGoals.contains(goalId)) {
        _expandedGoals.remove(goalId);
      } else {
        _expandedGoals.add(goalId);
      }
    });
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    Lang lang = Lang.of(context)!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.rocket_launch_outlined,
              size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            lang.goalsPage_goals_empty,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: Text(lang.goalsPage_addGoal_button),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const GoalEntryPage(),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class _CompletedGoalsCarousel extends StatelessWidget {
  final List<GoalModel> goals;
  const _CompletedGoalsCarousel({required this.goals});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: goals.length,
        itemBuilder: (context, index) {
          final goal = goals[index];
          return CompletedGoalCard(goal: goal);
        },
      ),
    );
  }
}