# Planza Development Guide

## Quick Commands

```bash
# Setup
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# Development
flutter run --debug -d "sdk gphone64 x86 64"
flutter run --profile -d "sdk gphone64 x86 64"

# Analysis
flutter analyze
dart analyze

# Testing
flutter test
flutter test integration_test/

# Code Generation
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs

# Build
flutter build apk --debug
flutter build apk --release
flutter build apk --profile
flutter build appbundle --release

# Clean
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

## Project Setup

### Prerequisites
- Flutter 3.29+
- Dart 3.7+
- Android Studio / VS Code
- Android SDK (API 34+)
- Java 17+

### First Time Setup
```bash
git clone <repo-url>
cd planza
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --debug
```

## Code Generation

Run after modifying:
- Database tables (`lib/core/data/database/tables.dart`)
- Models with `@JsonSerializable`
- Drift DAOs

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode (continuous)
dart run build_runner watch --delete-conflicting-outputs
```

## Common Issues

### Build Runner Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# If drift schema issues
rm lib/core/data/database/database.g.dart
dart run build_runner build --delete-conflicting-outputs
```

### Gradle Issues
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

## Running on Device

### Android Emulator
```bash
flutter run --debug -d "sdk gphone64 x86 64"
```

### Physical Device
```bash
flutter devices
flutter run --debug -d <device-id>
```

## Database Operations

### Schema Changes
1. Modify `lib/core/data/database/tables.dart`
2. Increment `schemaVersion` in `database.dart`
3. Add migration in `MigrationStrategy.onUpgrade`
4. Run `dart run build_runner build --delete-conflicting-outputs`

### Inspect Database
```bash
# Using adb
adb shell
run-as com.amirhosseinzamani.planza
sqlite3 databases/planza_db.sqlite
.tables
.schema
```

## Testing

```bash
# Unit tests
flutter test test/unit/

# Widget tests
flutter test test/widget/

# Integration tests
flutter test integration_test/

# All tests
flutter test
```

## Linting & Formatting

```bash
# Format
dart format .

# Analyze
flutter analyze
dart analyze

# Lint
flutter analyze --fatal-infos
```

## Environment Variables

Create `.env` file:
```env
# API Keys (if any)
SUPABASE_URL=
SUPABASE_ANON_KEY=
```

## IDE Setup

### VS Code Extensions
- Flutter
- Dart
- Flutter Riverpod Snippets (if using Riverpod)
- BLoC
- Drift
- GitLens

### Android Studio Plugins
- Flutter
- Dart
- Dart Data Class Generator
- Flutter Enhancement Suite

## Git Hooks (Optional)

```bash
# Pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/sh
dart format --set-exit-if-changed .
flutter analyze --fatal-infos
flutter test
EOF
chmod +x .git/hooks/pre-commit
```