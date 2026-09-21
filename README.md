Planza - Task Management & Goal Planner App
=======================================

Planza is a task management app built with Flutter, designed to help users stay organized and achieve their goals effectively. With features like task creation, goal setting, template galleries, hobbies & habits tracking, gamification, smart notifications, and calendar integration, Planza offers a flexible and intuitive approach to managing daily activities.

## 📸 App Screenshots

| Home Screen | Goals Screen | Tasks Screen |
| :---: | :---: | :---: |
| <img src="https://github.com/Amir-Hzz79/planza/blob/release/screenshots/HomeScreen.jpg?raw=true" width="250"> | <img src="https://github.com/Amir-Hzz79/planza/blob/release/screenshots/GoalsScreen.jpg?raw=true" width="250"> | <img src="https://github.com/Amir-Hzz79/planza/blob/release/screenshots/TasksScreen.jpg?raw=true" width="250"> |

| Calendar View | Goal Details | Task Entry |
| :---: | :---: | :---: |
| <img src="https://github.com/Amir-Hzz79/planza/blob/release/screenshots/Calendar.jpg?raw=true" width="250"> | <img src="https://github.com/Amir-Hzz79/planza/blob/release/screenshots/GoalDetails.jpg?raw=true" width="250"> | <img src="https://github.com/Amir-Hzz79/planza/blob/release/screenshots/TaskEntry.jpg?raw=true" width="250"> |

| Goal Entry | Achievement |
| :---: | :---: |
| <img src="https://github.com/Amir-Hzz79/planza/blob/release/screenshots/GoalEntry.jpg?raw=true" width="250"> | <img src="https://github.com/Amir-Hzz79/planza/blob/release/screenshots/Achievement.jpg?raw=true" width="250"> |

## ✨ Features

**Task Management:** Create, edit, complete, and delete tasks with due dates, reminders, and prioritization.

**Goal Setting:** Define long-term goals and break them into smaller, manageable tasks with hierarchical parent/child relationships.

**Template Gallery:** Discover, create, and share productivity templates across categories (Habit, Project, Learning, Fitness, Custom). Import/export templates as JSON.

**Hobbies & Habits:** Track recurring activities with session timer, mood tracking (1-5 scale), streaks, and insights statistics. Supports daily, weekly, and custom recurrence patterns.

**Gamification:** XP/level system with streak counters, celebration animations, and unlockable themes/icons/animations.

**Smart Notifications:** Task reminders with timezone support, rich actions (Complete, Snooze), quiet hours, working days, and per-goal overrides.

**Calendar Integration:** Dual calendar (Gregorian + Jalali) with schedule visualization.

**Theme Support:** Light/dark/system themes plus 8 unlockable color palettes.

**Localization:** Multi-language support (English, Persian/Farsi) with RTL-aware layouts.

## 🛠️ Tech Stack & Tools

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** flutter_bloc (BLoC pattern)
- **Database:** Drift (SQLite) with offline-first architecture
- **Architecture:** Feature-first modular architecture, Clean Architecture principles
- **Dependency Injection:** GetIt
- **Notifications:** flutter_local_notifications
- **Calendars:** Dual Gregorian/Jalali calendar system
- **Design System:** Custom component library (Planza primitives & composites)

## 📁 Project Structure

```
lib/
├── core/                    # Core utilities, design system, data layer
│   ├── calendar/            # Dual calendar (Gregorian/Jalali)
│   ├── data/                # Drift database, DAOs, models
│   ├── design/              # Design system tokens, primitives, composites
│   ├── utils/               # Extensions, helpers (recurrence engine, stats)
│   └── services/            # Platform services
├── features/                # Feature modules
│   ├── goal_management/     # Goals & tasks
│   ├── task_management/     # Task operations
│   ├── template_gallery/    # Template discovery & management
│   ├── hobbies_habits/      # Hobbies & habits tracking (Phase 4)
│   ├── gamification/        # XP, streaks, unlockables
│   └── notifications/       # Smart notification settings
└── app.dart                 # App entry, providers, routing
```

## 📄 Documentation

- [PLAN.md](PLAN.md) — Full development plan with phases and implementation flow
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) — Architecture decisions & patterns
- [docs/DATABASE.md](docs/DATABASE.md) — Database schema & migrations
- [docs/HOBBIES_HABITS.md](docs/HOBBIES_HABITS.md) — Hobbies & Habits feature spec
- [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md) — Development practices & conventions

## 🚀 Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Run `dart run build_runner build --delete-conflicting-outputs` (generates Drift/JSON code)
4. Run `flutter run` to start the app

## 📝 Version

See `pubspec.yaml` for the current version.
