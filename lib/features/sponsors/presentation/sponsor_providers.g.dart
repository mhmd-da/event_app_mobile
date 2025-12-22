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
