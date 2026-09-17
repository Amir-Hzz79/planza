import 'package:flutter/material.dart';
import 'package:planza/core/design/tokens/colors.dart';

import '../tokens/spacing.dart';

class PlReorderableListView extends StatefulWidget {
  final List<Widget> children;
  final ValueChanged<ReorderEvent>? onReorder;
  final EdgeInsetsGeometry? padding;
  final double spacing;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const PlReorderableListView({
    super.key,
    required this.children,
    this.onReorder,
    this.padding,
    this.spacing = PlSpacing.xs,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  State<PlReorderableListView> createState() => _PlReorderableListViewState();
}

class _PlReorderableListViewState extends State<PlReorderableListView> {
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = List.from(widget.children);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: (widget.padding ?? PlSpacing.page) as EdgeInsets?,
      scrollDirection: widget.scrollDirection,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) newIndex--;
          final item = _children.removeAt(oldIndex);
          _children.insert(newIndex, item);
        });
        widget.onReorder
            ?.call(ReorderEvent(oldIndex: oldIndex, newIndex: newIndex));
      },
      buildDefaultDragHandles: false,
      children: _children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        return _ReorderableItem(
          key: ValueKey(index),
          index: index,
          spacing: widget.spacing,
          child: child,
        );
      }).toList(),
    );
  }
}

class _ReorderableItem extends StatelessWidget {
  final int index;
  final Widget child;
  final double spacing;

  const _ReorderableItem({
    super.key,
    required this.index,
    required this.child,
    required this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return ReorderableDragStartListener(
      index: index,
      child: Padding(
        padding: EdgeInsets.only(bottom: spacing),
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Container(
                  padding: const EdgeInsets.all(PlSpacing.sm),
                  child: Icon(
                    Icons.drag_indicator,
                    color: colors.onSurfaceVariant.withOpacity(0.5),
                    size: 24,
                  ),
                ),
              ),
              SizedBox(width: PlSpacing.sm),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class ReorderEvent {
  final int oldIndex;
  final int newIndex;

  ReorderEvent({required this.oldIndex, required this.newIndex});
}

class PlReorderableGridView extends StatefulWidget {
  final List<Widget> children;
  final ValueChanged<ReorderEvent>? onReorder;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final EdgeInsetsGeometry? padding;

  const PlReorderableGridView({
    super.key,
    required this.children,
    this.onReorder,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = PlSpacing.md,
    this.crossAxisSpacing = PlSpacing.md,
    this.padding,
  });

  @override
  State<PlReorderableGridView> createState() => _PlReorderableGridViewState();
}

class _PlReorderableGridViewState extends State<PlReorderableGridView> {
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _children = List.from(widget.children);
  }

  @override
  Widget build(BuildContext context) {
    // Note: ReorderableGridView requires Flutter 3.10+
    // If not available, this will cause a compile error
    return const Center(
        child: Text('ReorderableGridView requires Flutter 3.10+'));
    /*
    return ReorderableGridView.count(
      padding: widget.padding ?? PlSpacing.page,
      crossAxisCount: widget.crossAxisCount,
      mainAxisSpacing: widget.mainAxisSpacing,
      crossAxisSpacing: widget.crossAxisSpacing,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) newIndex--;
          final item = _children.removeAt(oldIndex);
          _children.insert(newIndex, item);
        });
        widget.onReorder
            ?.call(ReorderEvent(oldIndex: oldIndex, newIndex: newIndex));
      },
      buildDefaultDragHandles: false,
      children: _children.asMap().entries.map((entry) {
        final index = entry.key;
        final child = entry.value;
        return _ReorderableGridItem(
            key: ValueKey(index), index: index, child: child);
      }).toList(),
    );
    */
  }
}

class _ReorderableGridItem extends StatelessWidget {
  final int index;
  final Widget child;

  const _ReorderableGridItem({super.key, required this.index, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return ReorderableDragStartListener(
      index: index,
      child: Stack(
        children: [
          child,
          Positioned(
            top: PlSpacing.xs,
            right: PlSpacing.xs,
            child: Container(
              padding: const EdgeInsets.all(PlSpacing.xs),
              decoration: BoxDecoration(
                color: colors.surface.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2))
                ],
              ),
              child: Icon(Icons.drag_indicator,
                  color: colors.onSurfaceVariant, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
