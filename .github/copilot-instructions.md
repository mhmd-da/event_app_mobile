# Event App - AI Agent Instructions

## Architecture Overview

This is a **Flutter event management mobile app** using **Riverpod** for state management. The app supports bilingual localization (English/Arabic) and follows a feature-based architecture with clean separation of concerns.

### Core Tech Stack
- **State Management**: `flutter_riverpod ^2.5.0` (Providers, StateNotifiers)
- **HTTP Client**: `dio ^5.5.0` with interceptors for auth tokens
- **Secure Storage**: `flutter_secure_storage ^9.0.0` for JWT tokens
- **Localization**: `flutter_localizations` + ARB files (`app_en.arb`, `app_ar.arb`)
- **Navigation**: Flutter's built-in `Navigator` with global `navigatorKey`

### Project Structure
```
lib/
├── core/               # Shared infrastructure
│   ├── config/        # API endpoints (AppConfig)
│   ├── network/       # ApiClient with Dio + auth interceptors
│   ├── storage/       # SecureStorageService for token management
│   ├── theme/         # AppTheme, AppColors, AppTypography, AppSpacing
│   └── widgets/       # AppScaffold, reusable components
├── features/          # Feature modules (domain/data/presentation)
│   ├── auth/         # Login with JWT
│   ├── events/       # Event selection and details
│   ├── home/         # Home dashboard
│   ├── agenda/       # Session browsing and registration
│   ├── sessions/     # All sessions view
│   ├── my_schedule/  # User's registered sessions
│   ├── directory/    # Speakers and mentors
│   ├── profile/      # User profile management
│   ├── faqs/         # FAQs display
│   └── venue/        # Venue information
├── l10n/             # Localization files (*.arb)
├── main_navigation/  # Bottom nav scaffold
├── shared/           # Shared providers (language_provider)
└── startup/          # Bootstrap logic (StartUpPage)
```

## Key Architectural Patterns

### 1. Feature Module Structure
Each feature follows this layered structure:
```
features/<feature_name>/
├── domain/           # Models (e.g., SessionModel.fromJson)
├── data/            # Repositories (e.g., SessionRepository)
└── presentation/    # UI + Providers
    ├── <feature>_page.dart
    ├── <feature>_providers.dart
    └── state/       # State models (optional)
```

**Example**: See `lib/features/agenda/` for the complete pattern.

### 2. Riverpod Provider Patterns

**Repository Provider** (singleton):
```dart
final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  return EventsRepository(ref.watch(apiClientProvider));
});
```

**Data Fetching** (auto-refresh):
```dart
final eventsListProvider = FutureProvider<List<EventModel>>((ref) async {
  return ref.watch(eventsRepositoryProvider).getEvents();
});
```

**Parameterized Providers** (family):
```dart
final eventDetailsProvider = FutureProvider.family<EventDetailsModel, int>(
  (ref, eventId) async => ref.watch(eventsRepositoryProvider).getEventDetails(eventId)
);
```

**State Management** (StateNotifier for complex logic):
```dart
final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref.watch(authRepositoryProvider), ref.watch(secureStorageProvider));
});
```

**UI State** (simple values):
```dart
final mainNavigationIndexProvider = StateProvider<int>((ref) => 0);
```

### 3. API Integration Pattern

- **Base URL**: Defined in `lib/core/config/app_config.dart`
- **Auth Flow**: JWT token stored via `SecureStorageService`, auto-injected via Dio interceptor
- **API Client**: Singleton `ApiClient` in `lib/core/network/api_client.dart`
- **Repository Methods**: Always return parsed domain models (never raw JSON)

**Example Repository**:
```dart
Future<List<SessionModel>> getSessions(int eventId) async {
  final response = await _apiClient.client.get(AppConfig.getSessions(eventId));
  final list = response.data["data"]["items"];
  return list.map((e) => SessionModel.fromJson(e)).toList();
}
```

### 4. Model Conventions

All domain models implement `fromJson`:
```dart
factory EventModel.fromJson(Map<String, dynamic> json) {
  return EventModel(
    id: json['id'] as int,
    name: json['name'] ?? '',
    startDate: DateTime.parse(json['startDate']),
  );
}
```

No code generation - manual JSON serialization throughout.

### 5. Localization Pattern

- **ARB files**: `lib/l10n/app_en.arb` and `app_ar.arb`
- **Usage in UI**: `AppLocalizations.of(context)!.keyName`
- **Language switching**: Update `appLocaleProvider` state (see `lib/shared/providers/language_provider.dart`)
- **Persistence**: Saved via `LanguageStorage` and loaded at app startup

