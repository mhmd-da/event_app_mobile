// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_loading.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(GlobalLoading)
const globalLoadingProvider = GlobalLoadingProvider._();

final class GlobalLoadingProvider
    extends $NotifierProvider<GlobalLoading, int> {
  const GlobalLoadingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'globalLoadingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$globalLoadingHash();

  @$internal
  @override
  GlobalLoading create() => GlobalLoading();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$globalLoadingHash() => r'18db80f90ef9969acc2da5bbaaae0b4075b022c5';

abstract class _$GlobalLoading extends $Notifier<int> {
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
