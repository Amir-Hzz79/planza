import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/utils/extention_methods/color_extention.dart';
import '../../../../core/data/bloc/goal_bloc/goal_bloc_builder.dart';
import '../../../../core/data/bloc/task_bloc/task_bloc.dart';
import '../../../task_managment/presentation/widgets/add_task_fields.dart';
import '../../../task_managment/presentation/widgets/detail_task_row.dart';
import '../widgets/status_overview_dashboard.dart';

class GoalDetailsPage extends StatelessWidget {
  final GoalModel goal;

  const GoalDetailsPage({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The FAB for adding new tasks
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            ModalBottomSheetRoute(
              showDragHandle: true,
              builder: (context) => IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AddTaskFields(
                    fixedGoal: goal,
                    onSubmit: (newTask) {
                      Navigator.pop(context);
                      context
                          .read<TaskBloc>()
                          .add(TaskAddedEvent(newTask: newTask));
                    },
                  ),
                ),
              ),
              isScrollControlled: true,
            ),
          );
          // Navigate to your "add task" page, passing the goal.id
        },
        backgroundColor: goal.color,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      // The body is a CustomScrollView to handle different scrolling sections (Slivers)
      body: GoalBlocBuilder(onDataLoaded: (goals) {
        return CustomScrollView(
          slivers: [
            // 1. The large, thematic app bar
            _buildSliverAppBar(context),
            // 2. The status dashboard
            SliverToBoxAdapter(
              child: StatusOverviewDashboard(goal: goal),
            ),
            // 3. The goal description (if it exists)
            if (goal.description?.isNotEmpty ?? false)
              _buildDescription(context),
            // 4. The header for the task list
            _buildTaskListHeader(context),
            // 5. The scrollable list of tasks
            _buildTaskList(),
          ],
        );
      }),
    );
  }

  // --- SLIVER BUILDER HELPERS ---

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      stretch: true,
      backgroundColor: goal.color.withOpacity(0.8),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          goal.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: goal.color.matchTextColor().withOpacity(0.7),
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [goal.color.withOpacity(0.6), goal.color],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
            ),
            Positioned(
              left:
                  Directionality.of(context) == TextDirection.rtl ? -20 : null,
              right:
                  Directionality.of(context) == TextDirection.rtl ? null : -20,
              bottom: -20,
              child: Icon(
                Icons.fitness_center_rounded,
                size: 200,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("About",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(goal.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color)),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskListHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 8.0),
        child: Text(
          "Tasks (${goal.tasks.length})",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    // SliverList is the efficient way to build lists inside a CustomScrollView
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final task = goal.tasks[index];
          // We reuse the GlassyTaskCard we already perfected!
          return DetailedTaskRow(
            task: task,
          );
        },
        childCount: goal.tasks.length,
      ),
    );
  }
}
