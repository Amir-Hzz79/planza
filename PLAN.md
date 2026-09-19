# Planza Development Plan

## Vision
**Planza** is a collaborative productivity platform that transforms personal goal management into a social, template-driven ecosystem. Users organize life through hierarchical goals and tasks, then amplify accountability by inviting others into purpose-built workspaces — family chore charts, classroom assignments, gym coaching, book clubs, project teams — each powered by role-aware templates that define permissions, notifications, and workflows.

## Core Principles
- **Design System First** — Unified component library, theming, spacing, motion tokens
- **Cloud-Ready from Day 1** — Offline-first architecture, sync engine, conflict resolution
- **AI-Ready Abstraction Layer** — Repository pattern + command bus for future AI integration
- **Dual Calendar Native** — Abstract calendar service with Gregorian/Jalali implementations
- **Localization Complete** — All user-facing strings in ARB; RTL-aware layouts

---

## Phase 0: Foundation & Design System ✅ COMPLETED

### 0.1 Design System Tokens & Primitives
- [x] Colors (light/dark + 8 unlockable palettes)
- [x] Spacing, Typography, Border Radius, Elevation, Motion
- [x] Primitive widgets: PlButton, PlCard, PlTextField, PlChip, PlAvatar, PlDialog, PlBottomSheet, PlAppBar, PlFAB, PlDivider, PlTooltip
- [x] Composite widgets: GoalCard, TaskTile, TagChip, PriorityBadge, ProgressRing, StreakCounter, DateChip, EmptyState, LoadingShimmer
- [x] Layout primitives: PlScaffold, PlPageTemplate, PlListView, PlGridView, PlSliverAppBar, PlPageTemplate
- [x] Motion system: PlPageTransition, PlReorderable
- [x] Theme controller: dynamic Material 3, unlockable themes, RTL support

### 0.2 Dual Calendar Abstraction
- [x] CalendarSystem abstract class
- [x] GregorianCalendar implementation
- [x] JalaliCalendar implementation
- [x] CalendarService with primary/secondary calendar
- [x] Migrate all date formatting to CalendarService
- [x] User preference for calendar type

### 0.3 Database Migrations (Drift)
- [x] Add parent_goal_id to Goals table
- [x] Create Templates table
- [x] Create UserStats table (XP, level, streaks, unlockables)
- [ ] Create SyncMetadata table
- [ ] Create Hobbies + HobbySessions tables
- [ ] Add workspace_id to all entity tables (nullable)
- [ ] Generate migration scripts, test on existing data

### 0.4 Feature Flag / Entitlement System
- [ ] FeatureFlag enum
- [ ] EntitlementService with local cache
- [ ] GatedWidget component
- [ ] RevenueCatService stub
- [ ] Default free-tier entitlements

### 0.5 Notification Engine Foundation
- [ ] NotificationPrefs model
- [ ] LocalNotificationService
- [ ] Task/goal/streak/weekly review scheduling
- [ ] Rich notification actions (Complete, Snooze 10m/1h, Open)
- [ ] Settings UI (global + per-goal override)

### 0.6 Architecture & Tooling
- [ ] Strict lint rules (very_good_analysis)
- [ ] CI/CD config (analyze, test, build_runner)
- [ ] Architecture documentation
- [ ] Phase 0 completion checklist

---

## Phase 1: Goal Hierarchy & Templates
- [x] Parent goals, tree UI, drag-drop reorder
- [x] Template engine (JSON serialization)
- [ ] Import/export/share templates
- [ ] Template gallery with categories
- [x] Template engine (JSON serialization)

### Phase 1.4: Template Gallery UI (IN PROGRESS)
- [ ] TemplateGalleryPage with category tabs
- [ ] TemplateCard widget with preview
- [ ] Category tabs (Habit, Project, Learning, Fitness, Custom)
- [ ] Search and filter templates
- [ ] Create template from scratch button
- [ ] Template detail view
- [ ] "Use Template" action (creates goal + tasks)
- [ ] Category filtering and search
- [ ] Pull-to-refresh

