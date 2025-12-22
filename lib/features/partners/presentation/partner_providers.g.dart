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
        isAutoDispose: true,
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

String _$partnersListHash() => r'7f1694f521b5c750c1e6bba00d6f42fa7fe3c567';
