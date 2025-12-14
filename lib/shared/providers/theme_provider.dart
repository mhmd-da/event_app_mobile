import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_storage.dart';

final appThemeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

final themeStorageProvider = Provider<ThemeStorage>((ref) => ThemeStorage());
