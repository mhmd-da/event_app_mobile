import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/shared/providers/language_provider.dart';
import 'package:event_app/shared/providers/theme_provider.dart';
import 'package:event_app/l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    final themeMode = ref.watch(appThemeModeProvider);

    return AppScaffold(
      title: AppLocalizations.of(context)?.settings ?? 'Settings',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SwitchListTile(
            title: Text(AppLocalizations.of(context)?.language ?? 'Language'),
            subtitle: Text(AppLocalizations.of(context)?.toggleLanguage ?? 'Toggle language'),
            value: locale.languageCode == 'ar',
            onChanged: (on) async {
              final newLocale = Locale(on ? 'ar' : 'en');
              ref.read(appLocaleProvider.notifier).state = newLocale;
              // Persist selection
              await ref.read(languageStorageProvider).saveLocale(newLocale.languageCode);
              // Optionally call backend via profile changeLanguageProvider if needed
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(AppLocalizations.of(context)?.theme ?? 'Theme', style: Theme.of(context).textTheme.titleMedium),
          ),
          RadioListTile<ThemeMode>(
            title: Text(AppLocalizations.of(context)?.themeSystem ?? 'System'),
            value: ThemeMode.system,
            groupValue: themeMode,
            onChanged: (mode) async {
              if (mode != null) {
                ref.read(appThemeModeProvider.notifier).state = mode;
                await ref.read(themeStorageProvider).saveThemeMode('system');
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text(AppLocalizations.of(context)?.themeLight ?? 'Light'),
            value: ThemeMode.light,
            groupValue: themeMode,
            onChanged: (mode) async {
              if (mode != null) {
                ref.read(appThemeModeProvider.notifier).state = mode;
                await ref.read(themeStorageProvider).saveThemeMode('light');
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text(AppLocalizations.of(context)?.themeDark ?? 'Dark'),
            value: ThemeMode.dark,
            groupValue: themeMode,
            onChanged: (mode) async {
              if (mode != null) {
                ref.read(appThemeModeProvider.notifier).state = mode;
                await ref.read(themeStorageProvider).saveThemeMode('dark');
              }
            },
          ),
        ],
      ),
    );
  }
}
