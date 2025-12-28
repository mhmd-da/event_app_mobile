import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/shared/providers/language_provider.dart';

class LanguageSwitcherWidget extends ConsumerWidget {
  const LanguageSwitcherWidget({super.key});

  static const String _englishLabel = 'English';
  static const String _arabicLabel = 'العربية';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);

    return Column(
      children: [
        SwitchListTile(
          title: Text(
            locale.languageCode == 'ar' ? _arabicLabel : _englishLabel,
          ),
          subtitle: Text(AppLocalizations.of(context)!.toggleLanguage),
          value: locale.languageCode == 'ar', // 👈 ON = Arabic
          onChanged: (isArabic) {
            final newLocale = isArabic
                ? const Locale('ar')
                : const Locale('en');

            // Update UI immediately
            ref.read(appLocaleProvider.notifier).set(newLocale);

            // Save preference
            ref
                .read(languageStorageProvider)
                .saveLocale(newLocale.languageCode);
          },
        ),
      ],
    );
  }
}
