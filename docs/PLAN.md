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

## Phase 4: Hobbies & Habits ✅ COMPLETED
- [x] Database schema for Hobbies and HobbySessions (migration v8)
- [x] HobbyModel and HobbySessionModel with JSON serialization
- [x] HobbiesDao and HobbySessionsDao with CRUD + watch streams
- [x] Recurring engine (daily/weekly/custom) — `RecurrenceEngine` in `lib/core/utils/`
- [x] Session tracking with mood — start/end sessions, mood picker (1-5), notes
- [x] Insights & stats — `HobbyStats` compute (total sessions, time, streaks, avg mood, mood distribution, sessions by day)
- [x] HobbiesPage — list with All/Due Today tabs, FilterChip filtering (All/Active/Daily/Weekly/Custom)
- [x] HobbyDetailPage — info, stats grid, session history, start session, edit, delete
- [x] HobbyCreateEditPage — form with frequency picker, icon/color picker, goal linking, target duration
- [x] HobbyCard widget — color/icon, frequency badge, target duration, goal link, start/edit/delete actions
- [x] SessionCard widget — duration, mood indicator, date/time, streak context

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

## Implementation Flow

See [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md) for development workflow, commands, and procedures.

### Quick Reference
1. Create feature branch from `dev`
2. Implement + `flutter analyze` (0 errors)
3. `dart run build_runner build --delete-conflicting-outputs`
4. Commit with conventional messages, push, PR to `dev`

See [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md) for full details.

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