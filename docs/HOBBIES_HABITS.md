# Hobbies & Habits

## Overview

Hobbies & Habits feature enables tracking recurring activities with mood tracking and insights.

---

## Database Schema

### Hobbies Table
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

### HobbySessions Table
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

## Models

### HobbyModel
```dart
class HobbyModel {
  final int id;
  final String name;
  final String? description;
  final String category;
  final int? icon;
  final int? color;
  final String frequency;           // 'daily', 'weekly', 'custom'
  final String? customFrequencyJson; // JSON for custom recurrence
  final int? targetDurationMinutes;
  final int? goalId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
}
```

### HobbySessionModel
```dart
class HobbySessionModel {
  final int id;
  final int hobbyId;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final int? mood;              // 1-5 scale
  final String? notes;
  final DateTime createdAt;
}
```

---

## DAOs

### HobbiesDao
```dart
class HobbiesDao {
  Stream<List<HobbyModel>> watchAllHobbies();
  Stream<List<HobbyModel>> watchActiveHobbies();
  Stream<List<HobbyModel>> watchHobbiesByCategory(String category);
  Stream<List<HobbyModel>> watchHobbiesByGoal(int goalId);
  
  Future<HobbyModel?> getHobbyById(int id);
  Future<int> insertHobby(HobbyModel hobby);
  Future<bool> updateHobby(HobbyModel hobby);
  Future<int> deleteHobby(int id);
  Future<List<HobbyModel>> getAllHobbies();
  Future<List<HobbyModel>> getActiveHobbies();
  Future<List<HobbyModel>> getHobbiesByCategory(String category);
  Future<List<HobbyModel>> getHobbiesByGoal(int goalId);
}
```

### HobbySessionsDao
```dart
class HobbySessionsDao {
  Stream<List<HobbySessionModel>> watchSessionsForHobby(int hobbyId);
  
  Future<HobbySessionModel?> getSessionById(int id);
  Future<int> insertSession(HobbySessionModel session);
  Future<bool> updateSession(HobbySessionModel session);
  Future<int> deleteSession(int id);
  
  Future<List<HobbySessionModel>> getSessionsForHobby(int hobbyId);
  Future<List<HobbySessionModel>> getSessionsInRange(DateTime start, DateTime end);
  
  Future<Map<int, int>> getTotalDurationPerHobby(DateTime start, DateTime end);
  
  Future<void> endSession(int sessionId, {int? mood, String? notes});
}
```

---

## Models

### HobbyModel
```dart
class HobbyModel {
  final int id;
  final String name;
  final String? description;
  final String category;
  final int? icon;
  final int? color;
  final String frequency;           // 'daily', 'weekly', 'custom'
  final String? customFrequencyJson; // JSON for custom recurrence
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

### HobbySessionModel
```dart
class HobbySessionModel {
  final int id;
  final int hobbyId;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final int? mood;           // 1-5 scale
  final String? notes;
  final DateTime createdAt;
  
  // Session management
  HobbySessionModel copyWith({...});
  Map<String, dynamic> toJson();
  static HobbySessionModel fromJson(Map<String, dynamic> json);
  
  // Drift conversion
  factory HobbySessionModel.fromEntity(HobbySession entity);
  HobbySession toEntity();
  HobbySessionsCompanion toInsertCompanion();
  HobbySessionsCompanion toUpdateCompanion();
}
```

---

## Recurring Engine

### Frequency Types

```dart
enum HobbyFrequency {
  daily,      // Every day
  weekly,     // Specific days of week
  custom,     // Custom cron-like pattern
}
```

### Recurrence Logic

```dart
class RecurrenceEngine {
  // Check if hobby is due today
  static bool isDueToday(HobbyModel hobby, DateTime now);
  
  // Get next occurrence
  static DateTime? getNextOccurrence(HobbyModel hobby, DateTime after);
  
  // Get all occurrences in range
  static List<DateTime> getOccurrencesInRange(
    HobbyModel hobby, 
    DateTime start, 
    DateTime end
  );
}
```

### Frequency Parsing

```dart
// Daily: "daily"
// Weekly: "weekly:1,3,5" (Mon, Wed, Fri)
// Custom: Custom JSON with cron-like pattern

class FrequencyParser {
  static bool isDue(HobbyModel hobby, DateTime date) {
    switch (hobby.frequency) {
      case 'daily': return true;
      case 'weekly': return _checkWeekly(hobby.customFrequencyJson, date);
      case 'custom': return _checkCustom(hobby.customFrequencyJson, date);
    }
  }
}
```

---

## Session Tracking

### Session Lifecycle

```
HobbySession
    │
    ├── startTime (required)
    ├── endTime (nullable)
    ├── durationMinutes (auto-calculated)
    ├── mood (1-5, optional)
    ├── notes (optional)
    └── createdAt (auto)
```

### Session Lifecycle

```
START ─────────────────────► END
  │                           │
  │  startTime                │  endTime
  │                           │  durationMinutes
  │                           │  mood (1-5)
  │                           │  notes
  ▼                           ▼
