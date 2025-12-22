// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(themeStorage)
const themeStorageProvider = ThemeStorageProvider._();

final class ThemeStorageProvider
    extends $FunctionalProvider<ThemeStorage, ThemeStorage, ThemeStorage>
    with $Provider<ThemeStorage> {
  const ThemeStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeStorageHash();

  @$internal
  @override
  $ProviderElement<ThemeStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ThemeStorage create(Ref ref) {
    return themeStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeStorage>(value),
    );
  }
}

String _$themeStorageHash() => r'7fc5fbc7df34d44a4fa66421093a061a0bb996b1';

@ProviderFor(AppThemeMode)
const appThemeModeProvider = AppThemeModeProvider._();

final class AppThemeModeProvider
    extends $NotifierProvider<AppThemeMode, ThemeMode> {
  const AppThemeModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeHash();

  @$internal
  @override
  AppThemeMode create() => AppThemeMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$appThemeModeHash() => r'ed99836113f51a409116c719be4a54080ec2bc9c';

abstract class _$AppThemeMode extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
