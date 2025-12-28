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
        isAutoDispose: true,
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

String _$speakersListHash() => r'bd71c26f7f9bb37dcabb84919df62b640b38bf11';

@ProviderFor(speakersListBySearch)
const speakersListBySearchProvider = SpeakersListBySearchFamily._();

final class SpeakersListBySearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpeakerModel>>,
          List<SpeakerModel>,
          FutureOr<List<SpeakerModel>>
        >
    with
        $FutureModifier<List<SpeakerModel>>,
        $FutureProvider<List<SpeakerModel>> {
  const SpeakersListBySearchProvider._({
    required SpeakersListBySearchFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'speakersListBySearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$speakersListBySearchHash();

  @override
  String toString() {
    return r'speakersListBySearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SpeakerModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpeakerModel>> create(Ref ref) {
    final argument = this.argument as String?;
    return speakersListBySearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpeakersListBySearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$speakersListBySearchHash() =>
    r'ed4a1ded76ee4b74e1516f79c59f461531824f2c';

final class SpeakersListBySearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SpeakerModel>>, String?> {
  const SpeakersListBySearchFamily._()
    : super(
        retry: null,
        name: r'speakersListBySearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SpeakersListBySearchProvider call(String? search) =>
      SpeakersListBySearchProvider._(argument: search, from: this);

  @override
  String toString() => r'speakersListBySearchProvider';
}

@ProviderFor(speakerDetails)
const speakerDetailsProvider = SpeakerDetailsFamily._();

final class SpeakerDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<SpeakerDetailsModel>,
          SpeakerDetailsModel,
          FutureOr<SpeakerDetailsModel>
        >
    with
        $FutureModifier<SpeakerDetailsModel>,
        $FutureProvider<SpeakerDetailsModel> {
  const SpeakerDetailsProvider._({
    required SpeakerDetailsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'speakerDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$speakerDetailsHash();

  @override
  String toString() {
    return r'speakerDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SpeakerDetailsModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SpeakerDetailsModel> create(Ref ref) {
    final argument = this.argument as int;
    return speakerDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpeakerDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$speakerDetailsHash() => r'7daaf53e00bc0a7c51f782a22edda031f4e70fdd';

final class SpeakerDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SpeakerDetailsModel>, int> {
  const SpeakerDetailsFamily._()
    : super(
        retry: null,
        name: r'speakerDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SpeakerDetailsProvider call(int speakerId) =>
      SpeakerDetailsProvider._(argument: speakerId, from: this);

  @override
  String toString() => r'speakerDetailsProvider';
}

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
