# AI Agent Guide — Planza

This document tells an AI coding agent everything it needs to work effectively on this codebase. Read this first, then the feature docs and reference docs as needed.

## Project Overview

**Planza** is a Flutter/Dart personal productivity app. Offline-first with Drift (SQLite). State managed with flutter_bloc + GetIt. Dual calendar (Gregorian + Jalali). Custom design system (Planza tokens/primitives/composites). Feature-first modular architecture under `lib/features/`.

- **Repo**: github.com/Amir-Hzz79/planza
- **Branch**: work on `feature/*` branches from `dev`; PR to `dev`
- **Current phase**: Phase 4 (Hobbies & Habits) complete; Phase 5 (Auth & Workspaces) next

## Quick Start for an Agent

1. Read this file (AGENTS.md) + docs/README.md for the map
2. Read docs/PLAN.md for vision + phase checklist
3. Read docs/ROADMAP.md for phase status
4. Read the relevant feature doc under docs/features/ for the feature you're touching
5. Read docs/ARCHITECTURE.md + docs/STATE_MANAGEMENT.md for patterns
6. Use docs/DEVELOPMENT.md for commands

## How to Use These Docs

This folder is the single source of truth for the project. Read it in this order:

### 1. Orientation (read once per session)
- **docs/AGENTS.md** (this file) — conventions, gotchas, codebase map, workflow. Read first.
- **docs/README.md** — index of all docs with one-line descriptions. Use it to find the right doc.
- **docs/PLAN.md** — vision, the master phase checklist (what exists vs. what's planned), git flow.
- **docs/ROADMAP.md** — phase-by-phase status table. Tells you what's done and what's next.

→ After these four, you know what the project is, what's built, and what remains.

### 2. Working on a feature
- **docs/features/<feature>.md** — one doc per feature. Tells you: what the feature does, its key files, BLoCs/events/states, data models, navigation paths, integration points. Read this before touching the feature's code.
- Feature docs available: GOALS_TASKS, TEMPLATES, NOTIFICATIONS, GAMIFICATION, HOBBIES_HABITS, HOME.

### 3. Working on infrastructure / patterns
- **docs/ARCHITECTURE.md** — how the code is structured (data layer, BLoCs, design system, navigation, error handling). Read when creating new BLoCs, DAOs, or features.
- **docs/STATE_MANAGEMENT.md** — BLoC pattern details: event/state shapes, registration in app.dart, optimistic updates, stream cleanup, testing. Read when writing BLoC code.
- **docs/DATABASE.md** — full schema for every table, migration history, Drift usage, model/DAO patterns. Read when changing the database.
- **docs/DESIGN_SYSTEM.md** — tokens, primitives, composites, layouts, theme controller, unlockable palettes, RTL. Read when building UI.

### 4. Doing operations
- **docs/DEVELOPMENT.md** — all commands: setup, build, test, analyze, codegen, IDE setup, common issues. Run `flutter analyze` after every change; 0 errors required.

### 5. Historical context
- **docs/CHANGELOG.md** — version history in Keep a Changelog format. Read when you need to know what changed in a past release.

### Doc map by task

| If you need to... | Read this |
|---|---|
| Understand the whole project | AGENTS.md → README.md → PLAN.md → ROADMAP.md |
| Add a new feature | ARCHITECTURE.md (structure) + STATE_MANAGEMENT.md (BLoC) + the nearest feature doc for patterns |
| Add a screen/page | The relevant `docs/features/<name>.md` + ARCHITECTURE.md navigation section |
| Add a BLoC | STATE_MANAGEMENT.md + ARCHITECTURE.md data layer + an existing feature's BLoC files |
| Change the database | DATABASE.md (schema) + an existing *Dao file for patterns |
| Build UI | DESIGN_SYSTEM.md (tokens/components) + the feature doc for existing widget patterns |
| Fix a bug | AGENTS.md gotchas section + the relevant feature doc + STATE_MANAGEMENT.md (BLoC flow) |
| Run commands | DEVELOPMENT.md |
| Know what's done vs planned | PLAN.md (checklist) + ROADMAP.md (status table) |
| Write a commit message | PLAN.md#commit-message-convention |
| Submit a PR | PLAN.md#git-flow |

### Conventions (summary)
- **One doc per feature** under `docs/features/`. If you create a new feature, add its doc here.
- **Reference docs** (ARCHITECTURE.md, DATABASE.md, etc.) cover cross-cutting concerns — they apply to all features.
- **Don't duplicate** — if content belongs in a feature doc, don't repeat it in a reference doc. Reference docs explain patterns; feature docs show concrete instances.
- **Keep docs current** — if you change a BLoC, update its feature doc and STATE_MANAGEMENT.md if the pattern changed.

## Codebase Map (abbreviated)

```
lib/
├── app.dart                 # Entry: MultiBlocProvider (all BLoCs), MaterialApp, theme+locale builders
├── root_page.dart           # 5-page IndexedStack + CurvedNavigationBar (home, tasks, goals, hobbies, profile)
├── main.dart                # Entry point
├── core/
│   ├── data/               # Database (Drift), models, DAOs, core BLoCs
│   │   ├── database/
│   │   │   ├── tables.dart         # Drift table definitions (Goals, Tasks, Tags, Templates, Hobbies, ...)
│   │   │   ├── database.dart       # AppDatabase class + MigrationStrategy
│   │   │   └── database.g.dart     # Generated
│   │   ├── models/            # GoalModel, TaskModel, TemplateModel, HobbyModel, UserStatsModel, ...
│   │   ├── data_access_object/ # *Dao files — CRUD + watch streams
│   │   └── bloc/              # GoalBloc, TaskBloc, TagBloc, TemplateBloc, UserStatsBloc
│   ├── design/              # Design system: tokens, primitives, composites, layouts, motion, theme
│   ├── calendar/            # CalendarSystem, GregorianCalendar, JalaliCalendar, CalendarService
│   ├── locale/              # ARB localization (en/fa), LocaleBloc
│   ├── theme/               # ThemeBloc, light/dark themes, palette handling
│   ├── services/            # CelebrationService, NotificationService, CustomSharedPreferences, AppPaths
│   └── utils/               # RecurrenceEngine, HobbyStats, extensions
├── features/               # Feature modules (presentation only; data is in core/)
│   ├── home/                # Dashboard (goals carousel, metrics, charts, FAB, drawer)
│   ├── task_managment/      # Tasks: list, detail, calendar view, filters, entry sheet
│   ├── goal_managment/      # Goals: tree, detail, entry, achievement, metric cards
│   ├── template_gallery/    # Template gallery UI (wraps core TemplateBloc)
│   ├── notifications/       # Notification settings UI (wraps NotificationService + UserSettingsDao)
│   ├── gamification/        # Profile page, XP level card, stats grid, unlockables
│   └── hobbies_habits/      # Hobbies: list, detail, create/edit, cards, session cards, bloc
└── features/ (shared)      # (none — all shared code is in core/)
```

## Architecture Rules

- **Feature-first**: each feature under `lib/features/<name>/presentation/` has pages + widgets + (optionally) bloc
- **Data in core/**: models, DAOs, and core BLoCs live in `lib/core/data/` — features consume them, they don't own data
- **BLoC pattern**: every feature uses flutter_bloc. Events are `part of` the bloc file. States are sealed/classed. Optimistic updates are common.
- **Watch streams**: DAOs expose `watchX()` streams; BLoCs subscribe and emit state changes. Always cancel subscriptions in `close()`.
- **GetIt**: service locator. DAOs registered in app.dart (`_registerDependencies()`). BLoCs get DAOs via `GetIt.instance.get<Dao>()`.
- **Drift codegen**: after editing `tables.dart` or models with `@JsonSerializable`, run `dart run build_runner build --delete-conflicting-outputs`. Generated files: `*.g.dart`.

## Conventions

- **Naming**: feature folders use singular or plural as established (home, task_managment, goal_managment, template_gallery, notifications, gamification, hobbies_habits). Note: "task_managment" is intentionally misspelled (not "management").
- **Booleans**: isActive (not active), notificationsEnabled, quietHoursEnabled, snoozeEnabled
- **Mood scale**: 1-5 integers (1=terrible, 5=great)
- **Frequency**: 'daily', 'weekly', 'custom' (strings, not enums in the model)
- **Colors**: stored as int (Color.value), converted via `Color(intValue)`
- **Icons**: stored as int (IconData.codePoint), converted via `IconData(intValue)`
- **Dates**: DateTime throughout; dual calendar via CalendarService for formatting

## Design System

- Tokens in `lib/core/design/tokens/`: spacing.dart (PlSpacing), colors.dart, typography.dart, border_radius, motion, elevation
- Primitives in `lib/core/design/primitives/`: PlButton, PlCard, PlTextField, PlChip, PlAvatar, PlDialog, PlBottomSheet, PlAppBar, PlFAB, PlDivider, PlTooltip
- Composites in `lib/core/design/composites/`: GoalCard, TaskTile, TagChip, ProgressRing, StreakCounter, DateChip, EmptyState, LoadingShimmer
- Use PlSpacing for padding/sizing (e.g., PlSpacing.md = 16). Don't hardcode dp values.
- PlCard is the standard card wrapper. PlButton for buttons. PlTextField for text input.

## Common Gotchas

- **PlSpacing.radiusX is a Radius, not a double** — use `PlSpacing.borderRadiusX` (BorderRadius) with BorderRadius.circular(), or use `PlSpacing.topRadiusX` for top-only. Don't do `BorderRadius.circular(PlSpacing.radiusLg)`.
- **BorderRadius vs Radius**: `BoxDecoration.borderRadius` takes a BorderRadius. Use the BorderRadius tokens, not the Radius tokens.
- **TabController**: length must match the number of tabs in TabBar. If you change tabs, update both. (A past bug: 5 filter tabs but length=2 → crash.)
- **GridView inside Column**: needs `shrinkWrap: true` + `NeverScrollableScrollPhysics()` or it throws unbounded height.
- **LinearProgressIndicator + ClipRRect + borderRadiusFull**: wrap in SizedBox with fixed height to avoid sub-pixel overflow.
- **Type collisions**: when a model field is `int?` but you need Color/IconData, cast explicitly: `hobby.color != null ? Color(hobby.color!) : colorScheme.primary`.
- **Generated files**: `*.g.dart` files are gitignored-ish but tracked. Don't edit them by hand. Regenerate after schema/model changes.
- **MethodChannel deps**: CustomSharedPreferences and AppPaths are custom implementations replacing shared_preferences and path_provider. Use them, not the original plugins.
- **flutter_local_notifications**: replaced with a custom NotificationService abstraction. The feature UI talks to NotificationSettingsBloc which talks to NotificationService.

## Workflow for an Agent

1. Create branch: `git checkout dev && git pull origin dev && git checkout -b feature/<name>`
2. Make changes. Run `flutter analyze` frequently — 0 errors required.
3. After model/DAO/table changes: `dart run build_runner build --delete-conflicting-outputs`
4. Commit atomically: `git commit -m "feat(scope): description"` (types: feat, fix, refactor, docs, chore)
5. Push: `git push origin feature/<name>`
6. Create PR to `dev` (self-review, verify analyze clean, manual test on emulator)

## Reference Docs

| Doc | Purpose |
|-----|---------|
| docs/PLAN.md | Vision, phase checklist (master plan), git flow |
| docs/ROADMAP.md | Phase status table + per-phase summaries |
| docs/DEVELOPMENT.md | All commands: setup, build, test, analyze, codegen, IDE setup |
| docs/ARCHITECTURE.md | Architecture deep-dive: data layer, BLoCs, design system, navigation, error handling |
| docs/STATE_MANAGEMENT.md | BLoC pattern details: events/states, registration, optimistic updates, stream cleanup |
| docs/DATABASE.md | Full schema (all tables), migrations, Drift usage, models, DAOs |
| docs/DESIGN_SYSTEM.md | Tokens, primitives, composites, layouts, theme controller, unlockable palettes, RTL |
| docs/AGENTS.md | This file — agent onboarding and conventions |
| docs/CHANGELOG.md | Version history (Keep a Changelog format) |
| docs/AGENTS.md | This file — agent onboarding and conventions |
| docs/features/GOALS_TASKS.md | Goals & Tasks feature |
| docs/features/TEMPLATES.md | Templates system (core + gallery) |
| docs/features/NOTIFICATIONS.md | Notification settings feature |
| docs/features/GAMIFICATION.md | XP/levels/streaks/unlockables |
| docs/features/HOBBIES_HABITS.md | Hobbies & Habits feature |
| docs/features/HOME.md | Home dashboard |
