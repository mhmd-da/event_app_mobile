// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationsRepository)
const notificationsRepositoryProvider = NotificationsRepositoryProvider._();

final class NotificationsRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationsRepository,
          NotificationsRepository,
          NotificationsRepository
        >
    with $Provider<NotificationsRepository> {
  const NotificationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationsRepository create(Ref ref) {
    return notificationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsRepository>(value),
    );
  }
}

String _$notificationsRepositoryHash() =>
    r'1f2c37b060faceb0c3669b1a54507578b35d8bcd';

/// Badge count shown in the app bar.
///
/// Null means "not initialized yet" and the UI can fall back to
/// [unreadCountProvider] (server value).

@ProviderFor(UnreadBadgeCount)
const unreadBadgeCountProvider = UnreadBadgeCountProvider._();

/// Badge count shown in the app bar.
///
/// Null means "not initialized yet" and the UI can fall back to
/// [unreadCountProvider] (server value).
final class UnreadBadgeCountProvider
    extends $NotifierProvider<UnreadBadgeCount, int?> {
  /// Badge count shown in the app bar.
  ///
  /// Null means "not initialized yet" and the UI can fall back to
  /// [unreadCountProvider] (server value).
  const UnreadBadgeCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadBadgeCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadBadgeCountHash();

  @$internal
  @override
  UnreadBadgeCount create() => UnreadBadgeCount();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$unreadBadgeCountHash() => r'8b2a93483454752887dbcc8a8013d5e53b8b9106';

/// Badge count shown in the app bar.
///
/// Null means "not initialized yet" and the UI can fall back to
/// [unreadCountProvider] (server value).

abstract class _$UnreadBadgeCount extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(NotificationsController)
const notificationsControllerProvider = NotificationsControllerProvider._();

final class NotificationsControllerProvider
    extends $NotifierProvider<NotificationsController, NotificationsState> {
  const NotificationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsControllerHash();

  @$internal
  @override
  NotificationsController create() => NotificationsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationsState>(value),
    );
  }
}

String _$notificationsControllerHash() =>
    r'4d28b54d0ab57e172acf66640ac60f6aa7405f0c';

abstract class _$NotificationsController extends $Notifier<NotificationsState> {
  NotificationsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<NotificationsState, NotificationsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NotificationsState, NotificationsState>,
              NotificationsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Server source-of-truth unread count (used as fallback before
/// [unreadBadgeCountProvider] is initialized).
///
/// NOTE: This is referenced by the generated `notifications_providers.g.dart`.

@ProviderFor(unreadCount)
const unreadCountProvider = UnreadCountProvider._();

/// Server source-of-truth unread count (used as fallback before
/// [unreadBadgeCountProvider] is initialized).
///
/// NOTE: This is referenced by the generated `notifications_providers.g.dart`.

final class UnreadCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Server source-of-truth unread count (used as fallback before
  /// [unreadBadgeCountProvider] is initialized).
  ///
  /// NOTE: This is referenced by the generated `notifications_providers.g.dart`.
  const UnreadCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return unreadCount(ref);
  }
}

String _$unreadCountHash() => r'7ae0a3ad8e1f2b3ba5e5983ca08092cf2a8dd460';