### Phase 1.5: Import/Export/Share UI
- [ ] Export template as JSON file
- [ ] Import template from JSON file
- [ ] Share template via system share sheet
- [ ] QR code generation for template sharing
- [ ] Deep link handling for template import
- [x] Template engine (JSON serialization)

---

## Phase 2: Gamification Core
- [ ] XP/Level/Streak system
- [ ] Celebration animations (Lottie)
- [ ] Unlockables (themes, icons, animations)
- [ ] Profile page with stats

---

## Phase 3: Smart Notifications (IN PROGRESS)
- [x] Notification service with flutter_local_notifications
- [x] Notification channel creation
- [x] Task reminder scheduling with timezone support
- [x] Rich actions (Complete, Snooze 10m, Snooze 1h)
- [x] Notification channel with high priority
- [x] Presets (10m, 1h, 1d, custom) - UI
- [x] Quiet hours, working days - UI
- [x] Per-goal overrides - UI
- [x] Notification settings page
- [ ] Snooze presets editor with custom add/remove
- [ ] Quiet hours time picker
- [ ] Working days selector
- [ ] Test notification button

---

## Phase 4: Hobbies & Habits
- [ ] Recurring engine (daily/weekly/custom)
- [ ] Session tracking with mood
- [ ] Insights charts (time allocation, correlations)

---

## Phase 5: Auth & Workspaces (Social MVP)
- [ ] Email/Phone/OAuth + Anonymous guest
- [ ] Workspaces with roles (Owner, Admin, Member, Viewer)
- [ ] Shared goals/tasks with assignments
- [ ] Invitations via deep links

---

## Phase 6: Real-time Sync & Push
- [ ] Backend (Supabase recommended)
- [ ] Live updates, assign notifications
- [ ] Activity feed
- [ ] Background sync

---

## Phase 7: Template Marketplace
- [ ] Publish/discover/fork/rate templates
- [ ] Role-based templates
- [ ] Community gallery

---

## Phase 8: Social Layer
- [ ] Profiles, follow, groups
- [ ] Public achievements, leaderboards
- [ ] Social accountability features

---

## Phase 9: AI Integration
- [ ] Smart goal breakdown
- [ ] Weekly review generation
- [ ] Schedule optimizer
- [ ] Natural language input

---

## Phase 10: Polish & Launch
- [ ] Onboarding flow
- [ ] Home screen widgets
- [ ] Accessibility audit
- [ ] Store assets, landing page

---

## Implementation Flow & Procedures

### Development Workflow
1. **Start Task**: Create feature branch from `dev` → `git checkout -b feature/task-name`
2. **Implementation**: 
   - Follow existing code patterns and architecture
   - Write Dart code following project conventions
   - Add proper documentation/comments
   - Run `flutter analyze` after changes
2. **Testing**: 
   - Run `flutter analyze` - must pass with 0 errors
   - Run `flutter test` for unit/widget tests
   - Manual testing on Android emulator
   - Test on physical device if possible
3. **Code Generation**: Run `dart run build_runner build --delete-conflicting-outputs` for Drift/JSON serialization
4. **Commit**: Atomic commits with conventional messages
   - `feat: add template gallery UI`
   - `fix: fix template export JSON parsing`
   - `refactor: extract template gallery widget`
6. **Code Review**: Create PR to `dev` branch
   - Self-review first
   - Ensure `flutter analyze` passes (0 errors)
   - Ensure `flutter test` passes
   - Manual testing on Android emulator
7. **Merge**: PR approved → merge to `dev` → CI runs → merge to `stage` for QA

### Code Quality Standards
- **Analysis**: `flutter analyze` must show 0 errors (warnings OK)
- **Formatting**: `dart format .` before commit
- **Testing**: 
  - Unit tests for business logic
  - Widget tests for UI components
  - Integration tests for critical flows
- **Performance**: Profile with `flutter run --profile` for jank detection
- **Dependencies**: Keep `pubspec.yaml` clean, avoid unnecessary dependencies

