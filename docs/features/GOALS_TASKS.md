# Goals & Tasks

The core productivity feature: hierarchical goals with subtasks, tasks with due dates/priorities, tags, and drag-drop reorder.

## What It Does

- Create/edit/delete goals with parent-child hierarchy (tree UI)
- Each goal has tasks; tasks have subtasks, due dates, priorities, tags
- Drag-drop reorder goals in the tree
- Task detail page with calendar view, filters, multi-select
- Tag management (create, assign, filter)
- Goal progress visualization (metric cards, status dashboard)

## Key Files

```
lib/features/goal_managment/
├── presentation/
│   ├── pages/
│   │   ├── goals_page.dart          # Goal tree list (main)
│   │   ├── goal_details.dart        # Goal detail + tasks
│   │   ├── goal_entry_page.dart     # Create/edit goal form
│   │   └── achievement_details_page.dart
│   └── widgets/
│       ├── goal_cards/              # Active/Complete/Featured/Thematic card variants
│       ├── metric_card.dart         # Goal metric display
│       ├── status_overview_dashboard.dart
│       └── delete_goal_sheet.dart   # Delete confirmation

lib/core/data/
├── models/
│   ├── goal_model.dart              # Goal entity (id, name, description, deadline, color, icon, parentGoalId)
│   └── subtask_model.dart           # Subtask entity
├── data_access_object/
│   ├── goal_dao.dart                # CRUD + watch streams, insertGoalWithTasks
│   └── subtask_dao.dart
└── bloc/
    ├── goal_bloc/
    │   ├── goal_bloc.dart           # StartWatchingGoals, Add/Update/Delete, optimistic updates
    │   ├── goal_event.dart
    │   ├── goal_state.dart          # Initial, Loading, Loaded (list), Error
    │   └── goal_bloc_builder.dart   # Reusable builder wrapper
    └── tag_bloc/                    # Tags CRUD + watch
```

## BLoC: GoalBloc

Events: `StartWatchingGoalsEvent`, `GoalsUpdatedEvent`, `GoalAddedEvent`, `GoalUpdatedEvent`, `GoalDeletedEvent`, `GoalAndItsTasksDeletedEvent`

State: `GoalInitial` → `GoalLoadingState` → `GoalsLoadedState(List<GoalModel>)` / `GoalErrorState`

Patterns:
- Watch stream from DAO → listen → emit `GoalsUpdatedEvent` → state update
- Optimistic update on add: emit new list immediately, rollback on DAO error

## Data Models

**GoalModel**: id, name, description, deadline (DateTime?), color (int), icon (int), parentGoalId (int?), createdAt/updatedAt

**TaskModel**: id, title, description, dueDate, doneDate, priority (int), goalId, parentTaskId

**TagModel**: id, name, color

## Navigation

- Home (index 0) → goals_carousel shows active goals
- Bottom nav index 2 (golf_course icon) → GoalsPage (goal tree)
- Goal detail → task list with create/add
- Tasks via bottom nav index 1 (task_alt icon) → TasksPage

## Integration Points

- Tags: TaskTags many-to-many, TagBloc for CRUD
- Templates: "Use Template" creates goals + tasks
- Gamification: goal completion may trigger XP (future)
- Notifications: per-goal notification overrides