createdAt              completed
```

### Auto-Duration Calculation

```dart
Future<void> endSession(int sessionId, {int? mood, String? notes}) async {
  final session = await getSessionById(sessionId);
  if (session != null) {
    final endTime = DateTime.now();
    final duration = endTime.difference(session.startTime).inMinutes;
    
    final updated = session.copyWith(
      endTime: DateTime.now(),
      durationMinutes: duration,
      mood: mood,
      notes: notes,
    );
    
    await updateSession(updated);
  }
}
```

---

## Mood Tracking

### Mood Scale (1-5)

```dart
enum MoodLevel {
  terrible(1, '😭'),
  bad(2, '😞'),
  okay(3, '😐'),
  good(4, '😊'),
  great(5, '😍');
  
  final int value;
  final String emoji;
}
```

### Mood Analytics

```dart
class MoodAnalytics {
  // Average mood per hobby
  static Future<double> getAverageMood(int hobbyId, DateRange range);
  
  // Mood trend over time
  static Future<List<MoodPoint>> getMoodTrend(int hobbyId, DateRange range);
  
  // Mood distribution
  static Future<Map<int, int>> getMoodDistribution(int hobbyId, DateRange range);
}
```

---

## Insights & Analytics

### Time Allocation

```dart
class TimeAnalytics {
  // Total time per hobby
  static Future<Map<int, int>> getTotalDurationPerHobby(DateRange range);
  
  // Weekly/monthly totals
  static Future<List<TimePoint>> getWeeklyTotals(int hobbyId, int weeks);
  
  // Heatmap data
  static Future<List<HeatmapPoint>> getHeatmapData(int hobbyId, int months);
}
```

### Correlations

```dart
class CorrelationEngine {
  // Mood vs Duration
  static Correlation moodVsDuration(int hobbyId);
  
  // Mood vs Day of Week
  static Correlation moodVsDayOfWeek(int hobbyId);
  
  // Consistency score
  static double consistencyScore(int hobbyId, int weeks);
}
```

---

## UI Components

### Hobby Card
```dart
HobbyCard(
  hobby: hobbyModel,
  onTap: () => navigateToDetail(hobby),
  onLongPress: () => showOptions(hobby),
  showStreak: true,
  showNextDue: true,
)
```

### Session Tracker
```dart
SessionTracker(
  hobby: hobbyModel,
  onStart: () => startSession(hobby),
  onEnd: (mood, notes) => endSession(sessionId, mood, notes),
  showTimer: true,
  showMoodPicker: true,
)
```

### Mood Picker
```dart
MoodPicker(
  selectedMood: selectedMood,
  onChanged: (mood) => setState(() => selectedMood = mood),
  showEmoji: true,
)
```

### Streak Counter
```dart
StreakCounter(
  currentStreak: hobby.currentStreak,
  longestStreak: hobby.longestStreak,
  size: 64,
  animated: true,
)
```

---

## Recurring Engine

### Scheduler

```dart
class HobbyScheduler {
  // Schedule notifications for due hobbies
  static Future<void> scheduleNotifications();
  
  // Cancel notifications for hobby
  static Future<void> cancelNotifications(int hobbyId);
  
  // Reschedule after frequency change
  static Future<void> reschedule(int hobbyId);
}
```

### Daily Check

```dart
class DailyHobbyCheck {
  // Run daily at midnight
  static Future<void> runDailyCheck() async {
    final now = DateTime.now();
    final dueHobbies = await HobbiesDao.getActiveHobbies()
      .where((h) => RecurrenceEngine.isDueToday(h, DateTime.now()))
      .toList();
    
    for (final hobby in dueHobbies) {
      await NotificationService.scheduleHobbyReminder(hobby);
    }
  }
}
```

---

## Statistics

### Hobby Statistics

```dart
class HobbyStatistics {
  // Basic stats
  final int totalSessions;
  final int totalMinutes;
  final int currentStreak;
  final int longestStreak;
  final double averageMood;
  final int totalSessionsThisWeek;
  final int totalMinutesThisWeek;
  
  // Streaks
  int currentStreak;
  int longestStreak;
  
  // Mood
  double averageMood;
  Map<int, int> moodDistribution;
  
  // Consistency
  double consistencyScore;
  Map<int, int> sessionsByDayOfWeek;
}
```

### Computed Properties

```dart
extension HobbyStats on HobbyModel {
  int get currentStreak => _calculateCurrentStreak();
  int get longestStreak => _calculateLongestStreak();
  double get averageMood => _calculateAverageMood();
  double get consistencyScore => _calculateConsistencyScore();
}
```

---

## UI Pages

### HobbyListPage
- List all hobbies with filters
- Filter by category, active status
- Quick actions: start session, edit, archive

### HobbyDetailPage
- Hobby info + stats
- Session history list
- Start session button
- Edit hobby

### SessionTrackingPage
- Timer with pause/resume
- Mood picker (1-5 emoji)
- Notes input
- Auto-save on background

### HobbyCreateEditPage
- Form with validation
- Frequency picker (daily/weekly/custom)
- Icon/color picker
- Goal linking

---

## Integration Points

### With Goals
- Hobbies can link to Goals via `goalId`
- Progress contributes to goal progress
- Shared notifications

### With Gamification
- Session completion → XP reward
- Streak milestones → celebrations
- Mood tracking → bonus XP

### With Notifications
- Due reminders
- Streak warnings
- Achievement celebrations