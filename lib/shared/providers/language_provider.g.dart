// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(languageStorage)
const languageStorageProvider = LanguageStorageProvider._();

final class LanguageStorageProvider
    extends
        $FunctionalProvider<LanguageStorage, LanguageStorage, LanguageStorage>
    with $Provider<LanguageStorage> {
  const LanguageStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageStorageHash();

  @$internal
  @override
  $ProviderElement<LanguageStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LanguageStorage create(Ref ref) {
    return languageStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LanguageStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LanguageStorage>(value),
    );
  }
}

String _$languageStorageHash() => r'6bed3ea7e0ee9c1aee8a16f67dcbd9292c6e5930';

@ProviderFor(localeLoader)
const localeLoaderProvider = LocaleLoaderProvider._();

final class LocaleLoaderProvider
    extends $FunctionalProvider<AsyncValue<Locale>, Locale, FutureOr<Locale>>
    with $FutureModifier<Locale>, $FutureProvider<Locale> {
  const LocaleLoaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeLoaderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeLoaderHash();

  @$internal
  @override
  $FutureProviderElement<Locale> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Locale> create(Ref ref) {
    return localeLoader(ref);
  }
}

String _$localeLoaderHash() => r'00632a4a7a3b8cbfa3a169c4428282594acd454d';

@ProviderFor(AppLocale)
const appLocaleProvider = AppLocaleProvider._();

final class AppLocaleProvider extends $NotifierProvider<AppLocale, Locale> {
  const AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  AppLocale create() => AppLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$appLocaleHash() => r'c5862a83ce916de2373bac277a08dd24ffd78a69';

abstract class _$AppLocale extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
