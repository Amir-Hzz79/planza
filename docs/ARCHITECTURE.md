# Planza Architecture

## Overview

Planza follows a **feature-first modular architecture** with clean separation of concerns:

```
lib/
├── core/                 # Shared infrastructure
│   ├── data/             # Database, Models, DAOs, BLoCs
│   ├── design/           # Design System
│   ├── calendar/         # Dual Calendar System
│   ├── locale/           # Localization
│   ├── theme/            # Theming
│   └── services/         # Platform Services
├── features/             # Feature Modules
│   ├── goal_management/
│   ├── task_management/
│   ├── template_gallery/
│   ├── notifications/
│   ├── gamification/
│   └── hobbies_habits/
└── app.dart              # App entry point
```

## Architectural Principles

| Principle | Implementation |
|-----------|----------------|
| **Feature-First** | Each feature is a self-contained module |
| **Separation of Concerns** | Data, Domain, Presentation layers |
| **Reactive State** | flutter_bloc for state management |
| **Offline-First** | Drift SQLite + local-first architecture |
| **Dependency Injection** | GetIt for service location |
| **Type Safety** | Strong typing, sealed classes, nullable types |

---

## Core Layer

### Data Layer (`core/data/`)

```
core/data/
├── database/           # Drift SQLite database
│   ├── tables.dart     # Table definitions
│   ├── database.dart   # Database class + migrations
│   └── database.g.dart # Generated
├── models/             # Domain models with JSON serialization
│   ├── goal_model.dart
│   ├── task_model.dart
│   ├── hobby_model.dart
│   └── ...
├── data_access_object/ # Data Access Objects (DAOs)
│   ├── goal_dao.dart
│   ├── task_dao.dart
│   ├── hobby_dao.dart
│   └── ...
└── bloc/               # BLoCs for state management
    ├── goal_bloc/
    ├── task_bloc/
    ├── template_bloc/
    └── ...
```

**Key Technologies:**
- **Drift** - Type-safe SQL database
- **flutter_bloc** - Predictable state management
- **GetIt** - Service locator for DI
- **Equatable** - Value equality for states/events

### Database (Drift)

```dart
// Schema version: 8
// Tables: Goals, Tasks, Tags, TaskTags, UserSettings, Templates,
//         NotificationPrefs, GoalNotificationOverride, UserStats,
//         Hobbies, HobbySessions

@DriftDatabase(
  tables: [Goals, Tasks, Tags, TaskTags, UserSettings, Templates,
           NotificationPrefs, GoalNotificationOverride, UserStats,
           Hobbies, HobbySessions],
  daos: [GoalDao, TaskDao, ...],
)
class AppDatabase extends _$AppDatabase { ... }
```

---

### Models

Models follow a consistent pattern:
- Immutable with `copyWith()`
- JSON serialization (`toJson()`, `fromJson()`)
- Drift entity conversion (`toEntity()`, `fromEntity()`)
- Drift Companion for insert/update (`toInsertCompanion()`, `toUpdateCompanion()`)

```dart
class HobbyModel {
  final int id;
  final String name;
  final String? description;
  // ...

  HobbyModel copyWith({...});
  Map<String, dynamic> toJson();
  static HobbyModel fromJson(Map<String, dynamic> json);
  factory HobbyModel.fromEntity(Hobby entity);
  Hobby toEntity();
  HobbiesCompanion toInsertCompanion();
  HobbiesCompanion toUpdateCompanion();
}
```

---

### DAOs

DAOs provide type-safe database access:
- `watchX()` - Reactive streams
- `getX()` - One-time reads
- `insertX()`, `updateX()`, `deleteX()` - Mutations

```dart
@DriftAccessor(tables: [Hobbies])
class HobbiesDao extends DatabaseAccessor<AppDatabase> with _$HobbiesDaoMixin {
  Stream<List<HobbyModel>> watchAllHobbies() { ... }
  Future<int> insertHobby(HobbyModel hobby) { ... }
  Future<bool> updateHobby(HobbyModel hobby) { ... }
}
```

---

### BLoCs

