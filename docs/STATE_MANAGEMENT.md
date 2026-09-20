# State Management

## Overview

Planza uses **flutter_bloc** (BLoC pattern) for predictable state management.

---

## Core BLoCs

| BLoC | Purpose | Location |
|------|---------|----------|
| `GoalBloc` | Goals hierarchy, CRUD | `core/data/bloc/goal_bloc/` |
| `TaskBloc` | Tasks CRUD, filtering | `core/data/bloc/task_bloc/` |
| `TagBloc` | Tags CRUD | `core/data/bloc/tag_bloc/` |
| `TemplateBloc` | Templates CRUD, import/export | `core/data/bloc/template_bloc/` |
| `UserStatsBloc` | Gamification stats | `core/data/bloc/user_stats_bloc/` |
| `TemplateGalleryBloc` | Gallery UI state | `features/template_gallery/presentation/bloc/` |
| `NotificationSettingsBloc` | Notification settings | `features/notifications/presentation/bloc/` |
| `ThemeBloc` | Theme/color scheme | `core/theme/bloc/` |
| `LocaleBloc` | Localization | `core/locale/bloc/` |

---

## BLoC Pattern

### Event → State Flow

```
Event → BLoC → State
```

### Base Classes

```dart
abstract class BaseEvent extends Equatable { ... }
abstract class BaseState extends Equatable { ... }
```

### Event Example

```dart
sealed class GoalEvent extends Equatable {
  const GoalEvent();
}

class LoadGoals extends GoalEvent {}
class AddGoal extends GoalEvent {
  final GoalModel goal;
  const AddGoal(this.goal);
}
class UpdateGoal extends GoalEvent {
  final GoalModel goal;
  const UpdateGoal(this.goal);
}
```

### State Example

```dart
sealed class GoalState extends Equatable {
  const GoalState();
}

class GoalInitial extends GoalState {}
class GoalLoading extends GoalState {}
class GoalsLoaded extends GoalState {
  final List<GoalModel> goals;
  const GoalsLoaded(this.goals);
}
class GoalError extends GoalState {
  final String message;
  const GoalError(this.message);
}
```

### BLoC Implementation

```dart
class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalDao _goalDao = GetIt.instance.get<GoalDao>();
  StreamSubscription<List<GoalModel>>? _subscription;

  GoalBloc() : super(GoalInitial()) {
    on<LoadGoals>(_onLoadGoals);
    on<AddGoal>(_onAddGoal);
    on<UpdateGoal>(_onUpdateGoal);
    on<DeleteGoal>(_onDeleteGoal);
  }

  Future<void> _onLoadGoals(LoadGoals event, Emitter<GoalState> emit) async {
    emit(GoalLoading());
    await _subscription?.cancel();
    _subscription = _goalDao.watchAllGoalsWithTasks().listen(
      (goals) => add(GoalsUpdated(goals)),
      onError: (e) => emit(GoalError(e.toString())),
    );
  }

  void _onGoalsUpdated(GoalsUpdated event, Emitter<GoalState> emit) {
    emit(GoalsLoaded(event.goals));
  }

  Future<void> _onAddGoal(AddGoal event, Emitter<GoalState> emit) async {
    final currentState = state;
    if (currentState is GoalsLoaded) {
      // Optimistic update
      final optimisticGoals = [...currentState.goals, event.goal];
      emit(GoalsLoaded(optimisticGoals));
      
      try {
        await _goalDao.insertGoalWithTasks(event.goal);
      } catch (e) {
        emit(GoalsLoaded(currentState.goals));
        emit(GoalError('Failed to add goal'));
      }
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
```

---

## Registration

### App Initialization (`app.dart`)

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => ThemeBloc()..add(LoadThemeEvent(context))),
    BlocProvider(create: (_) => LocaleBloc()..add(LoadLocaleEvent(context))),
    BlocProvider(create: (_) => GoalBloc()..add(LoadGoals())),
    BlocProvider(create: (_) => TaskBloc()..add(StartWatchingTasksEvent())),
    BlocProvider(create: (_) => TagBloc()..add(StartWatchingTagsEvent())),
    BlocProvider(create: (_) => TemplateBloc(
      goalBloc: context.read<GoalBloc>(),
      taskBloc: context.read<TaskBloc>(),
      tagBloc: context.read<TagBloc>(),
    )..add(LoadTemplates())),
    BlocProvider(create: (_) => UserStatsBloc()..add(LoadUserStats())),
    BlocProvider(create: (_) => NotificationSettingsBloc()..add(LoadNotificationSettings())),
  ],
  child: ...
)
```

---

## Feature BLoCs

### TemplateGalleryBloc

Manages gallery UI state (filtering, search, selection).

```dart
sealed class TemplateGalleryEvent extends Equatable { ... }

