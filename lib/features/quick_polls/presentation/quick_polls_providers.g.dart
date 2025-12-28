// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quick_polls_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(quickPollsRepository)
const quickPollsRepositoryProvider = QuickPollsRepositoryProvider._();

final class QuickPollsRepositoryProvider
    extends
        $FunctionalProvider<
          QuickPollsRepository,
          QuickPollsRepository,
          QuickPollsRepository
        >
    with $Provider<QuickPollsRepository> {
  const QuickPollsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quickPollsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quickPollsRepositoryHash();

  @$internal
  @override
  $ProviderElement<QuickPollsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  QuickPollsRepository create(Ref ref) {
    return quickPollsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuickPollsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuickPollsRepository>(value),
    );
  }
}

String _$quickPollsRepositoryHash() =>
    r'9846f4be1a3e2050572837e7e4894956c86fcf9d';

@ProviderFor(quickPollsForSession)
const quickPollsForSessionProvider = QuickPollsForSessionFamily._();

final class QuickPollsForSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<QuickPollModel>>,
          List<QuickPollModel>,
          FutureOr<List<QuickPollModel>>
        >
    with
        $FutureModifier<List<QuickPollModel>>,
        $FutureProvider<List<QuickPollModel>> {
  const QuickPollsForSessionProvider._({
    required QuickPollsForSessionFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'quickPollsForSessionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quickPollsForSessionHash();

  @override
  String toString() {
    return r'quickPollsForSessionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<QuickPollModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<QuickPollModel>> create(Ref ref) {
    final argument = this.argument as int;
    return quickPollsForSession(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is QuickPollsForSessionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quickPollsForSessionHash() =>
    r'fc8c2f5aa223ac5a0ceeca0deb322884dd6d84bb';

final class QuickPollsForSessionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<QuickPollModel>>, int> {
  const QuickPollsForSessionFamily._()
    : super(
        retry: null,
        name: r'quickPollsForSessionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuickPollsForSessionProvider call(int sessionId) =>
      QuickPollsForSessionProvider._(argument: sessionId, from: this);

  @override
  String toString() => r'quickPollsForSessionProvider';
}

@ProviderFor(QuickPollController)
const quickPollControllerProvider = QuickPollControllerFamily._();

final class QuickPollControllerProvider
    extends $NotifierProvider<QuickPollController, QuickPollState> {
  const QuickPollControllerProvider._({
    required QuickPollControllerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'quickPollControllerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$quickPollControllerHash();

  @override
  String toString() {
    return r'quickPollControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  QuickPollController create() => QuickPollController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QuickPollState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QuickPollState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is QuickPollControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$quickPollControllerHash() =>
    r'4c96dfda0f4997bd4952195cc31c29f61d87f3f0';

final class QuickPollControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          QuickPollController,
          QuickPollState,
          QuickPollState,
          QuickPollState,
          int
        > {
  const QuickPollControllerFamily._()
    : super(
        retry: null,
        name: r'quickPollControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  QuickPollControllerProvider call(int sessionId) =>
      QuickPollControllerProvider._(argument: sessionId, from: this);

  @override
  String toString() => r'quickPollControllerProvider';
}

abstract class _$QuickPollController extends $Notifier<QuickPollState> {
  late final _$args = ref.$arg as int;
  int get sessionId => _$args;

  QuickPollState build(int sessionId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<QuickPollState, QuickPollState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<QuickPollState, QuickPollState>,
              QuickPollState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
