import 'package:event_app/core/base/base_model.dart';

class AppNotification extends BaseModel {
  final int id;
  final String title;
  final String body;
  final String type;
  final DateTime sentAt;
  final bool read;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.sentAt,
    required this.read,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'] as int,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      type: json['type'] ?? '',
      sentAt: DateTime.tryParse(json['sentAt'] ?? '') ?? DateTime.now(),
      read: json['read'] == true,
    );
  }
}
