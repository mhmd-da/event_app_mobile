import 'package:event_app/core/storage/secure_storage_service.dart';
import 'package:event_app/features/notifications/presentation/notifications_providers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_manager.g.dart';

/// Riverpod provider for NotificationManager
@Riverpod(keepAlive: true)
NotificationManager notificationManager(Ref ref) => NotificationManager(ref);

class NotificationManager {
  final Ref ref;
  NotificationManager(this.ref);

  static final _fcm = FirebaseMessaging.instance;

  /// Initialize Firebase Cloud Messaging and register the device token.
  Future<void> initializeFCM() async {
    // Request permissions (iOS)
    await _fcm.requestPermission();

    // Get FCM token
    final token = await _fcm.getToken();

    if (token != null) {
      SecureStorageService().saveFcmToken(token);
    }

    // Listen for foreground notifications
    FirebaseMessaging.onMessage.listen((message) {
      ref.read(unreadBadgeCountProvider.notifier).increment(1);
      LocalNotificationService.show(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });
  }
}