### Build & Release Process
1. **Debug Build**: `flutter run --debug -d <device>`
2. **Profile Build**: `flutter run --profile -d <device>`
3. **Release Build**: `flutter build apk --release` / `flutter build ios --release`
4. **App Bundle**: `flutter build appbundle --release` for Play Store
5. **Versioning**: Update `pubspec.yaml` version (`major.minor.patch+build`)

---

## Testing Procedures

### Unit Tests
- **Location**: `test/unit/`
- **Framework**: `test` package + `bloc_test` for BLoC testing
- **Coverage**: Target 80%+ for business logic
- **Run**: `flutter test test/unit/`

### Widget Tests
- **Location**: `test/widget/`
- **Coverage**: Key UI components (TemplateCard, TemplateGalleryPage, etc.)
- **Run**: `flutter test test/widget/`

### Integration Tests
- **Location**: `integration_test/`
- **Framework**: `integration_test` package
- **Run**: `flutter test integration_test/`

### Manual Testing Checklist
- [ ] App launches without crashes
- [ ] Navigation works (bottom nav, drawers, nested routes)
- [ ] Theme switching (light/dark/system)
- [ ] Locale switching (en/fa)
- [ ] Calendar switching (Gregorian/Jalali)
- [ ] Goal CRUD operations
- [ ] Task CRUD operations
- [ ] Template CRUD operations
- [ ] Template import/export/share
- [ ] Theme switching (light/dark/unlockable)
- [ ] Calendar switching (Gregorian/Jalali)
- [ ] Notifications (local)

---

## Git Flow

### Branch Structure
```
master (production) ← stage (stable release) ← dev (integration) ← feature/* branches
```

### Branch Policies
| Branch | Purpose | Protection |
|--------|---------|------------|
| `master` | Production releases only | Protected, tag required |
| `stage` | Pre-release testing, QA | Protected, PR required |
| `dev` | Ongoing integration | Direct push allowed (or PR) |
| `feature/*` | Individual tasks | PR required to merge to `dev` |

### Branch Naming Convention
- `feature/<phase>.<task>` — e.g., `feature/1.4-template-gallery`
- `fix/<issue>` — Bug fixes
- `refactor/<area>` — Refactoring
- `chore/<task>` — Maintenance

### Workflow
```
1. git checkout dev && git pull origin dev
2. git checkout -b feature/<phase>.<task-name>
3. Implement feature (atomic commits)
4. Run: flutter analyze && flutter test && dart run build_runner build
5. git add . && git commit -m "feat: <description>"
6. git push origin feature/<branch>
7. Create PR: feature/* → dev (self-review + CI)
8. After review: merge to dev
9. Phase complete → PR: dev → stage (QA)
9. Stable → PR: stage → master (with tag)
```

### Commit Message Convention
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

