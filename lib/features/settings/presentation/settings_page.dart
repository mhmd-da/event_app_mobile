import 'package:event_app/shared/widgets/language_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/app_dropdown.dart';
import 'package:event_app/shared/providers/theme_provider.dart';
import 'package:event_app/shared/providers/timezone_provider.dart';
import 'package:event_app/l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeModeProvider);
    final tzPref = ref.watch(appTimezonePreferenceProvider);
    final systemOffsetMinutes = DateTime.now().timeZoneOffset.inMinutes;
    final tzOptions = buildTimezoneOptions();
    final l10n = AppLocalizations.of(context);

    return AppScaffold(
      title: l10n?.settings ?? 'Settings',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LanguageSwitcherWidget(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                l10n?.timeZone ?? 'Time zone',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            AppDropdown<String>(
              value: tzPref,
              items: tzOptions,
              label: l10n?.timeZone ?? 'Time zone',
              helper: l10n?.timeZoneHelper ?? 'Default: System time zone',
              itemLabel: (v) {
                if (v == kTimezoneSystem) {
                  final offset = formatUtcOffsetMinutes(systemOffsetMinutes);
                  return '${l10n?.timeZoneSystem ?? 'System'} ($offset)';
                }
                final minutes = int.tryParse(v) ?? 0;
                return formatUtcOffsetMinutes(minutes);
              },
              onChanged: (v) async {
                if (v == null) return;
                ref.read(appTimezonePreferenceProvider.notifier).set(v);
                await ref
                    .read(timezoneStorageProvider)
                    .saveTimezonePreference(v);
              },
            ),
            // SwitchListTile(
            //   title: Text(AppLocalizations.of(context)?.language ?? 'Language'),
            //   subtitle: Text(AppLocalizations.of(context)?.toggleLanguage ?? 'Toggle language'),
            //   value: locale.languageCode == 'ar',
            //   onChanged: (on) async {
            //     final newLocale = Locale(on ? 'ar' : 'en');
            //     ref.read(appLocaleProvider.notifier).set(newLocale);
            //     // Persist selection
            //     await ref.read(languageStorageProvider).saveLocale(newLocale.languageCode);
            //     // Optionally call backend via profile changeLanguageProvider if needed
            //   },
            // ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                l10n?.theme ?? 'Theme',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            RadioListTile<ThemeMode>(
              title: Text(l10n?.themeSystem ?? 'System'),
              value: ThemeMode.system,
              groupValue: themeMode,
              onChanged: (mode) async {
                if (mode != null) {
                  ref.read(appThemeModeProvider.notifier).set(mode);
                  await ref.read(themeStorageProvider).saveThemeMode('system');
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(l10n?.themeLight ?? 'Light'),
              value: ThemeMode.light,
              groupValue: themeMode,
              onChanged: (mode) async {
                if (mode != null) {
                  ref.read(appThemeModeProvider.notifier).set(mode);
                  await ref.read(themeStorageProvider).saveThemeMode('light');
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(l10n?.themeDark ?? 'Dark'),
              value: ThemeMode.dark,
              groupValue: themeMode,
              onChanged: (mode) async {
                if (mode != null) {
                  ref.read(appThemeModeProvider.notifier).set(mode);
                  await ref.read(themeStorageProvider).saveThemeMode('dark');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
