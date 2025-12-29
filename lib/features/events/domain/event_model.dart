import 'package:event_app/core/base/base_model.dart';

class EventModel extends BaseModel {
  final int id;
  final String name;
  final String? location;
  final DateTime startDate;
  final DateTime endDate;
  final String? bannerImageUrl;

  EventModel({
    required this.id,
    required this.name,
    this.location,
    required this.startDate,
    required this.endDate,
    this.bannerImageUrl,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      location: json['location'],
      startDate: DateTime.parse(json['startDate']).toLocal(),
      endDate: DateTime.parse(json['endDate']).toLocal(),
      bannerImageUrl: json['bannerImageUrl'],
    );
  }
}