Types: `feat`, `fix`, `refactor`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`

Examples:
- `feat(template): add template gallery UI with category tabs`
- `fix(template): fix export JSON parsing for nested objects`
- `refactor(template): extract TemplateCard widget`
- `docs(template): add README for template system`

---

## Project Structure

```
lib/
├── app.dart                      # App entry, BLoC providers, routing
├── main.dart                     # Entry point
├── root_page.dart                # Root navigation
├── core/
│   ├── calendar/                 # Dual calendar system
│   │   ├── calendar_service.dart
│   │   ├── calendar_system.dart
│   │   ├── gregorian_calendar.dart
│   │   └── jalali_calendar.dart
│   ├── data/
│   │   ├── database/
│   │   │   ├── database.dart
│   │   │   ├── database.g.dart
│   │   │   ├── tables.dart
│   │   │   └── migration/
│   │   ├── models/
│   │   │   ├── goal_model.dart
│   │   │   ├── task_model.dart
│   │   │   ├── tag_model.dart
│   │   │   └── template_model.dart
│   │   ├── data_access_object/
│   │   │   ├── goal_dao.dart
│   │   │   ├── task_dao.dart
│   │   │   ├── tag_dao.dart
│   │   │   ├── template_dao.dart
│   │   │   ├── user_setting_dao.dart
│   │   │   └── *.g.dart (generated)
│   │   └── bloc/
│   │       ├── goal_bloc/
│   │       ├── task_bloc/
│   │       ├── tag_bloc/
│   │       └── template_bloc/
│   ├── calendar/                 # Calendar widgets
│   ├── data/                     # Core data utilities
│   ├── design/                   # Design system
│   │   ├── tokens/               # Colors, spacing, typography, etc.
│   │   ├── primitives/           # Base widgets
│   │   ├── composites/           # Composite widgets
│   │   ├── layouts/              # Layout widgets
│   │   ├── motion/               # Animations
│   │   └── theme/                # Theme controller
│   ├── locale/                   # Localization (ARB)
│   ├── services/                 # Platform services
│   ├── theme/                    # App theming
│   ├── utils/                    # Extensions, utilities
│   └── widgets/                  # Shared widgets
├── features/
│   ├── goal_management/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── pages/
│   │       └── widgets/
│   ├── task_management/
│   ├── goal_management/
│   ├── template_gallery/
│   │   ├── presentation/
│   │   │   ├── pages/
│   │   │   ├── widgets/
│   │   │   └── bloc/
│   │   └── domain/
│   ├── task_management/
│   └── home/
├── app.dart
├── main.dart
└── root_page.dart
```

---

## Current Implementation Status

### ✅ Completed Components

#### Design System (Phase 0) ✅
- **Tokens**: Colors (8 palettes), Spacing, Typography, Border Radius, Motion, Elevation
- **Primitives**: PlButton, PlCard, PlTextField, PlChip, PlAvatar, PlDialog, PlBottomSheet, PlAppBar, PlFAB, PlDivider, PlTooltip
- **Composites**: GoalCard, TaskTile, TagChip, PriorityBadge, ProgressRing, StreakCounter, DateChip, EmptyState, LoadingShimmer
- **Layouts**: PlScaffold, PlPageTemplate, PlListView, PlGridView, PlSliverAppBar
- **Motion**: PlPageTransition, PlReorderable
- **Theme**: ThemeController with unlockable palettes, Material 3

#### Core Infrastructure ✅
- **Dual Calendar**: GregorianCalendar, JalaliCalendar, CalendarService
- **Database**: Drift v5 schema (Goals, Tasks, Tags, Templates, UserSettings)
- **Templates**: TemplateModel, TemplateDao, TemplateBloc (CRUD + import/export)
- **Custom Implementations**: 
  - `CustomSharedPreferences` (MethodChannel)
  - `AppPaths` (path_provider replacement)
  - `CustomNotificationService` (placeholder)
- **Native Integrations**: 
  - `MainActivity.kt` with MethodChannels for paths & preferences
  - Native Kotlin handlers for file paths & shared preferences

### Template System (Phase 1) ✅
- **TemplateModel**: JSON serialization, categories, icon/color
- **TemplateDao**: CRUD, watch streams, category filtering
- **TemplateBloc**: CRUD + import/export/share + create-from-goal
- **TemplateBlocBuilder** for UI integration

### Removed Problematic Dependencies
- ❌ `shared_preferences` → Custom `CustomSharedPreferences` (MethodChannel)
- ❌ `path_provider` → Custom `AppPaths` (MethodChannel)
- ❌ `flutter_local_notifications` → Custom `NotificationService` (placeholder)
- ❌ `fl_chart`, `curved_navigation_bar`, `skeletonizer` (commented out)

---

## Current Active Branch

**Branch**: `feature/smart-notifications` (from dev)

### Phase 1.4: Template Gallery UI ✅ COMPLETED
- [x] TemplateGalleryPage with category tabs
- [x] TemplateCard widget with preview
- [x] Category tabs (Habit, Project, Learning, Fitness, Custom)
- [x] Search and filter templates
- [x] Create template from scratch button
- [x] Template detail view
- [x] "Use Template" action (creates Goal + Tasks)
- [x] Category filtering and search
- [x] Pull-to-refresh

### Phase 1.5: Import/Export/Share UI ✅ COMPLETED
- [x] Export template as JSON file
- [x] Import template from JSON file
- [x] Share template via system share sheet
- [x] QR code generation for template sharing
- [x] Deep link handling for template import

### Phase 2: Gamification Core ✅ COMPLETED
- [x] XP/Level/Streak system (backend)
- [x] UserStats model with level calculation
- [x] UserStatsDao with streak tracking
- [x] UserStatsBloc for state management
- [x] Celebration animations (Lottie) - Level up, Streak milestone, Task complete
- [x] CelebrationService for triggering celebrations
- [x] Unlockables (themes, icons, animations) UI
- [x] Profile page with stats

### Phase 3: Smart Notifications (IN PROGRESS)
- [x] Notification service with flutter_local_notifications
- [x] Notification channel creation
- [x] Task reminder scheduling with timezone support
- [x] Rich actions (Complete, Snooze 10m, Snooze 1h)
- [x] Notification channel with high priority
- [x] Presets (10m, 1h, 1d, custom) - UI
- [x] Quiet hours, working days - UI
- [x] Per-goal overrides - UI
- [x] Notification settings page
- [ ] Snooze presets editor with custom add/remove
- [ ] Quiet hours time picker
- [ ] Working days selector
- [ ] Test notification button

---

## Current Git Status

```bash
# Current branch
feature/smart-notifications (from dev)

