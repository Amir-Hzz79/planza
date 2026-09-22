# Planza Documentation

Welcome to the Planza documentation. This folder contains all project documentation organized by topic.

## Quick Navigation

|| Document | Description |
|----------|-------------|
||| [AGENTS.md](AGENTS.md) | AI agent onboarding: conventions, patterns, gotchas, workflow **(read first)** |
||| [ROADMAP.md](ROADMAP.md) | High-level project roadmap and phases |
|| [PLAN.md](PLAN.md) | Full development plan: vision, phases, git flow |
|| [DEVELOPMENT.md](DEVELOPMENT.md) | Development setup, commands, build, test |
|| [CHANGELOG.md](CHANGELOG.md) | Version history and release notes |
|| [ARCHITECTURE.md](ARCHITECTURE.md) | System architecture overview |
|| [DATABASE.md](DATABASE.md) | Database schema, migrations, Drift usage |
|| [STATE_MANAGEMENT.md](STATE_MANAGEMENT.md) | BLoC patterns, state flow |
|| [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md) | Design tokens, primitives, components |
|| [HOBBIES_HABITS.md](HOBBIES_HABITS.md) | Hobbies & Habits feature docs |

## Feature Documentation

| Feature | Documentation |
|---------|---------------|
| Goals & Tasks | [features/GOALS_TASKS.md](features/GOALS_TASKS.md) |
| Templates | [features/TEMPLATES.md](features/TEMPLATES.md) |
| Notifications | [features/NOTIFICATIONS.md](features/NOTIFICATIONS.md) |
| Gamification | [features/GAMIFICATION.md](features/GAMIFICATION.md) |
| Hobbies & Habits | [features/HOBBIES_HABITS.md](features/HOBBIES_HABITS.md) |
| Home Dashboard | [features/HOME.md](features/HOME.md) |

## Technical Documentation

| Topic | Documentation |
|-------|---------------|
|| Architecture Overview | [ARCHITECTURE.md](ARCHITECTURE.md) |
|| Database Schema | [DATABASE.md](DATABASE.md) |
|| State Management | [STATE_MANAGEMENT.md](STATE_MANAGEMENT.md) |
|| Design System | [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md) |
| Database Migrations | [DATABASE.md#migrations](DATABASE.md#migrations) |
| Git Workflow | [PLAN.md#git-flow](PLAN.md#git-flow) |
| AI Agent Onboarding | [AGENTS.md](AGENTS.md) |

## Project Overview

Planza is a collaborative productivity platform built with Flutter. It transforms personal goal management into a social, template-driven ecosystem.

### Tech Stack
- **Framework**: Flutter 3.29+ / Dart 3.7+
- **State Management**: flutter_bloc
- **Database**: Drift (SQLite)
- **Localization**: ARB files (EN/FA)
- **Calendar**: Dual Gregorian/Jalali support
- **Notifications**: flutter_local_notifications

### Project Structure
```
lib/
├── core/                 # Core shared functionality
│   ├── data/             # Database, models, DAOs, BLoCs
│   ├── design/           # Design system (tokens, primitives, composites)
│   ├── calendar/         # Dual calendar system
│   ├── locale/           # Localization (EN/FA)
│   ├── theme/            # Theming
│   └── services/         # Platform services
├── features/
│   ├── goal_management/
│   ├── task_management/
│   ├── template_gallery/
│   ├── notifications/
│   ├── gamification/
│   └── hobbies_habits/
└── features/
```

## Getting Started

See [DEVELOPMENT.md](DEVELOPMENT.md) for setup, build, and test commands.