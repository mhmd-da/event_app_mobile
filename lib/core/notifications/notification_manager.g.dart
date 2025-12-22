// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Riverpod provider for NotificationManager

@ProviderFor(notificationManager)
const notificationManagerProvider = NotificationManagerProvider._();

/// Riverpod provider for NotificationManager

final class NotificationManagerProvider
    extends
        $FunctionalProvider<
          NotificationManager,
          NotificationManager,
          NotificationManager
        >
    with $Provider<NotificationManager> {
  /// Riverpod provider for NotificationManager
  const NotificationManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationManagerHash();

  @$internal
  @override
  $ProviderElement<NotificationManager> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationManager create(Ref ref) {
    return notificationManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationManager value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationManager>(value),
    );
  }
}

String _$notificationManagerHash() =>
    r'8b5b4f6ef4c65d98c8512e116ff99e3e9e1f0f3c';
