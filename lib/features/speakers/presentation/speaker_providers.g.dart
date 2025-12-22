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
