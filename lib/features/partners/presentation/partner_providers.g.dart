// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(partnerRepository)
const partnerRepositoryProvider = PartnerRepositoryProvider._();

final class PartnerRepositoryProvider
    extends
        $FunctionalProvider<
          PartnerRepository,
          PartnerRepository,
          PartnerRepository
        >
    with $Provider<PartnerRepository> {
  const PartnerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'partnerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$partnerRepositoryHash();

  @$internal
  @override
  $ProviderElement<PartnerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PartnerRepository create(Ref ref) {
    return partnerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PartnerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PartnerRepository>(value),
    );
  }
}

String _$partnerRepositoryHash() => r'ed938ab85a8806237dc22793da306244e442ef4d';

@ProviderFor(partnersList)
const partnersListProvider = PartnersListProvider._();

final class PartnersListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PartnerModel>>,
          List<PartnerModel>,
          FutureOr<List<PartnerModel>>
        >
    with
        $FutureModifier<List<PartnerModel>>,
        $FutureProvider<List<PartnerModel>> {
  const PartnersListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'partnersListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$partnersListHash();

  @$internal
  @override
  $FutureProviderElement<List<PartnerModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PartnerModel>> create(Ref ref) {
    return partnersList(ref);
  }
}

String _$partnersListHash() => r'ac4bc3d651d19155934f4ce954bcace02a75625a';

@ProviderFor(PartnerSearchText)
const partnerSearchTextProvider = PartnerSearchTextProvider._();

final class PartnerSearchTextProvider
    extends $NotifierProvider<PartnerSearchText, String> {
  const PartnerSearchTextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'partnerSearchTextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$partnerSearchTextHash();

  @$internal
  @override
  PartnerSearchText create() => PartnerSearchText();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$partnerSearchTextHash() => r'4a5030aca7a672d519bd1e9449f5675312e09531';

abstract class _$PartnerSearchText extends $Notifier<String> {
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

@ProviderFor(PartnersViewType)
const partnersViewTypeProvider = PartnersViewTypeProvider._();

final class PartnersViewTypeProvider
    extends $NotifierProvider<PartnersViewType, ListingViewType> {
  const PartnersViewTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'partnersViewTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$partnersViewTypeHash();

  @$internal
  @override
  PartnersViewType create() => PartnersViewType();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingViewType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingViewType>(value),
    );
  }
}

String _$partnersViewTypeHash() => r'd4f0441affef45541e70bb4a9d3b3164ee7160fc';

abstract class _$PartnersViewType extends $Notifier<ListingViewType> {
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
