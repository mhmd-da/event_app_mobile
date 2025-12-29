import 'package:event_app/core/notifications/local_notification_service.dart';
import 'package:event_app/core/notifications/notification_manager.dart';
import 'package:event_app/shared/providers/language_provider.dart';
import 'package:event_app/shared/providers/theme_provider.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/startup/startup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/core/theme/app_theme.dart';
import 'package:event_app/shared/providers/language_storage.dart';
import 'package:event_app/shared/providers/theme_storage.dart';

// Ensure the navigatorKey is globally accessible.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();

  await Firebase.initializeApp();
  await container.read(notificationManagerProvider).initializeFCM();
  await LocalNotificationService.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Load persisted locale and theme before starting app
  final langCode = await LanguageStorage().loadLocale();
  if (langCode != null && langCode.isNotEmpty) {
    container.read(appLocaleProvider.notifier).set(Locale(langCode));
  } else {
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final normalized = deviceLocale.languageCode.toLowerCase() == 'ar'
        ? 'ar'
        : 'en';
    await LanguageStorage().saveLocale(normalized);
    container.read(appLocaleProvider.notifier).set(Locale(normalized));
  }
  final themeSaved = await ThemeStorage().loadThemeMode();
  if (themeSaved != null) {
    final mode = themeSaved == 'dark'
        ? ThemeMode.dark
        : themeSaved == 'light'
        ? ThemeMode.light
        : ThemeMode.system;
    container.read(appThemeModeProvider.notifier).set(mode);
  }

  // Riverpod 3+: use UncontrolledProviderScope to pass an external container
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    final themeMode = ref.watch(appThemeModeProvider);

    return MaterialApp(
      navigatorKey: navigatorKey, // Add the navigatorKey here
      locale: locale, // Dynamic locale from languageProvider
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      home: const StartUpPage(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // ignore: avoid_print
  //print("Background message received: ${message.messageId}");
}
