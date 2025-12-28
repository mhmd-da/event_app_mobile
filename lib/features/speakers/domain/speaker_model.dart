import 'package:event_app/core/base/base_model.dart';

class SpeakerModel extends BaseModel {
  final int id;
  final String gender;
  final String title;
  final String firstName;
  final String lastName;
  final String? email;
  final String? phoneNumber;
  final String? position;
  final String? companyName;
  final String? bio;
  final String? profileImageUrl;

  SpeakerModel({
    required this.id,
    required this.gender,
    required this.title,
    required this.firstName,
    required this.lastName,
    this.email,
    this.phoneNumber,
    this.position,
    this.companyName,
    this.bio,
    this.profileImageUrl,
  });

  factory SpeakerModel.fromJson(Map<String, dynamic> json) {
    return SpeakerModel(
      id: json['id'] as int,
      gender: json['gender'] ?? '',
      title: json['title'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      position: json['position'],
      companyName: json['companyName'],
      bio: json['bio'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}
