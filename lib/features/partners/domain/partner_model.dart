import 'package:event_app/core/base/base_model.dart';

class PartnerModel extends BaseModel {
  final int id;
  final String name;
  final String type;
  final String typeTag;
  final String logoUrl;
  final String? websiteUrl;
  final int displayOrder;
  final String? contactEmail;
  final String? contactMobile;
  final String? contactPhone;
  final String? contactName;
  final String? contactPosition;

  PartnerModel({
    required this.id,
    required this.name,
    required this.type,
    required this.typeTag,
    required this.logoUrl,
    required this.websiteUrl,
    required this.displayOrder,
    this.contactEmail,
    this.contactMobile,
    this.contactPhone,
    this.contactName,
    this.contactPosition,
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
      contactEmail: json['contactEmail'],
      contactMobile: json['contactMobile'],
      contactPhone: json['contactPhone'],
      contactName: json['contactName'],
      contactPosition: json['contactPosition'],
    );
  }
}
