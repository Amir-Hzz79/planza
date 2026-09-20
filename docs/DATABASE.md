# Database Documentation

## Overview

Planza uses **Drift** (type-safe SQL) with **SQLite** for local-first data persistence.

## Schema Overview

**Current Version: 8**

| Table | Purpose |
|-------|---------|
| `Goals` | Hierarchical goals with tasks |
| `Tasks` | Tasks with due dates, priorities |
| `Subtasks` | Subtask breakdown |
| `Tags` | Tag categorization |
| `TaskTags` | Many-to-many Tasks ↔ Tags |
| `UserSettings` | App preferences |
| `Templates` | Template definitions (JSON) |
| `NotificationPrefs` | Global notification settings |
| `GoalNotificationOverride` | Per-goal notification overrides |
| `UserStats` | Gamification stats (XP, level, streaks) |
| `Hobbies` | Hobbies/habits with recurrence |
| `HobbySessions` | Session tracking with mood |

---

## Schema Diagram

```
Goals ──────< Tasks >────── Subtasks
  │              │
  │              └──< TaskTags >── Tags
  │
  └──< GoalNotificationOverride

Hobbies ───< HobbySessions
  │
  └──< Goals (optional link via goalId)
```

---

## Table Definitions

### Goals
```sql
CREATE TABLE Goals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  deadline DATETIME,
  color INTEGER NOT NULL,
  icon INTEGER NOT NULL,
  parentGoalId INTEGER REFERENCES Goals(id)
);
```

### Tasks
```sql
CREATE TABLE Tasks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT,
  dueDate DATETIME,
  doneDate DATETIME,
  priority INTEGER,
  goalId INTEGER REFERENCES Goals(id),
  parentTaskId INTEGER REFERENCES Tasks(id)
);
```

### Templates
```sql
CREATE TABLE Templates (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  icon INTEGER,
  color INTEGER,
  payloadJson TEXT NOT NULL,  -- JSON: Goal + Tasks + Tags
  isBuiltin BOOLEAN DEFAULT 0,
  createdAt DATETIME NOT NULL,
  updatedAt DATETIME
);
```

### Hobbies
```sql
CREATE TABLE Hobbies (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  category TEXT NOT NULL,
  icon INTEGER,
  color INTEGER,
  frequency TEXT DEFAULT 'daily',  -- 'daily', 'weekly', 'custom'
  customFrequencyJson TEXT,         -- JSON for custom recurrence
  targetDurationMinutes INTEGER,    -- Target session duration
  goalId INTEGER REFERENCES Goals(id),
  isActive BOOLEAN DEFAULT 1,
  createdAt DATETIME NOT NULL,
  updatedAt DATETIME
);
```

### HobbySessions
```sql
CREATE TABLE HobbySessions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  hobbyId INTEGER NOT NULL REFERENCES Hobbies(id),
  startTime DATETIME NOT NULL,
  endTime DATETIME,
  durationMinutes INTEGER,
  mood INTEGER,              -- 1-5 scale
  notes TEXT,
  createdAt DATETIME NOT NULL
);
```

---

## Models & Serialization

Each table has a corresponding Dart model:

| Table | Model | DAO |
|-------|-------|-----|
| Goals | `GoalModel` | `GoalDao` |
| Tasks | `TaskModel` | `TaskDao` |
| Templates | `TemplateModel` | `TemplateDao` |
| Hobbies | `HobbyModel` | `HobbiesDao` |
| HobbySessions | `HobbySessionModel` | `HobbySessionsDao` |
| Tags | `TagModel` | `TagDao` |
| UserStats | `UserStatsModel` | `UserStatsDao` |

### Model Pattern

```dart
class HobbyModel {
  final int id;
  final String name;
  final String? description;
  final String category;
  final int? icon;
  final int? color;
  final String frequency;
  final String? customFrequencyJson;
  final int? targetDurationMinutes;
  final int? goalId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  // Serialization
  Map<String, dynamic> toJson();
  static HobbyModel fromJson(Map<String, dynamic> json);

  // Drift conversion
  factory HobbyModel.fromEntity(Hobby entity);
  Hobby toEntity();
  HobbiesCompanion toInsertCompanion();
  HobbiesCompanion toUpdateCompanion();
}
```

---

## Migrations

### Migration Strategy
```dart
@override
MigrationStrategy get migration => MigrationStrategy(
  onUpgrade: (migrator, from, to) async {
    if (from < 2) { await migrator.addColumn(goals, colorColumn); }
    else if (from < 3) { await migrator.addColumn(goals, iconColumn); }
    else if (from < 4) { await migrator.addColumn(goals, parentGoalIdColumn); }
    else if (from < 5) { await migrator.createTable(templates); }
    else if (from < 6) { await migrator.createTable(notificationPrefs); ... }
    else if (from < 7) { await migrator.createTable(userStats); }
    else if (from < 8) { await migrator.createTable(hobbies); ... }
  },
);
```

