// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(speakerRepository)
const speakerRepositoryProvider = SpeakerRepositoryProvider._();

final class SpeakerRepositoryProvider
    extends
        $FunctionalProvider<
          SpeakerRepository,
          SpeakerRepository,
          SpeakerRepository
        >
    with $Provider<SpeakerRepository> {
  const SpeakerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'speakerRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$speakerRepositoryHash();

  @$internal
  @override
  $ProviderElement<SpeakerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SpeakerRepository create(Ref ref) {
    return speakerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpeakerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpeakerRepository>(value),
    );
  }
}

String _$speakerRepositoryHash() => r'beba8b7f326f771d7a2633f860275bb77a3a1cc8';

@ProviderFor(speakersList)
const speakersListProvider = SpeakersListProvider._();

final class SpeakersListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpeakerModel>>,
          List<SpeakerModel>,
          FutureOr<List<SpeakerModel>>
        >
    with
        $FutureModifier<List<SpeakerModel>>,
        $FutureProvider<List<SpeakerModel>> {
  const SpeakersListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'speakersListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$speakersListHash();

  @$internal
  @override
  $FutureProviderElement<List<SpeakerModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpeakerModel>> create(Ref ref) {
    return speakersList(ref);
  }
}

String _$speakersListHash() => r'e72e3e471e62177da3bfaf8f0b5f6358074b7f03';

@ProviderFor(SpeakersViewType)
const speakersViewTypeProvider = SpeakersViewTypeProvider._();

final class SpeakersViewTypeProvider
    extends $NotifierProvider<SpeakersViewType, ListingViewType> {
  const SpeakersViewTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'speakersViewTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$speakersViewTypeHash();

  @$internal
  @override
  SpeakersViewType create() => SpeakersViewType();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingViewType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingViewType>(value),
    );
  }
}

String _$speakersViewTypeHash() => r'feaaca8eadefd5da3a7dfd0458eb5b739dd04e08';

abstract class _$SpeakersViewType extends $Notifier<ListingViewType> {
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

@ProviderFor(SpeakerSearchText)
const speakerSearchTextProvider = SpeakerSearchTextProvider._();

final class SpeakerSearchTextProvider
    extends $NotifierProvider<SpeakerSearchText, String> {
  const SpeakerSearchTextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'speakerSearchTextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$speakerSearchTextHash();

  @$internal
  @override
  SpeakerSearchText create() => SpeakerSearchText();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$speakerSearchTextHash() => r'd301611b1cdb2f93c6f6c753152ff0d189fd857f';

abstract class _$SpeakerSearchText extends $Notifier<String> {
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
