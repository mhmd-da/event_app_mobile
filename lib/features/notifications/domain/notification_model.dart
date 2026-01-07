import 'package:event_app/core/base/base_model.dart';
import 'package:event_app/core/utilities/date_time_parsing.dart';

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
      sentAt:
          AppDateTimeParsing.tryParseServerToLocal(json['sentAt']) ??
          DateTime.now(),
      read: json['read'] == true,
    );
  }

  AppNotification copyWith({
    String? title,
    String? body,
    String? type,
    DateTime? sentAt,
    bool? read,
  }) {
    return AppNotification(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      sentAt: sentAt ?? this.sentAt,
      read: read ?? this.read,
    );
  }
}
