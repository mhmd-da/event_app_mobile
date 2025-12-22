// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mentorRepository)
const mentorRepositoryProvider = MentorRepositoryProvider._();

final class MentorRepositoryProvider
    extends
        $FunctionalProvider<
          MentorRepository,
          MentorRepository,
          MentorRepository
        >
    with $Provider<MentorRepository> {
  const MentorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorRepositoryHash();

  @$internal
  @override
  $ProviderElement<MentorRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MentorRepository create(Ref ref) {
    return mentorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MentorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MentorRepository>(value),
    );
  }
}

String _$mentorRepositoryHash() => r'99b67baa23f94907c90d1293592d34ff27431352';

@ProviderFor(mentorsList)
const mentorsListProvider = MentorsListProvider._();

final class MentorsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MentorModel>>,
          List<MentorModel>,
          FutureOr<List<MentorModel>>
        >
    with
        $FutureModifier<List<MentorModel>>,
        $FutureProvider<List<MentorModel>> {
  const MentorsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorsListHash();

  @$internal
  @override
  $FutureProviderElement<List<MentorModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MentorModel>> create(Ref ref) {
    return mentorsList(ref);
  }
}

String _$mentorsListHash() => r'1bc6493c39428d7dcfb5df110540f98cb6c99814';
