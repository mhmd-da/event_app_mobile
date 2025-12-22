import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'theme_storage.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
ThemeStorage themeStorage(Ref ref) => ThemeStorage();

@Riverpod(keepAlive: true)
class AppThemeMode extends _$AppThemeMode {
  @override
  ThemeMode build() => ThemeMode.system;
  void set(ThemeMode mode) => state = mode;
}
