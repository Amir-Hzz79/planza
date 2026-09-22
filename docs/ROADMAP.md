# Planza Roadmap

## Vision
Transform personal goal management into a social, template-driven ecosystem.

## Phase Overview

| Phase | Status | Focus |
|-------|--------|-------|
| Phase 0 | ✅ Complete | Foundation & Design System |
| Phase 1 | ✅ Complete | Goal Hierarchy & Templates |
| Phase 2 | ✅ Complete | Gamification Core |
| Phase 3 | ✅ Complete | Smart Notifications |
| Phase 4 | ✅ Complete | Hobbies & Habits |
| Phase 5 | 📋 Planned | Auth & Workspaces (Social MVP) |
| Phase 6 | 📋 Planned | Real-time Sync & Push |
| Phase 7 | 📋 Planned | Template Marketplace |
| Phase 8 | 📋 Planned | Social Layer |
| Phase 9 | 📋 Planned | AI Integration |
| Phase 10 | 📋 Planned | Polish & Launch |

---

## Phase 0: Foundation & Design System ✅

### Completed
- Design System Tokens (Colors, Spacing, Typography, Motion)
- Design Primitives (Button, Card, TextField, Chip, etc.)
- Composite Widgets (GoalCard, TaskTile, ProgressRing, etc.)
- Layout Primitives (PlScaffold, PlPageTemplate, PlListView)
- Motion System (PlPageTransition, PlReorderable)
- Theme Controller (Dynamic Material 3, unlockable themes, RTL)
- Dual Calendar Abstraction (Gregorian/Jalali)
- Database Migrations v1-v5 (Goals, Tasks, Tags, Templates, UserStats)
- Custom implementations replacing problematic plugins

---

## Phase 1: Goal Hierarchy & Templates ✅

### Completed
- Parent goals, tree UI, drag-drop reorder
- Template engine (JSON serialization)
- Template Gallery UI with category tabs
- Import/Export/Share templates (JSON file, QR code, deep links)

---

## Phase 2: Gamification Core ✅

### Completed
- XP/Level/Streak system (backend)
- UserStats model with level calculation
- UserStatsDao with streak tracking
- UserStatsBloc for state management
- Celebration animations (Lottie) - Level up, Streak milestone, Task complete
- CelebrationService for triggering celebrations
- Unlockables (themes, icons, animations) UI
- Profile page with stats

---

## Phase 3: Smart Notifications ✅

### Completed
- Notification service with flutter_local_notifications
- Notification channel creation with high priority
- Task reminder scheduling with timezone support
- Rich actions (Complete, Snooze 10m, Snooze 1h)
- Notification settings page
- Presets (10m, 1h, 1d, custom) - UI
- Quiet hours, working days - UI
- Per-goal overrides - UI
- Notification settings page

---

## Phase 4: Hobbies & Habits ✅ Complete

### Completed
- Database schema for Hobbies and HobbySessions (migration v8)
- HobbyModel and HobbySessionModel with JSON serialization
- HobbiesDao and HobbySessionsDao with CRUD + watch streams
- Recurring engine (`RecurrenceEngine`) — daily/weekly/custom
- Session tracking with mood (1-5) and notes
- Insights & stats (`HobbyStats`) — sessions, time, streaks, avg mood, mood distribution
- HobbiesPage — All/Due Today tabs, FilterChip filtering, search, add
- HobbyDetailPage — stats grid, session history, start/edit/delete
- HobbyCreateEditPage — frequency picker, icon/color picker, goal linking
- HobbyCard & SessionCard widgets
- HobbiesBloc with full CRUD + session management

---

## Phase 5: Auth & Workspaces (Social MVP) 📋

### Planned
- Email/Phone/OAuth + Anonymous guest
- Workspaces with roles (Owner, Admin, Member, Viewer)
- Shared goals/tasks with assignments
- Invitations via deep links

---

## Phase 6: Real-time Sync & Push 📋

### Planned
- Backend (Supabase recommended)
- Live updates, assign notifications
- Activity feed
- Background sync

---

## Phase 7: Template Marketplace 📋

### Planned
- Publish/discover/fork/rate templates
- Role-based templates
- Community gallery

---

## Phase 8: Social Layer 📋

### Planned
- Profiles, follow, groups
- Public achievements, leaderboards
- Social accountability features

---

## Phase 9: AI Integration 📋

### Planned
- Smart goal breakdown
- Weekly review generation
- Schedule optimizer
- Natural language input

---

## Phase 10: Polish & Launch 📋

### Planned
- Onboarding flow
- Home screen widgets
- Accessibility audit
- Store assets, landing page

---

## Current Status

| Metric | Value |
|--------|-------|
| Current Phase | 4 (Hobbies & Habits) |
| Phases Complete | 3/10 |
| Current Branch | `feature/hobbies-habits` |
| Last Release | v1.0.0 (unreleased) |

---

## Next Milestones

1. **Complete Phase 4** - Hobbies & Habits UI
2. **Phase 5** - Auth & Workspaces
3. **Phase 6** - Real-time Sync