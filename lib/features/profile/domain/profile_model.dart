import 'package:event_app/core/base/base_model.dart';

class Profile extends BaseModel{
  final int id;
  final String? gender;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? profileImageUrl;
  final String? university;
  final String? department;
  final String? major;

  Profile({
    required this.id,
    required this.gender,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.profileImageUrl,
    required this.university,
    required this.department,
    required this.major,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      gender: json['gender'],
      title: json['title'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      bio: json['bio'],
      profileImageUrl: json['profileImageUrl'],
      university: json['university'],
      department: json['department'],
      major: json['major']
    );
  }
}