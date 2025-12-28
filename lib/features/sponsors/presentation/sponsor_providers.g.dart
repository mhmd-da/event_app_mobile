// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sponsorRepository)
const sponsorRepositoryProvider = SponsorRepositoryProvider._();

final class SponsorRepositoryProvider
    extends
        $FunctionalProvider<
          SponsorRepository,
          SponsorRepository,
          SponsorRepository
        >
    with $Provider<SponsorRepository> {
  const SponsorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sponsorRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sponsorRepositoryHash();

  @$internal
  @override
  $ProviderElement<SponsorRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SponsorRepository create(Ref ref) {
    return sponsorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SponsorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SponsorRepository>(value),
    );
  }
}

String _$sponsorRepositoryHash() => r'46642c108219226af5ad6d71e1509f1a0b43ebc2';

@ProviderFor(sponsorsList)
const sponsorsListProvider = SponsorsListProvider._();

final class SponsorsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SponsorModel>>,
          List<SponsorModel>,
          FutureOr<List<SponsorModel>>
        >
    with
        $FutureModifier<List<SponsorModel>>,
        $FutureProvider<List<SponsorModel>> {
  const SponsorsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sponsorsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sponsorsListHash();

  @$internal
  @override
  $FutureProviderElement<List<SponsorModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SponsorModel>> create(Ref ref) {
    return sponsorsList(ref);
  }
}

String _$sponsorsListHash() => r'294400d8c6a918fe7a3faedccbdee1d3d7823dfd';

@ProviderFor(SponsorSearchText)
const sponsorSearchTextProvider = SponsorSearchTextProvider._();

final class SponsorSearchTextProvider
    extends $NotifierProvider<SponsorSearchText, String> {
  const SponsorSearchTextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sponsorSearchTextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sponsorSearchTextHash();

  @$internal
  @override
  SponsorSearchText create() => SponsorSearchText();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$sponsorSearchTextHash() => r'ff8403d1e12d231a31b8b3ecc8feae28558c9873';

abstract class _$SponsorSearchText extends $Notifier<String> {
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

@ProviderFor(SponsorsViewType)
const sponsorsViewTypeProvider = SponsorsViewTypeProvider._();

final class SponsorsViewTypeProvider
    extends $NotifierProvider<SponsorsViewType, ListingViewType> {
  const SponsorsViewTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sponsorsViewTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sponsorsViewTypeHash();

  @$internal
  @override
  SponsorsViewType create() => SponsorsViewType();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingViewType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingViewType>(value),
    );
  }
}

String _$sponsorsViewTypeHash() => r'd9bab6cc1f1e11d86d5358e15ae21bbf1d5c5937';

abstract class _$SponsorsViewType extends $Notifier<ListingViewType> {
  ListingViewType build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ListingViewType, ListingViewType>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ListingViewType, ListingViewType>,
              ListingViewType,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
