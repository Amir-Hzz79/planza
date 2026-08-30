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

## Phase 0: Foundation & Design System ? IN PROGRESS

### 0.1 Design System Tokens & Primitives
- [x] Colors (light/dark + 8 unlockable palettes)
- [x] Spacing, Typography, Border Radius, Elevation, Motion
- [x] Primitive widgets: PlButton, PlCard, PlTextField, PlChip, PlAvatar, PlDialog, PlBottomSheet, PlAppBar, PlFAB, PlDivider, PlTooltip
- [ ] Composite widgets: GoalCard, TaskTile, TagChip, PriorityBadge, ProgressRing, StreakCounter, DateChip, EmptyState, LoadingShimmer
- [ ] Layout primitives: PlScaffold, PlListView, PlGridView, PlSliverAppBar, PlPageTemplate
- [ ] Motion system: PlPageTransition, PlReorderable, PlExpandable, PlCelebration, PlMicroInteractions
- [ ] Theme controller: dynamic Material 3, unlockable themes, RTL support

### 0.2 Dual Calendar Abstraction
- [ ] CalendarSystem abstract class
- [ ] GregorianCalendar implementation
- [ ] JalaliCalendar implementation
- [ ] CalendarService with primary/secondary calendar
- [ ] Migrate all date formatting to CalendarService
- [ ] User preference for calendar type

### 0.3 Database Migrations (Drift)
- [ ] Add parent_goal_id to Goals table
- [ ] Create Templates table
- [ ] Create UserStats table (XP, level, streaks, unlockables)
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
- [ ] Parent goals, tree UI, drag-drop reorder
- [ ] Template engine (JSON serialization)
- [ ] Import/export/share templates
- [ ] Template gallery with categories

---

## Phase 2: Gamification Core
- [ ] XP/Level/Streak system
- [ ] Celebration animations (Lottie)
- [ ] Unlockables (themes, icons, animations)
- [ ] Profile page with stats

---

## Phase 3: Smart Notifications
- [ ] Presets (10m, 1h, 1d, custom)
- [ ] Rich actions (complete/snooze)
- [ ] Quiet hours, working days
- [ ] Per-goal overrides

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

## Git Flow

```
master (production) ? stage (stable release) ? dev (integration) ? feature/* branches
```

### Branches
- **master** — Production releases only, protected
- **stage** — Pre-release testing, protected
- **dev** — Ongoing integration
- **feature/** — Individual tasks (e.g., `feature/design-tokens`)

### Workflow
1. `git checkout dev && git pull`
2. `git checkout -b feature/task-name`
3. Implement ? commit ? push
4. PR: feature ? dev (review required)
5. Phase complete ? PR: dev ? stage (QA)
6. Stable ? PR: stage ? master (with tag)

---

## Technical Decisions

| Decision | Choice | Status |
|----------|--------|--------|
| Backend | Supabase (auth, realtime, push, DB) | Planned |
| State Management | flutter_bloc + hydrated_bloc | Current |
| Animations | Lottie for celebrations | Planned |
| Calendar | Dual Gregorian/Jalali abstraction | In Progress |
| Monetization | RevenueCat (Freemium + Team tiers) | Planned |
| Anti-Cheat | Design-out-incentive + soft detection | Planned |

---

## Freemium Model

| Feature | Free | Premium |
|---------|------|---------|
| Goals & Tasks | Unlimited | Unlimited |
| Tags | 10 max | Unlimited |
| Goal Hierarchy | 1 level | Unlimited |
| Calendar Views | Month only | Month/Week/Day/3-day |
| Google Calendar Sync | ? | ? |
| Templates | 5 built-in, 3 custom | All 20+, unlimited custom |
| Export/Import | ? | ? |
| Themes | 3/8 | All 8 + seasonal |
| Icons | 10/50 | All 50 + custom |
| Insights | Weekly only | Monthly/Yearly + correlations |
| Hobbies | 2 | Unlimited |
| Cloud Sync | ? | ? |
| Web Access | ? | ? |

---

## Current Status
- **Branch**: `feature/0.1-design-tokens` (merged to dev)
- **Completed**: Design tokens (colors, spacing, typography, border_radius, motion), Primitive widgets (10 components)
- **Next**: Composite widgets, Layout primitives, Motion system

---

## File Structure (New)
```
lib/core/design/
+-- tokens/
¦   +-- colors.dart
¦   +-- spacing.dart
¦   +-- typography.dart
¦   +-- border_radius.dart
¦   +-- motion.dart
¦   +-- index.dart
+-- primitives/
¦   +-- pl_button.dart
¦   +-- pl_card.dart
¦   +-- pl_text_field.dart
¦   +-- pl_chip.dart
¦   +-- pl_avatar.dart
¦   +-- pl_dialog.dart
¦   +-- pl_bottom_sheet.dart
¦   +-- pl_app_bar.dart
¦   +-- pl_fab.dart
¦   +-- pl_divider.dart
¦   +-- pl_tooltip.dart
¦   +-- index.dart
+-- composites/
¦   +-- goal_card.dart
¦   +-- task_tile.dart
¦   +-- tag_chip.dart
¦   +-- priority_badge.dart
¦   +-- progress_ring.dart
¦   +-- streak_counter.dart
¦   +-- date_chip.dart
¦   +-- empty_state.dart
¦   +-- loading_shimmer.dart
¦   +-- index.dart
+-- layouts/
¦   +-- pl_scaffold.dart
¦   +-- pl_page_template.dart
¦   +-- pl_list_view.dart
¦   +-- pl_grid_view.dart
¦   +-- pl_sliver_app_bar.dart
¦   +-- index.dart
+-- motion/
¦   +-- pl_page_transition.dart
¦   +-- pl_reorderable.dart
¦   +-- index.dart
+-- theme/
    +-- (to be created)
```
