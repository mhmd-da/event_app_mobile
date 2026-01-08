// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sessionRepository)
const sessionRepositoryProvider = SessionRepositoryProvider._();

final class SessionRepositoryProvider
    extends
        $FunctionalProvider<
          SessionRepository,
          SessionRepository,
          SessionRepository
        >
    with $Provider<SessionRepository> {
  const SessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionRepositoryHash();

  @$internal
  @override
  $ProviderElement<SessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SessionRepository create(Ref ref) {
    return sessionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionRepository>(value),
    );
  }
}

String _$sessionRepositoryHash() => r'87ea02e08955dc2737bb405a1175bb746287cbcc';

@ProviderFor(sessionsForAgendaList)
const sessionsForAgendaListProvider = SessionsForAgendaListFamily._();

final class SessionsForAgendaListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SessionModel>>,
          List<SessionModel>,
          FutureOr<List<SessionModel>>
        >
    with
        $FutureModifier<List<SessionModel>>,
        $FutureProvider<List<SessionModel>> {
  const SessionsForAgendaListProvider._({
    required SessionsForAgendaListFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'sessionsForAgendaListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sessionsForAgendaListHash();

  @override
  String toString() {
    return r'sessionsForAgendaListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SessionModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SessionModel>> create(Ref ref) {
    final argument = this.argument as String?;
    return sessionsForAgendaList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionsForAgendaListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sessionsForAgendaListHash() =>
    r'64f4f2a27cb07926cade02604d4d0e139891b48b';

final class SessionsForAgendaListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SessionModel>>, String?> {
  const SessionsForAgendaListFamily._()
    : super(
        retry: null,
        name: r'sessionsForAgendaListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SessionsForAgendaListProvider call(String? category) =>
      SessionsForAgendaListProvider._(argument: category, from: this);

  @override
  String toString() => r'sessionsForAgendaListProvider';
}

@ProviderFor(SelectedAgendaDate)
const selectedAgendaDateProvider = SelectedAgendaDateProvider._();

final class SelectedAgendaDateProvider
    extends $NotifierProvider<SelectedAgendaDate, String?> {
  const SelectedAgendaDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedAgendaDateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedAgendaDateHash();

  @$internal
  @override
  SelectedAgendaDate create() => SelectedAgendaDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedAgendaDateHash() =>
    r'e4722f7db0f6839aca32acfd6135696d3c9bf20a';

abstract class _$SelectedAgendaDate extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(GroupingMethod)
const groupingMethodProvider = GroupingMethodProvider._();

final class GroupingMethodProvider
    extends $NotifierProvider<GroupingMethod, String> {
  const GroupingMethodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groupingMethodProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groupingMethodHash();

  @$internal
  @override
  GroupingMethod create() => GroupingMethod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$groupingMethodHash() => r'02987b2150cefbacd60a085ff673b1d08b6d3f68';

abstract class _$GroupingMethod extends $Notifier<String> {
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
