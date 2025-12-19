import 'package:event_app/core/base/base_model.dart';

class PartnerModel extends BaseModel {
  final int id;
  final String name;
  final String type;
  final String typeTag;
  final String logoUrl;
  final String? websiteUrl;
  final int displayOrder;

  PartnerModel({
    required this.id,
    required this.name,
    required this.type,
    required this.typeTag,
    required this.logoUrl,
    required this.websiteUrl,
    required this.displayOrder,
  });

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      typeTag: json['typeTag'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
      websiteUrl: json['websiteUrl'],
      displayOrder: json['displayOrder'] ?? 0,
    );
  }
}
