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

@ProviderFor(SessionRegistrationState)
const sessionRegistrationStateProvider = SessionRegistrationStateFamily._();

final class SessionRegistrationStateProvider
    extends $NotifierProvider<SessionRegistrationState, bool> {
  const SessionRegistrationStateProvider._({
    required SessionRegistrationStateFamily super.from,
    required SessionModel super.argument,
  }) : super(
         retry: null,
         name: r'sessionRegistrationStateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sessionRegistrationStateHash();

  @override
  String toString() {
    return r'sessionRegistrationStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SessionRegistrationState create() => SessionRegistrationState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SessionRegistrationStateProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sessionRegistrationStateHash() =>
    r'614a7c51c2fdffef5845cfe3f0f7d04a59c324e2';

final class SessionRegistrationStateFamily extends $Family
    with
        $ClassFamilyOverride<
          SessionRegistrationState,
          bool,
          bool,
          bool,
          SessionModel
        > {
  const SessionRegistrationStateFamily._()
    : super(
        retry: null,
        name: r'sessionRegistrationStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SessionRegistrationStateProvider call(SessionModel session) =>
      SessionRegistrationStateProvider._(argument: session, from: this);

  @override
  String toString() => r'sessionRegistrationStateProvider';
}

abstract class _$SessionRegistrationState extends $Notifier<bool> {
  late final _$args = ref.$arg as SessionModel;
  SessionModel get session => _$args;

  bool build(SessionModel session);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
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

@ProviderFor(SessionChatMembership)
const sessionChatMembershipProvider = SessionChatMembershipFamily._();

final class SessionChatMembershipProvider
    extends $NotifierProvider<SessionChatMembership, bool> {
  const SessionChatMembershipProvider._({
    required SessionChatMembershipFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'sessionChatMembershipProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sessionChatMembershipHash();

  @override
  String toString() {
    return r'sessionChatMembershipProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SessionChatMembership create() => SessionChatMembership();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SessionChatMembershipProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sessionChatMembershipHash() =>
    r'3bbde41a85b08b05aeed017594039e1cd6fa3eb6';

final class SessionChatMembershipFamily extends $Family
    with $ClassFamilyOverride<SessionChatMembership, bool, bool, bool, int> {
  const SessionChatMembershipFamily._()
    : super(
        retry: null,
        name: r'sessionChatMembershipProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SessionChatMembershipProvider call(int sessionId) =>
      SessionChatMembershipProvider._(argument: sessionId, from: this);

  @override
  String toString() => r'sessionChatMembershipProvider';
}

abstract class _$SessionChatMembership extends $Notifier<bool> {
  late final _$args = ref.$arg as int;
  int get sessionId => _$args;

  bool build(int sessionId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