### Schema Versions

| Version | Changes |
|---------|---------|
| 1 | Initial: Goals, Tasks, Tags, UserSettings |
| 2 | Added `color` to Goals |
| 3 | Added `icon` to Goals |
| 4 | Added `parentGoalId` to Goals (hierarchy) |
| 5 | Created `Templates` table |
| 6 | Created `NotificationPrefs`, `GoalNotificationOverride` |
| 7 | Created `UserStats` (gamification) |
| 8 | Created `Hobbies`, `HobbySessions` |

### Migration Commands

```bash
# After schema changes
dart run build_runner build --delete-conflicting-outputs

# Test migration locally
flutter run --debug
# Check: flutter logs
```

---

## Database Access

### DAO Pattern

```dart
@DriftAccessor(tables: [Goals, Tasks])
class GoalDao extends DatabaseAccessor<AppDatabase> with _$GoalDaoMixin {
  GoalDao(super.attachedDatabase);

  Stream<List<GoalModel>> watchAllGoalsWithTasks() {
    return select(goals).watch().map((rows) => ...);
  }

  Future<int> insertGoalWithTasks(GoalModel goal) async {
    return transaction(() async {
      await into(goals).insert(goal.toInsertCompanion());
      for (final task in goal.tasks) {
        await into(tasks).insert(task.toInsertCompanion());
      }
    });
  }
}
```

---

## Database Operations

### Initialize
```dart
final db = AppDatabase();
await db.insertEnDummyData();  // Development only
```

### Reset (Dev)
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --debug
```

### Backup/Restore
```dart
// Export
final db = AppDatabase();
final backup = await db.export();

// Restore
await db.import(backup);
```

---

## Drift Commands

```bash
# Generate code
dart run build_runner build --delete-conflicting-outputs

# Watch mode
dart run build_runner watch --delete-conflicting-outputs

# Clean
flutter clean
rm -rf lib/core/data/database/*.g.dart
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

## Database Inspection

```bash
# Connect to device
adb shell
run-as com.amirhosseinzamani.planza
sqlite3 databases/planza_db.sqlite

-- List tables
.tables

-- Show schema
.schema goals

-- Query data
SELECT * FROM goals;
SELECT * FROM tasks WHERE goalId = 1;

-- JSON payload
SELECT payloadJson FROM templates;
```

---

## Common Queries

```sql
-- Goals with task count
SELECT g.*, COUNT(t.id) as task_count
FROM goals g
LEFT JOIN tasks t ON t.goalId = g.id
GROUP BY g.id;

-- Active hobbies with session count
SELECT h.*, COUNT(s.id) as session_count
FROM hobbies h
LEFT JOIN hobby_sessions s ON s.hobbyId = h.id
WHERE h.isActive = 1
GROUP BY h.id;

-- Weekly hobby time
SELECT h.name, SUM(s.durationMinutes) as total_minutes
FROM hobbies h
JOIN hobby_sessions s ON s.hobbyId = h.id
WHERE s.startTime >= date('now', '-7 days')
GROUP BY h.id;

-- Streak calculation
SELECT h.name, h.currentStreak, h.longestStreak
FROM user_stats u
JOIN hobbies h ON h.id = u.hobbyId
WHERE u.currentStreak > 0;
```

---

## Performance

### Indexes
```sql
-- Auto-created by Drift for FKs
-- Add custom indexes for common queries:
CREATE INDEX idx_tasks_goal_due ON tasks(goalId, dueDate);
CREATE INDEX idx_sessions_hobby_start ON hobby_sessions(hobbyId, startTime);
CREATE INDEX idx_tasks_due ON tasks(dueDate) WHERE doneDate IS NULL;
```

---

## Backup Strategy

```dart
// Export to JSON
Future<String> exportDatabase() async {
  final db = AppDatabase();
  final goals = await db.goalDao.getAllGoals();
  final tasks = await db.taskDao.getAllTasks();
  // ... serialize to JSON
  return jsonEncode({'goals': goals, 'tasks': tasks, ...});
}

// Import
Future<void> importDatabase(String json) async {
  final data = jsonDecode(json);
  await db.transaction(() async {
    await db.goalDao.deleteAll();
    for (final g in data['goals']) {
      await db.goalDao.insertGoal(GoalModel.fromJson(g));
    }
    // ...
  });
}
```