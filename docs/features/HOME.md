# Home

The landing page: dashboard with goals carousel, metrics, weekly chart, tag analysis, speed-dial FAB, and drawer navigation.

## What It Does

- Shows a carousel of active goals (goals_carousel)
- Metric cards: key stats at a glance
- Weekly chart: activity overview for the week
- Tag analysis chart: tag distribution
- Section headers and empty state widgets
- Speed-dial FAB for quick actions (add goal, add task, etc.)
- Drawer with navigation links (drawer_list_button, drawer_section)
- Custom back-press exit: double-tap back within 2s to exit (with SnackBar confirm on first press)

## Key Files

```
lib/features/home/
├── presentation/
│   ├── pages/
│   │   └── home_page.dart            # Main dashboard
│   └── widgets/
│       ├── goals_carousel.dart       # Carousel of active goal cards
│       ├── metric_item.dart          # Single metric display
│       ├── section_header.dart       # Section title header
│       ├── empty_section.dart        # Empty state placeholder
│       ├── weekly_chart.dart         # Weekly activity chart
│       ├── tag_analysis_chart.dart   # Tag distribution chart
│       ├── speed_dial_fab.dart       # Speed-dial floating action button
│       └── drawer/
│           ├── drawer_list_button.dart  # Drawer list item
│           └── drawer_section.dart      # Drawer section grouping
```

## Structure

HomePage is an IndexedStack child (index 0) in RootPage's 5-page stack. It's a scrollable dashboard with multiple sections.

## Navigation

- Bottom nav index 0 (home icon) → HomePage
- Drawer provides additional navigation links
- Speed-dial FAB offers quick-add actions

## Integration Points

- Goals: goals_carousel reads from GoalBloc (active goals)
- Tasks: metrics may include task completion stats
- Tags: tag_analysis_chart reads from TagBloc
- Gamification: metrics may show XP/level
- Hobbies: may show hobby-related metrics (future)