### 6. Theming System

- **Theme files**: `lib/core/theme/` (colors, typography, spacing, decorations)
- **Light/Dark**: `AppTheme.light()` / `AppTheme.dark()` with system preference
- **Colors**: Use `AppColors.primary`, `AppColors.lightSurface`, etc.
- **Spacing**: Use `AppSpacing.small`, `AppSpacing.medium` (defined constants)
- **Typography**: `AppTypography.lightTextTheme` / `darkTextTheme`

### 7. Navigation Flow

1. **App Entry**: `main.dart` → `StartUpPage`
2. **StartUpPage Bootstrap**:
   - Check JWT token validity via `SecureStorageService.isValidToken()`
   - If invalid → `LoginPage`
   - If valid → Fetch event details → `MainNavigationPage`
3. **MainNavigationPage**: Bottom nav with 4 tabs (Home, Agenda, Sessions, Profile)
4. **Global Navigator**: Use `navigatorKey` for programmatic navigation

### 8. Authentication Flow

- Login via `AuthRepository.login(username, password)`
- JWT token decoded to extract `event_id` claim
- Token + expiry + event_id saved to `flutter_secure_storage`
- All API calls auto-include `Authorization: Bearer <token>` header

### 9. Event Context Management

The app is **event-scoped**:
- Selected event stored in `selectedEventProvider` (StateProvider)
- Event ID extracted from JWT or selected by user
- Most API calls require current event ID from provider
- Event switching available via AppScaffold's "Change Event" button

## Development Workflows

### Running the App
```powershell
flutter pub get
flutter run -d windows   # Or chrome, android, etc.
```

### Hot Reload/Restart
- **Hot Reload**: `r` in terminal (preserves state)
- **Hot Restart**: `R` (resets state, useful after provider changes)

### Adding a New Feature

1. Create feature directory: `lib/features/<feature_name>/`
2. Add domain models with `fromJson` in `domain/`
3. Create repository in `data/` (inject `ApiClient`)
4. Define providers in `presentation/<feature>_providers.dart`
5. Build UI with `ConsumerWidget` or `ConsumerStatefulWidget`
6. Add localization keys to `app_en.arb` and `app_ar.arb`
7. Update `AppConfig` with new endpoints

### Adding Localization Keys

1. Add to both `lib/l10n/app_en.arb` and `app_ar.arb`
2. Run `flutter gen-l10n` (auto-generates Dart files)
3. Use `AppLocalizations.of(context)!.newKey`

### API Configuration

All endpoints centralized in `lib/core/config/app_config.dart`:
```dart
static String getSessions(int eventId) => "/sessions?EventId=$eventId";
```

## Common Patterns to Follow

### UI State Loading Pattern
```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final asyncValue = ref.watch(dataProvider);
  
  return asyncValue.when(
    data: (data) => /* Success UI */,
    loading: () => CircularProgressIndicator(),
    error: (err, stack) => Text('Error: $err'),
  );
}
```

### Provider Watching
- `ref.watch()` → rebuilds on change
- `ref.read()` → one-time read (use in callbacks)
- `ref.listen()` → side effects (e.g., navigation)

### Secure Storage Usage
```dart
final storage = SecureStorageService();
final token = await storage.getToken();
final eventId = await storage.getEventId();
final isValid = await storage.isValidToken();
```

### Theme-Aware Widgets
```dart
ElevatedButton.styleFrom(
  backgroundColor: AppColors.primary,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
)
```

## Critical Files Reference

- **App Entry**: `lib/main.dart`
- **Bootstrap**: `lib/startup/startup_page.dart`
- **API Config**: `lib/core/config/app_config.dart`
- **Theme**: `lib/core/theme/app_theme.dart`
- **Auth Storage**: `lib/core/storage/secure_storage_service.dart`
- **Language**: `lib/shared/providers/language_provider.dart`
- **Main Nav**: `lib/main_navigation/main_navigation_page.dart`

## Important Notes

- **No GetIt**: Despite being in pubspec, GetIt is unused - all DI via Riverpod providers
- **No Code Generation**: Manual JSON serialization only
- **RTL Support**: App supports Arabic with automatic RTL layout
- **Event-Scoped**: Most features require an active event context
- **Token Expiry**: App checks JWT expiry on startup, redirects to login if expired
