import 'package:event_app/core/base/base_model.dart';

class PersonModel extends BaseModel {
  final int id;
  final String title;
  final String gender;
  final String firstName;
  final String lastName;
  final String? bio;
  final String? position;
  final String? companyName;
  final String? profileImageUrl;
  final List<String> sessions;
  final String? linkedinUrl;
  final String? twitterUrl;

  PersonModel({
    required this.id,
    required this.title,
    required this.gender,
    required this.firstName,
    required this.lastName,
    this.bio,
    this.position,
    this.companyName,
    this.profileImageUrl,
    required this.sessions,
    this.linkedinUrl,
    this.twitterUrl,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] as int,
      title: json['title'] ?? '',
      gender: json['gender'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      bio: json['bio'],
      position: json['position'],
      companyName: json['companyName'],
      profileImageUrl: json['profileImageUrl'],
      sessions: (json['sessions'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
          <String>[],
      linkedinUrl: json['linkedinUrl'],
      twitterUrl: json['twitterUrl'],
    );
  }
}

