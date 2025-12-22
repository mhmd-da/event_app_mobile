import 'package:event_app/core/base/base_model.dart';

class EventPhotoModel extends BaseModel{
  final int id;
  final String imageUrl;
  final String thumbnailUrl;
  final String caption;
  final int? sortOrder;

  EventPhotoModel({
    required this.id,
    required this.imageUrl,
    required this.thumbnailUrl,
    required this.caption,
    this.sortOrder,
  });

  factory EventPhotoModel.fromJson(Map<String, dynamic> json) {
    return EventPhotoModel(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      caption: json['caption'] ?? '',
      sortOrder: json['sortOrder'] as int?,
    );
  }
}
