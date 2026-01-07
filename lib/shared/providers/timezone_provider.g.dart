// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timezone_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(timezoneStorage)
const timezoneStorageProvider = TimezoneStorageProvider._();

final class TimezoneStorageProvider
    extends
        $FunctionalProvider<TimezoneStorage, TimezoneStorage, TimezoneStorage>
    with $Provider<TimezoneStorage> {
  const TimezoneStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'timezoneStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$timezoneStorageHash();

  @$internal
  @override
  $ProviderElement<TimezoneStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TimezoneStorage create(Ref ref) {
    return timezoneStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TimezoneStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TimezoneStorage>(value),
    );
  }
}

String _$timezoneStorageHash() => r'20b582f66832034b9c98b7d47615abf5cf53d6cd';

@ProviderFor(AppTimezonePreference)
const appTimezonePreferenceProvider = AppTimezonePreferenceProvider._();

final class AppTimezonePreferenceProvider
    extends $NotifierProvider<AppTimezonePreference, String> {
  const AppTimezonePreferenceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appTimezonePreferenceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appTimezonePreferenceHash();

  @$internal
  @override
  AppTimezonePreference create() => AppTimezonePreference();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appTimezonePreferenceHash() =>
    r'31a94e9d76edff31975de3178e12f1e3635ecf39';

abstract class _$AppTimezonePreference extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
