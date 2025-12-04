import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/shared/providers/language_provider.dart';
import 'package:event_app/startup/startup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';

// Ensure the navigatorKey is globally accessible.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(languageProvider); // Updated to use languageProvider

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
      home: const StartUpPage(),
    );
  }
}