Feature BLoCs manage UI state:

```dart
class TemplateGalleryBloc extends Bloc<TemplateGalleryEvent, TemplateGalleryState> {
  final TemplateBloc _templateBloc;

  TemplateGalleryBloc({required TemplateBloc templateBloc}) : ... {
    on<LoadTemplates>(_onLoadTemplates);
    on<FilterByCategory>(_onFilterByCategory);
    on<SearchTemplates>(_onSearchTemplates);
    // ...
  }
}
```

---

## Feature Layer (`features/`)

Each feature is self-contained:

```
features/
├── goal_management/
│   ├── data/              # Feature-specific data
│   ├── domain/            # Business logic
│   └── presentation/      # UI
│       ├── pages/
│       └── widgets/
├── template_gallery/
│   ├── presentation/
│   │   ├── pages/
│   │   ├── widgets/
│   │   └── bloc/
```

**Feature Module Structure:**
```
feature_name/
├── data/                  # Repositories, data sources
├── domain/                # Entities, use cases, repositories interfaces
└── presentation/          # UI
    ├── bloc/              # BLoCs
    ├── pages/             # Screens
    └── widgets/           # Reusable widgets
```

---

## Design System (`core/design/`)

```
core/design/
├── tokens/           # Design tokens (colors, spacing, typography, motion)
├── primitives/       # Atomic components (Button, Card, TextField, etc.)
├── composites/       # Composite components (GoalCard, TaskTile, etc.)
├── layouts/          # Layout primitives (PlScaffold, PlPageTemplate)
├── motion/           # Animations (PlPageTransition, PlReorderable)
└── theme/            # Theme controller, Material 3 themes
```

### Design Tokens

```dart
// Colors - 8 unlockable palettes + light/dark
class PlColors { ... }

// Spacing - Consistent spacing scale
class PlSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  // ...
}

// Typography - Material 3 text styles
class PlTypography {
  static const TextStyle headlineLarge = ...;
  static const TextStyle bodyMedium = ...;
  // ...
}
```

---

## Feature Communication

### Cross-Feature Communication
- **Core BLoCs** registered in `app.dart` via `MultiBlocProvider`
- Features access core BLoCs via `context.read<T>()`
- Features communicate via events on core BLoCs

```dart
// In app.dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => GoalBloc()..add(StartWatchingGoalsEvent())),
    BlocProvider(create: (_) => TaskBloc()..add(StartWatchingTasksEvent())),
    BlocProvider(create: (_) => TemplateBloc(...)..add(LoadTemplates())),
    // ...
  ],
  child: ...
)
```

---

## Data Flow

```
User Action
    ↓
UI Widget dispatches BLoC Event
    ↓
BLoC processes event
    ↓
BLoC calls DAO / Service
    ↓
Database / Service returns data
    ↓
BLoC emits new State
    ↓
UI rebuilds with new State
```

---

## Navigation

```dart
// Route definitions in app.dart or feature routing
GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, _) => const HomePage()),
    GoRoute(path: '/goals', builder: (_, _) => const GoalsPage()),
    GoRoute(path: '/templates', builder: (_, _) => const TemplateGalleryPage()),
    // ...
  ],
)
```

---

## Error Handling

```dart
// Result pattern for operations
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> { final T data; }
class Failure extends Result { final String message; }

// Usage in DAOs
Future<Result<HobbyModel>> getHobbyById(int id) async {
  try {
    final hobby = await dao.getById(id);
    return Success(hobby);
  } catch (e) {
    return Failure('Failed to load hobby: $e');
  }
}
```

---

## Testing Strategy

| Layer | Approach |
|-------|----------|
| **Unit** | BLoC logic, DAOs, Models |
| **Widget** | Component rendering, interactions |
| **Integration** | Critical user flows |

```bash
# Run tests
flutter test test/unit/
flutter test test/widget/
flutter test integration_test/
```

---

## Build & Release

```bash
# Debug
flutter build apk --debug

# Release
flutter build apk --release
flutter build appbundle --release

# Version
# Update pubspec.yaml version: 1.0.0+1
```