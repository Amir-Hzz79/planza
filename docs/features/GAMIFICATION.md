# Gamification

XP/level system with streaks, celebrations, and unlockable themes/icons/animations. User profile with stats.

## What It Does

- Earn XP for completing goals/tasks/sessions
- Level up based on total XP; level determines unlock eligibility
- Streak tracking: current streak, longest streak (for goals/sessions)
- Celebration animations via Lottie: level up, streak milestone, task complete
- CelebrationService triggers animations at the right moments
- Unlockables: 8 color palettes unlockable at levels 5/10/15/20/25/30/50
- Profile page: XP level card, stats grid (total XP, level, streaks, unlockables), available/unlocked themes

## Key Files

```
lib/core/data/
├── models/
│   └── user_stats_model.dart         # UserStats entity (XP, level, streaks, unlockables, etc.)
├── data_access_object/
│   └── user_stats_dao.dart           # CRUD, streak tracking, level calculation

lib/core/services/
└── celebration_service.dart          # Triggers Lottie celebrations at app lifecycle moments

lib/features/gamification/
├── presentation/
│   ├── pages/
│   │   └── profile_page.dart         # Profile: XP card, stats grid, unlockables section
│   └── widgets/
│       ├── xp_level_card.dart        # XP ring progress, level, "Next level at X XP", progress bar
│       ├── stats_grid.dart           # Grid of stat cards (total sessions, time, streak, mood, etc.)
│       ├── unlockables_section.dart  # Available vs unlocked palettes
│       └── index.dart
```

## BLoC: UserStatsBloc (core)

Events: `LoadUserStats`, plus mutation events (add XP, streak update, etc.)

State: `UserStatsInitial` → `UserStatsLoading` → `UserStatsLoaded(UserStatsModel)` / `UserStatsError`

Registered in app.dart. Watches user stats from UserStatsDao.

## XP & Leveling

Level is computed from total XP. The exact formula lives in UserStatsModel/UserStatsDao. Progress to next level shown as a ring (ProgressRing widget) in xp_level_card.dart.

## Streaks

Current streak and longest streak tracked per activity type (goals, hobbies sessions). StreakCounter composite widget used in various places.

## Unlockable Palettes

8 palettes, each requiring a minimum level:
- Default (always)
- Forest (level 5)
- Ocean (level 10)
- Sunset (level 15)
- Lavender (level 20)
- Rose (level 25)
- Amber (level 30)
- Midnight (level 50)

Unlocked palettes persist via CustomSharedPreferences (MethodChannel). ThemeBloc reads unlocked palettes and surfaces them in theme picker.

## Celebrations

CelebrationService initializes Lottie animation controllers. Fires:
- Level up celebration
- Streak milestone celebration
- Task complete celebration

Animated via Lottie files in assets.

## Integration Points

- Hobbies: session completion → XP reward + streak
- Goals/Tasks: completion → XP + streak
- Theme: unlocked palettes feed into ThemeBloc/ThemeController
- Profile: displays all gamification stats
