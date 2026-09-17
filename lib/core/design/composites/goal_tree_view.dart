import 'package:flutter/material.dart';
import 'package:planza/core/data/models/goal_model.dart';
import 'package:planza/core/design/tokens/index.dart' show darkColors, lightColors, PlTypography, PlSpacing, PlBorderRadius, PlMotion;

typedef OnGoalTap = void Function(GoalModel goal);
typedef OnGoalReorder = void Function(int oldIndex, int newIndex, int? parentGoalId);

class GoalTreeView extends StatefulWidget {
  final List<GoalModel> goals;
  final OnGoalTap? onTap;
  final OnGoalReorder? onReorder;
  final bool showCompleted;
  final Set<int> expandedGoals;

  const GoalTreeView({
    super.key,
    required this.goals,
    this.onTap,
    this.onReorder,
    this.showCompleted = true,
    this.expandedGoals = const {},
  });

  @override
  State<GoalTreeView> createState() => _GoalTreeViewState();
}

class _GoalTreeViewState extends State<GoalTreeView> with SingleTickerProviderStateMixin {
  late Map<int, List<GoalModel>> _childrenMap;
  late Map<int, GoalModel> _goalMap;
  late List<GoalModel> _roots;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: PlMotion.medium,
      vsync: this,
    );
    _buildTree();
  }

  @override
  void didUpdateWidget(covariant GoalTreeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.goals != widget.goals) {
      _buildTree();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _buildTree() {
    _goalMap = {for (var g in widget.goals) g.id!: g};
    _childrenMap = {};
    
    for (var goal in widget.goals) {
      if (goal.parentGoalId != null) {
        _childrenMap.putIfAbsent(goal.parentGoalId!, () => []).add(goal);
      }
    }
    
    // Sort children by some criteria (e.g., creation order, name)
    _childrenMap.forEach((_, children) {
      children.sort((a, b) => (a.name).compareTo(b.name));
    });
    
    _roots = widget.goals.where((g) => g.parentGoalId == null).toList();
    _roots.sort((a, b) => (a.name).compareTo(b.name));
  }

  bool _isExpanded(int goalId) => widget.expandedGoals.contains(goalId);
  bool _hasChildren(int goalId) => _childrenMap[goalId]?.isNotEmpty ?? false;

  void _toggleExpand(int goalId) {
    // This would be handled by parent via callback
    // For now, we just notify parent
  }

  @override
  Widget build(BuildContext context) {
    if (_roots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: _roots.map((root) => _buildGoalNode(root, 0)).toList(),
    );
  }

  Widget _buildGoalNode(GoalModel goal, int depth) {
    final hasChildren = _hasChildren(goal.id!);
    final isExpanded = _isExpanded(goal.id!);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _GoalTreeItem(
          goal: goal,
          depth: depth,
          hasChildren: hasChildren,
          isExpanded: isExpanded,
          onTap: widget.onTap,
          onExpandToggle: () {
            // Parent handles expansion state
          },
        ),
        if (hasChildren && isExpanded)
          Padding(
            padding: EdgeInsets.only(left: 16.0 * (depth + 1)),
            child: Column(
              children: (_childrenMap[goal.id!] ?? [])
                  .map((child) => _buildGoalNode(child, depth + 1))
                  .toList(),
            ),
          ),
      ],
    );
  }
}

class _GoalTreeItem extends StatelessWidget {
  final GoalModel goal;
  final int depth;
  final bool hasChildren;
  final bool isExpanded;
  final OnGoalTap? onTap;
  final VoidCallback? onExpandToggle;

  const _GoalTreeItem({
    required this.goal,
    required this.depth,
    required this.hasChildren,
    required this.isExpanded,
    this.onTap,
    this.onExpandToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return InkWell(
      onTap: () => onTap?.call(goal),
      borderRadius: PlBorderRadius.radiusMd,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: PlSpacing.md,
          vertical: PlSpacing.sm,
        ),
        child: Row(
          children: [
            if (hasChildren)
              IconButton(
                icon: Icon(
                  isExpanded ? Icons.expand_more : Icons.chevron_right,
                  size: 20,
                  color: colors.onSurfaceVariant,
                ),
                onPressed: onExpandToggle,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              )
            else
              const SizedBox(width: 32),
            SizedBox(width: 8.0 * depth),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: goal.color.withOpacity(0.15),
                borderRadius: PlBorderRadius.radiusSm,
              ),
              child: Icon(goal.icon, color: goal.color, size: 18),
            ),
            SizedBox(width: PlSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal.name,
                    style: PlTypography.titleSmall.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (goal.tasks.isNotEmpty)
                    Text(
                      '${goal.tasks.where((t) => t.isCompleted).length}/${goal.tasks.length} tasks',
                      style: PlTypography.bodySmall.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
            if (goal.tasks.isNotEmpty)
              ProgressIndicator(
                value: goal.progress,
                color: goal.color,
              ),
          ],
        ),
      ),
    );
  }
}

// Simple progress indicator for tree view
class ProgressIndicator extends StatelessWidget {
  final double value;
  final Color color;

  const ProgressIndicator({
    super.key,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 4,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}