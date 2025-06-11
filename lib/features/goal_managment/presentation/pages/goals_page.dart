import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:planza/core/data/bloc/goal_bloc/goal_bloc.dart';
import 'package:planza/core/data/models/goal_model.dart';

import '../../../../core/widgets/appbar/general_app_bar.dart';
import '../../../home/presentation/widgets/drawer/drawer_section.dart';
import '../widgets/goal_cards/active_goal_card.dart';
import '../widgets/goal_cards/complete_goal_card.dart';
import '../widgets/goal_cards/featured_goal_card.dart';
import 'goal_entry_page.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerSection(),
      appBar: AppBar(
        leading: GeneralAppBar(),
        title: const Text('My Ambitions',
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add Goal',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const GoalEntryPage(),
              ));
            },
          ),
        ],
      ),
      body: BlocBuilder<GoalBloc, GoalState>(
        builder: (context, state) {
          if (state is GoalLoadingState || state is GoalInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GoalErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }
          if (state is GoalsLoadedState) {
            final activeGoals =
                state.goals.where((g) => !g.isCompleted).toList();
            final completedGoals =
                state.goals.where((g) => g.isCompleted).toList();

            // Logic to determine featured goals (e.g., the first 2 active goals)
            final featuredGoals = activeGoals.take(2).toList();
            final otherActiveGoals = activeGoals.skip(2).toList();

            if (activeGoals.isEmpty && completedGoals.isEmpty) {
              return _buildEmptyState(context);
            }

            // The main scrolling body of the page
            return ListView(
              padding: const EdgeInsets.only(bottom: 80.0),
              children: [
                // Section 1: Featured Goals Carousel
                if (featuredGoals.isNotEmpty)
                  _buildSectionHeader(context, "Up Next..."),
                if (featuredGoals.isNotEmpty)
                  _FeaturedGoalsCarousel(goals: featuredGoals),

                // Section 2: Other Active Goals
                if (otherActiveGoals.isNotEmpty)
                  _buildSectionHeader(context, "Keep Going!"),
                ...otherActiveGoals.map((goal) => ActiveGoalCard(goal: goal)),

                // Section 3: Hall of Fame for Completed Goals
                if (completedGoals.isNotEmpty)
                  _buildSectionHeader(context, "Hall of Fame 🏆"),
                if (completedGoals.isNotEmpty)
                  _CompletedGoalsCarousel(goals: completedGoals),
              ],
            );
          }
          return const Center(child: Text('Something went wrong.'));
        },
      ),
    );
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.rocket_launch_outlined,
              size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            "Your ambitions will appear here.\nLet's create your first goal!",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("Create a Goal"),
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

// --- Carousel for Featured Goals ---
class _FeaturedGoalsCarousel extends StatelessWidget {
  final List<GoalModel> goals;
  const _FeaturedGoalsCarousel({required this.goals});

  @override
  Widget build(BuildContext context) {
    // PageView provides a nice snapping effect for a hero carousel.
    return SizedBox(
      height: 220,
      child: PageView.builder(
        controller: PageController(
            viewportFraction: 0.85), // Shows a glimpse of the next card
        itemCount: goals.length,
        itemBuilder: (context, index) {
          final goal = goals[index];
          return FeaturedGoalCard(goal: goal);
        },
      ),
    );
  }
}

// --- Carousel for Completed Goals ---
class _CompletedGoalsCarousel extends StatelessWidget {
  final List<GoalModel> goals;
  const _CompletedGoalsCarousel({required this.goals});

  @override
  Widget build(BuildContext context) {
    // A horizontal ListView is great for a continuous scroll.
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

// --- Individual Card Widgets ---
