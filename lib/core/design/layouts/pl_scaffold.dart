import 'package:flutter/material.dart';
import 'package:planza/core/design/primitives/pl_app_bar.dart' show PlAppBar, PlAppBarStyle;
import 'package:planza/core/design/tokens/index.dart' show PlColorScheme, PlLightColors, PlDarkColors, lightColors, darkColors, PlTypography, PlSpacing;

class PlScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final bool extendBody;
  final bool extendBodyBehindAppBar;

  const PlScaffold({
    super.key,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return Scaffold(
      body: body,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor ?? colors.background,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }
}

class PlPageTemplate extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget body;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? bottom;
  final bool hasScrollBody;
  final EdgeInsetsGeometry? bodyPadding;
  final bool showAppBar;
  final PlAppBarStyle appBarStyle;

  const PlPageTemplate({
    super.key,
    this.title,
    this.leading,
    this.actions,
    required this.body,
    this.floatingActionButton,
    this.bottom,
    this.hasScrollBody = true,
    this.bodyPadding,
    this.showAppBar = true,
    this.appBarStyle = PlAppBarStyle.standard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final appBar = showAppBar
        ? PlAppBar(
            title: title,
            leading: leading,
            actions: actions,
            bottom: bottom,
            style: appBarStyle,
          )
        : null;

    final bodyContent = hasScrollBody
        ? CustomScrollView(
            slivers: [
              if (bodyPadding != null)
                SliverPadding(
                  padding: bodyPadding!,
                  sliver: SliverToBoxAdapter(child: body),
                )
              else
                SliverToBoxAdapter(child: body),
            ],
          )
        : Padding(padding: bodyPadding ?? EdgeInsets.zero, child: body);

    return PlScaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      body: bodyContent,
      extendBodyBehindAppBar: appBarStyle == PlAppBarStyle.transparent,
    );
  }
}

class PlListView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final double spacing;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;

  const PlListView({
    super.key,
    required this.children,
    this.padding,
    this.spacing = 0,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final items = spacing > 0
        ? List<Widget>.generate(children.length * 2 - 1, (i) {
            if (i.isEven) return children[i ~/ 2];
            return SizedBox(
              height: scrollDirection == Axis.vertical ? spacing : 0,
              width: scrollDirection == Axis.horizontal ? spacing : 0,
            );
          })
        : children;

    return ListView(
      padding: padding ?? PlSpacing.page,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      addRepaintBoundaries: addRepaintBoundaries,
      addSemanticIndexes: addSemanticIndexes,
      children: items,
    );
  }
}

class PlGridView extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const PlGridView({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = PlSpacing.md,
    this.crossAxisSpacing = PlSpacing.md,
    this.childAspectRatio = 1.0,
    this.padding,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: padding ?? PlSpacing.page,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: children,
    );
  }
}

class PlSliverAppBar extends StatelessWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final double expandedHeight;
  final bool pinned;
  final bool snap;
  final bool floating;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const PlSliverAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.expandedHeight = 200,
    this.pinned = true,
    this.snap = false,
    this.floating = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return SliverAppBar(
      title: title != null
          ? Text(title!, style: PlTypography.titleLarge.copyWith(color: foregroundColor ?? colors.onSurface))
          : null,
      leading: leading,
      actions: actions,
      flexibleSpace: flexibleSpace,
      expandedHeight: expandedHeight,
      pinned: pinned,
      snap: snap,
      floating: floating,
      backgroundColor: backgroundColor ?? colors.surface,
      foregroundColor: foregroundColor ?? colors.onSurface,
      surfaceTintColor: Colors.transparent,
    );
  }
}