# Recent commits
- feat(notifications): add smart notification system with flutter_local_notifications
- feat(gamification): add Profile page with unlockables UI and fix UserStatsDao GetIt registration
- feat(gamification): add Lottie celebration animations and CelebrationService
- feat(template): complete import/export/share UI with file operations, QR codes, and deep links
- feat(template): complete template gallery UI with category tabs, search, filter, and share
- feat(template): add template gallery bloc with import/export/share
- feat(template): add template gallery UI with category tabs
- feat(template): add template tree UI with expand/collapse
- feat(template): add goal hierarchy with parent_goal_id
- feat(design): complete design system tokens & primitives
- feat(core): dual calendar abstraction + calendar service
- fix(build): fix gradle AGP 8.3.0 with resolutionStrategy
- fix(deps): remove problematic plugins, add custom implementations
```

---

## Verification Commands

```bash
# Clean & rebuild
flutter clean && flutter pub get

# Code generation
dart run build_runner build --delete-conflicting-outputs

# Analysis
flutter analyze

# Tests
flutter test

# Run on device
flutter run --debug -d "sdk gphone64 x86 64"

# Profile build
flutter run --profile -d "sdk gphone64 x86 64"

# Release build
flutter build apk --release
flutter build appbundle --release
```

---

## Known Issues & Fixes Applied

| Issue | Solution |
|-------|----------|
| AGP 8.12.1 not found | Force AGP 8.3.0 in build.gradle + resolutionStrategy |
| path_provider_android 2.2.19 needs AGP 8.12.1 | Override to 2.2.12 |
| shared_preferences_android needs AGP 8.5.1 | Override to 2.4.0 |
| flutter_local_notifications 17.0.0 has compile error | Use 18.0.1 |
| path_provider 2.1.5 needs AGP 8.5.0 | Override to 2.1.0 |
| shared_preferences_android needs AGP 7.2.2 | Override to 2.4.0 |
| path_provider 2.1.0 uses deprecated PluginRegistry.Registrar | Use path_provider 2.2.12 |

---

## Next Immediate Steps

1. **Complete TemplateGalleryPage** with category tabs
2. **Implement TemplateCard** with preview image + metadata
3. **Add category filtering** with animated transitions
4. **Implement "Use Template"** → creates Goal + Tasks
5. **Build Export/Import/Share UI** with share_plus
4. **Add pull-to-refresh** and search
5. **Test on physical device** + emulator
5. **Run full test suite** before PR