class LoadTemplates extends TemplateGalleryEvent {}
class FilterByCategory extends TemplateGalleryEvent {
  final String category;
  const FilterByCategory(this.category);
}
class SearchTemplates extends TemplateGalleryEvent {
  final String query;
  const SearchTemplates(this.query);
}
class UseTemplate extends TemplateGalleryEvent {
  final TemplateModel template;
  const UseTemplate(this.template);
}
```

```dart
sealed class TemplateGalleryState extends Equatable { ... }

class TemplateGalleryInitial extends TemplateGalleryState {}
class TemplateGalleryLoading extends TemplateGalleryState {}
class TemplateGalleryLoaded extends TemplateGalleryState {
  final List<TemplateModel> templates;
  final String selectedCategory;
  final String? searchQuery;
  const TemplateGalleryLoaded({required this.templates, required this.selectedCategory, this.searchQuery});
}
```

---

## State Patterns

### Optimistic Updates

```dart
Future<void> _onAddGoal(AddGoal event, Emitter<GoalState> emit) async {
  final currentState = state;
  if (currentState is GoalsLoaded) {
    // 1. Optimistic update
    emit(GoalsLoaded([...currentState.goals, event.goal]));
    
    try {
      await _goalDao.insertGoalWithTasks(event.goal);
    } catch (e) {
      // Rollback on error
      emit(GoalsLoaded(currentState.goals));
      emit(GoalError('Failed to add goal'));
    }
  }
}
```

### Stream Subscriptions

```dart
StreamSubscription<List<GoalModel>>? _subscription;

@override
Future<void> close() {
  _subscription?.cancel();
  return super.close();
}

Future<void> _onLoadGoals(LoadGoals event, Emitter<GoalState> emit) async {
  emit(GoalLoading());
  await _subscription?.cancel();
  _subscription = _goalDao.watchAllGoalsWithTasks().listen(
    (goals) => add(GoalsUpdated(goals)),
    onError: (e) => emit(GoalError(e.toString())),
  );
}
```

---

## UI Integration

### BlocBuilder

```dart
BlocBuilder<GoalBloc, GoalState>(
  builder: (context, state) {
    if (state is GoalLoading) return const CircularProgressIndicator();
    if (state is GoalsLoaded) return GoalsList(goals: state.goals);
    if (state is GoalError) return ErrorView(message: state.message);
    return const SizedBox();
  },
)
```

### BlocListener

```dart
BlocListener<GoalBloc, GoalState>(
  listener: (context, state) {
    if (state is GoalError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: ...
)
```

### BlocConsumer

```dart
BlocConsumer<GoalBloc, GoalState>(
  listener: (context, state) {
    if (state is GoalError) { ... }
  },
  builder: (context, state) {
    if (state is GoalsLoaded) return GoalsList(goals: state.goals);
    return const Loading();
  },
)
```

### Reading State

```dart
// Read current state
final goals = context.read<GoalBloc>().state;

// Listen to state changes
BlocListener<GoalBloc, GoalState>(
  listenWhen: (previous, current) => current is GoalError,
  listener: (context, state) { ... },
  child: ...
)
```

---

## Testing BLoCs

```dart
// bloc_test package
blocTest<GoalBloc, GoalState>(
  'emits GoalsLoaded when LoadGoals succeeds',
  build: () {
    final dao = MockGoalDao();
    when(dao.watchAllGoalsWithTasks()).thenAnswer((_) => Stream.value([]));
    return GoalBloc(dao);
  },
  act: (bloc) => bloc.add(LoadGoals()),
  expect: () => [GoalLoading(), GoalsLoaded([])],
);
```

---

## Best Practices

| Practice | Description |
|----------|-------------|
| **Single Responsibility** | One BLoC per feature/domain |
| **Equatable** | All events/states extend Equatable |
| **Optimistic Updates** | Immediate UI feedback, rollback on error |
| **Stream Cleanup** | Cancel subscriptions in `close()` |
| **Error Handling** | Emit `Error` state, show in UI |
| **Testing** | Use `bloc_test` for unit tests |

---

## Anti-Patterns

| ❌ Avoid | ✅ Prefer |
|----------|-----------|
| Multiple BLoCs for same domain | Single BLoC per domain |
| Logic in UI | Business logic in BLoC |
| Mutable state | Immutable states (Equatable) |
| Direct DB calls in UI | Always via BLoC → DAO |
| Forgetting `close()` | Cancel streams in `close()` |