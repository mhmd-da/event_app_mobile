import 'package:event_app/shared/providers/language_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Storage provider
final languageStorageProvider = Provider((ref) => LanguageStorage());

// Load saved locale async
final localeLoaderProvider = FutureProvider<Locale>((ref) async {
  final storage = ref.read(languageStorageProvider);
  final stored = await storage.loadLocale();
  if (stored == null) return const Locale('en');
  return Locale(stored);
});

// Current app locale (sync state)
final appLocaleProvider = StateProvider<Locale>((ref) {
  return const Locale('en');
});
