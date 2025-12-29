import 'package:event_app/core/base/base_model.dart';

class MentorModel extends BaseModel {
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
  final List<MentorSocialLink>? socialLinks;
  final List<MentorSession> sessions;

  MentorModel({
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
    required this.socialLinks,
    required this.sessions,
  });

  factory MentorModel.fromJson(Map<String, dynamic> json) {
    return MentorModel(
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
      socialLinks: (json['socialLinks'] as List<dynamic>?)?.map((e) => MentorSocialLink.fromJson(e)).toList() ?? <MentorSocialLink>[],
      sessions: (json['sessions'] as List<dynamic>?)?.map((e) => MentorSession.fromJson(e)).toList() ?? <MentorSession>[],
    );
  }
}

class MentorSocialLink {
  final int id;
  final String? name;
  final String url;
  final String? thumbnail;

  MentorSocialLink({required this.id, this.name, required this.url, this.thumbnail});

  factory MentorSocialLink.fromJson(Map<String, dynamic> json) {
    return MentorSocialLink(
      id: json['id'] as int,
      name: json['name'],
      url: json['url'] ?? '',
      thumbnail: json['thumbnail'],
    );
  }
}

class MentorSession {
  final int id;
  final String title;
  final String startTime;
  final String endTime;
  final String? location;

  MentorSession({required this.id, required this.title, required this.startTime, required this.endTime, this.location});

  factory MentorSession.fromJson(Map<String, dynamic> json) {
    return MentorSession(
      id: json['id'] as int,
      title: json['title'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      location: json['location'],
    );
  }
}

