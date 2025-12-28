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

@ProviderFor(mentorDetails)
const mentorDetailsProvider = MentorDetailsFamily._();

final class MentorDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MentorDetailsModel>,
          MentorDetailsModel,
          FutureOr<MentorDetailsModel>
        >
    with
        $FutureModifier<MentorDetailsModel>,
        $FutureProvider<MentorDetailsModel> {
  const MentorDetailsProvider._({
    required MentorDetailsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'mentorDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mentorDetailsHash();

  @override
  String toString() {
    return r'mentorDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MentorDetailsModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MentorDetailsModel> create(Ref ref) {
    final argument = this.argument as int;
    return mentorDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MentorDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mentorDetailsHash() => r'17a57d3e927e52e63ec6ddd19c52fd447c71a399';

final class MentorDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MentorDetailsModel>, int> {
  const MentorDetailsFamily._()
    : super(
        retry: null,
        name: r'mentorDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MentorDetailsProvider call(int mentorId) =>
      MentorDetailsProvider._(argument: mentorId, from: this);

  @override
  String toString() => r'mentorDetailsProvider';
}

@ProviderFor(MentorsViewType)
const mentorsViewTypeProvider = MentorsViewTypeProvider._();

final class MentorsViewTypeProvider
    extends $NotifierProvider<MentorsViewType, ListingViewType> {
  const MentorsViewTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorsViewTypeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorsViewTypeHash();

  @$internal
  @override
  MentorsViewType create() => MentorsViewType();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListingViewType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListingViewType>(value),
    );
  }
}

String _$mentorsViewTypeHash() => r'bc9f48ddc61a1e9e09c8c5f9622a3bd51d62c75b';

abstract class _$MentorsViewType extends $Notifier<ListingViewType> {
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

@ProviderFor(MentorSearchText)
const mentorSearchTextProvider = MentorSearchTextProvider._();

final class MentorSearchTextProvider
    extends $NotifierProvider<MentorSearchText, String> {
  const MentorSearchTextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorSearchTextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorSearchTextHash();

  @$internal
  @override
  MentorSearchText create() => MentorSearchText();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$mentorSearchTextHash() => r'13dfd23be158da8a171f793a7057a2df83d8282f';

abstract class _$MentorSearchText extends $Notifier<String> {
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
