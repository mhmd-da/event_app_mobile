import 'package:event_app/core/base/base_model.dart';

class SponsorModel extends BaseModel {
  final int id;
  final String name;
  final String category;
  final String categoryTag;
  final String logoUrl;
  final String? websiteUrl;
  final int displayOrder;

  SponsorModel({
    required this.id,
    required this.name,
    required this.category,
    required this.categoryTag,
    required this.logoUrl,
    required this.websiteUrl,
    required this.displayOrder,
  });

  factory SponsorModel.fromJson(Map<String, dynamic> json) {
    return SponsorModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      categoryTag: json['categoryTag'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      websiteUrl: json['websiteUrl'],
      displayOrder: json['displayOrder'] ?? 0,
    );
  }
}
