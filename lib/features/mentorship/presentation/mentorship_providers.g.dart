// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentorship_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mentorshipRepository)
const mentorshipRepositoryProvider = MentorshipRepositoryProvider._();

final class MentorshipRepositoryProvider
    extends
        $FunctionalProvider<
          MentorshipRepository,
          MentorshipRepository,
          MentorshipRepository
        >
    with $Provider<MentorshipRepository> {
  const MentorshipRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorshipRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorshipRepositoryHash();

  @$internal
  @override
  $ProviderElement<MentorshipRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MentorshipRepository create(Ref ref) {
    return mentorshipRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MentorshipRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MentorshipRepository>(value),
    );
  }
}

String _$mentorshipRepositoryHash() =>
    r'9071d84e59e436c9b61ac5918c97171d168ce763';

@ProviderFor(mentorshipSessions)
const mentorshipSessionsProvider = MentorshipSessionsFamily._();

final class MentorshipSessionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MentorshipDetailsModel>,
          MentorshipDetailsModel,
          FutureOr<MentorshipDetailsModel>
        >
    with
        $FutureModifier<MentorshipDetailsModel>,
        $FutureProvider<MentorshipDetailsModel> {
  const MentorshipSessionsProvider._({
    required MentorshipSessionsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'mentorshipSessionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mentorshipSessionsHash();

  @override
  String toString() {
    return r'mentorshipSessionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MentorshipDetailsModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MentorshipDetailsModel> create(Ref ref) {
    final argument = this.argument as int;
    return mentorshipSessions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MentorshipSessionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mentorshipSessionsHash() =>
    r'8004caa40ff3b8befe7c1ceb2b496904536c0409';

final class MentorshipSessionsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MentorshipDetailsModel>, int> {
  const MentorshipSessionsFamily._()
    : super(
        retry: null,
        name: r'mentorshipSessionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MentorshipSessionsProvider call(int sessionId) =>
      MentorshipSessionsProvider._(argument: sessionId, from: this);

  @override
  String toString() => r'mentorshipSessionsProvider';
}
