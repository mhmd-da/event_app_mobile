import 'package:event_app/core/base/base_model.dart';


class SessionReminderModel extends BaseModel {
  final bool enabled;
  final int leadMinutes;

  SessionReminderModel({required this.enabled, required this.leadMinutes});

  factory SessionReminderModel.fromJson(Map<String, dynamic> json) {
    return SessionReminderModel(
      enabled: json['enabled'] as bool? ?? false,
      leadMinutes: json['leadMinutes'] as int? ?? 15,
    );
  }
}