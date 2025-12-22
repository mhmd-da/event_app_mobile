// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faqs_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(faqsRepository)
const faqsRepositoryProvider = FaqsRepositoryProvider._();

final class FaqsRepositoryProvider
    extends $FunctionalProvider<FaqsRepository, FaqsRepository, FaqsRepository>
    with $Provider<FaqsRepository> {
  const FaqsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'faqsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$faqsRepositoryHash();

  @$internal
  @override
  $ProviderElement<FaqsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FaqsRepository create(Ref ref) {
    return faqsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FaqsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FaqsRepository>(value),
    );
  }
}

String _$faqsRepositoryHash() => r'061b72894359321a86516d621df059f301ffde11';

@ProviderFor(faqsList)
const faqsListProvider = FaqsListProvider._();

final class FaqsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Faq>>,
          List<Faq>,
          FutureOr<List<Faq>>
        >
    with $FutureModifier<List<Faq>>, $FutureProvider<List<Faq>> {
  const FaqsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'faqsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$faqsListHash();

  @$internal
  @override
  $FutureProviderElement<List<Faq>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Faq>> create(Ref ref) {
    return faqsList(ref);
  }
}

String _$faqsListHash() => r'caaf749d915d0d420a953d89e2e78e7f5260c028';
