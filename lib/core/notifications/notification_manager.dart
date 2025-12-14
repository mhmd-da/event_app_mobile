import 'package:event_app/core/storage/secure_storage_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod provider for NotificationManager
final notificationManagerProvider = Provider<NotificationManager>((ref) {
  return NotificationManager(ref);
});

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
    print("FCM TOKEN = $token");

    if (token != null) {
      SecureStorageService().saveFcmToken(token);
    }

    // Listen for foreground notifications
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.show(
        title: message.notification?.title,
        body: message.notification?.body,
      );
    });
  }
}
