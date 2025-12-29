import 'package:event_app/shared/providers/language_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Storage provider
part 'language_provider.g.dart';

@Riverpod(keepAlive: true)
LanguageStorage languageStorage(Ref ref) => LanguageStorage();

// Load saved locale async
@riverpod
Future<Locale> localeLoader(Ref ref) async {
  final storage = ref.read(languageStorageProvider);
  final stored = await storage.loadLocale();
  if (stored != null && stored.isNotEmpty) return Locale(stored);

  final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
  final normalized = deviceLocale.languageCode.toLowerCase() == 'ar'
      ? 'ar'
      : 'en';
  await storage.saveLocale(normalized);
  return Locale(normalized);
}

// Current app locale (sync state)
@Riverpod(keepAlive: true)
class AppLocale extends _$AppLocale {
  @override
  Locale build() => const Locale('en');
  void set(Locale locale) => state = locale;
}
