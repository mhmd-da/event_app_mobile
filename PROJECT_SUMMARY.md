# Event App — Project Summary

## Overview

- **Name**: `event_app` (from `pubspec.yaml`)
- **Description**: "A new Flutter project." (from `pubspec.yaml`)
- **SDK constraint**: `sdk: ^3.8.1`
- **Purpose**: Flutter app for managing events, with localization (Arabic/English), theming, and multiple feature modules (agenda, sessions, events, my_schedule, directory, profile, etc.).

## Key Files

- **Entry point**: `lib/main.dart` — initializes Riverpod `ProviderContainer`, loads initial locale, and runs `ProviderScope` with `MyApp`.
- **Startup page**: `lib/startup/startup_page.dart` — app home flow begins here (`home: StartUpPage()` in `MyApp`).
- **Localization**: `lib/l10n/` contains `app_en.arb`, `app_ar.arb`, and generated localization files such as `app_localizations_ar.dart`.
- **Theme**: `lib/core/theme/app_theme.dart` plus supporting files (`app_colors.dart`, `app_text_styles.dart`, etc.).
- **Network client**: `lib/core/network/api_client.dart` (uses `dio`).
- **Storage**: `lib/core/storage/secure_storage_service.dart` and `flutter_secure_storage` package usage.

## Major Packages (from `pubspec.yaml`)

- `flutter_riverpod: ^2.5.0` — state management
- `flutter_secure_storage: ^9.0.0` — secure storage for tokens/preferences
- `dio: ^5.5.0` — HTTP client
- `carousel_slider: ^5.0.0` — UI carousel component
- `get_it: ^7.6.0` — service locator (dependency injection)
- `shared_preferences: ^2.2.2` — lightweight persistent storage
- `intl: ^0.20.0` — internationalization helpers
- `calendar_view: ^1.4.0` — calendar UI components
- `flutter_localizations` and `cupertino_icons`
- `jwt_decoder: ^2.0.1`

## App Behavior Notes (from `lib/main.dart`)

- The app obtains an initial locale by reading `localeLoaderProvider.future` from Riverpod before calling `runApp`.
- The `MaterialApp` is configured with dynamic `locale`, supports `Locale('en')` and `Locale('ar')`, and uses `AppLocalizations.delegate` plus Flutter's global localization delegates.
- Theme is managed by `AppTheme.light()` / `AppTheme.dark()` and `ThemeMode.system`.
- `navigatorKey` is defined at top-level: `GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();`

## Project Structure (high level)

Top-level folders and important subfolders:

- `lib/`
  - `core/` — theme, network, storage, utilities, widgets
  - `features/` — app features (many modules): `agenda`, `auth`, `directory`, `events`, `home`, `mentorship`, `my_schedule`, `notifications`, `profile`, `schedule`, `sessions`, etc.
  - `l10n/` — localization resource files
  - `main_navigation/` — navigation scaffolding
  - `shared/` — shared providers, widgets (e.g., `language_provider`, `language_switcher`)
  - `startup/` — `start_up_page.dart`

- Platform folders: `android/`, `ios/`, `web/`, `windows/`, `macos/`, `linux/`

Files scanned (counts):

- `lib/` files found: 82 (approx)
- `lib/features/` files found: 51 (approx)

## Notable Source Locations (examples)

- `lib/features/home/presentation/home_page.dart` — home UI
- `lib/features/events/data/events_repository.dart` — events data access
- `lib/features/agenda/data/session_repository.dart` — sessions/agenda data
- `lib/shared/providers/language_provider.dart` — locale provider

## How to build / run (typical Flutter steps)

```powershell
flutter pub get
flutter run
```

For platform-specific builds use `-d` flags (e.g., `-d windows`, `-d chrome`).

## Recommendations / Next Steps

- If you want a more detailed README, I can:
  - Expand this file with a file tree listing (full `lib/` file listing).
  - Extract and include contents of `README.md` and important config files.
  - Add development notes: how to run tests, code style, and common troubleshooting.

---

Generated on: 2025-12-03
