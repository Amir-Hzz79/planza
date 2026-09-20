# Planza Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added - Phase 4: Hobbies & Habits
- Database schema v8: Hobbies and HobbySessions tables
- HobbyModel and HobbySessionModel with full JSON serialization
- HobbiesDao and HobbySessionsDao with CRUD + watch streams
- Recurring engine foundation (daily/weekly/custom)
- Session tracking with mood (1-5 scale) and notes

### Added - Phase 3: Smart Notifications
- Notification service with flutter_local_notifications
- Notification channel creation
- Task reminder scheduling with timezone support
- Rich actions (Complete, Snooze 10m, Snooze 1h)
- Notification channel with high priority
- [x] Presets (10m, 1h, 1d, custom) - UI
- [x] Quiet hours, working days - UI
- [x] Per-goal overrides - UI
- [x] Notification settings page

### Added - Phase 2: Gamification Core
- XP/Level/Streak system (backend)
- UserStats model with level calculation
- UserStatsDao with streak tracking
- UserStatsBloc for state management
- Celebration animations (Lottie) - Level up, Streak milestone, Task complete
- CelebrationService for triggering celebrations
- Unlockables (themes, icons, animations) UI
- Profile page with stats

### Added - Phase 1.5: Template Import/Export/Share
- Export template as JSON file
- Import template from JSON file
- Share template via system share sheet
- QR code generation for template sharing
- Deep link handling for template import

### Added - Phase 1.4: Template Gallery
- TemplateGalleryPage with category tabs
- TemplateCard widget with preview and actions
- Category tabs (Habit, Project, Learning, Fitness, Custom)
- Search and filter templates
- Create template from scratch button
- Template detail view
- "Use Template" action (creates Goal + Tasks)
- Category filtering and search
- Pull-to-refresh

### Added - Phase 1: Goal Hierarchy & Templates
- Parent goals, tree UI, drag-drop reorder
- Template engine (JSON serialization)
- Import/export/share templates
- Template gallery with categories

### Added - Phase 0: Foundation
- Design System Tokens (Colors, Spacing, Typography, Motion)
- Design Primitives (Button, Card, TextField, Chip, etc.)
- Composite Widgets (GoalCard, TaskTile, TagChip, etc.)
- Layout Primitives (PlScaffold, PlPageTemplate, PlListView)
- Motion System (PlPageTransition, PlReorderable)
- Theme Controller (Dynamic Material 3, unlockable themes, RTL)
- Dual Calendar Abstraction (Gregorian/Jalali)
- Database Migrations v1-v5 (Goals, Tasks, Tags, Templates, UserStats)
- Custom implementations replacing problematic plugins

## [1.0.0] - Unreleased

### First Release
- Initial release target

---

## Migration Notes

### Schema v8 (Current)
- Added `Hobbies` table
- Added `HobbySessions` table
- Requires migration from v7

### Schema v7
- Added `UserStats` table for gamification

### Schema v6
- Added `NotificationPrefs` table
- Added `GoalNotificationOverride` table

### Schema v5
- Added `Templates` table

### Schema v4
- Added `parentGoalId` to Goals table

### Schema v3
- Added `icon` column to Goals

### Schema v2
- Added `color` column to Goals

### Schema v1
- Initial schema: Goals, Tasks, Tags, UserSettings