// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_navigation_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// This provider holds the current index of the main navigation bar.
/// Used to programmatically change the page from other parts of the app.

@ProviderFor(MainNavigationIndex)
const mainNavigationIndexProvider = MainNavigationIndexProvider._();

/// This provider holds the current index of the main navigation bar.
/// Used to programmatically change the page from other parts of the app.
final class MainNavigationIndexProvider
    extends $NotifierProvider<MainNavigationIndex, int> {
  /// This provider holds the current index of the main navigation bar.
  /// Used to programmatically change the page from other parts of the app.
  const MainNavigationIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mainNavigationIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mainNavigationIndexHash();

  @$internal
  @override
  MainNavigationIndex create() => MainNavigationIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$mainNavigationIndexHash() =>
    r'09a2ae1c062982a06e2c08031cdbad71457945d3';

/// This provider holds the current index of the main navigation bar.
/// Used to programmatically change the page from other parts of the app.

abstract class _$MainNavigationIndex extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
