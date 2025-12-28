import 'package:event_app/core/base/base_model.dart';

class AnnouncementModel extends BaseModel {
  final int id;
  final String title;
  final String message;
  final DateTime? date;

  AnnouncementModel({
    required this.id,
    required this.title,
    required this.message,
    this.date,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] as int,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
    );
  }
}
