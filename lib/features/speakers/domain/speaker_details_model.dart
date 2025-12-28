import 'package:event_app/core/base/base_model.dart';

class SpeakerDetailsModel extends BaseModel {
  final int id;
  final String title;
  final String gender;
  final String firstName;
  final String lastName;
  final String? bio;
  final String? position;
  final String? companyName;
  final String? profileImageUrl;
  final List<SpeakerSocialLink> socialLinks;
  final List<SpeakerSession> sessions;

  SpeakerDetailsModel({
    required this.id,
    required this.title,
    required this.gender,
    required this.firstName,
    required this.lastName,
    this.bio,
    this.position,
    this.companyName,
    this.profileImageUrl,
    required this.socialLinks,
    required this.sessions,
  });

  factory SpeakerDetailsModel.fromJson(Map<String, dynamic> json) {
    return SpeakerDetailsModel(
      id: json['id'] as int,
      title: json['title'] ?? '',
      gender: json['gender'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      bio: json['bio'],
      position: json['position'],
      companyName: json['companyName'],
      profileImageUrl: json['profileImageUrl'],
      socialLinks: (json['socialLinks'] as List<dynamic>?)?.map((e) => SpeakerSocialLink.fromJson(e)).toList() ?? <SpeakerSocialLink>[],
      sessions: (json['sessions'] as List<dynamic>?)?.map((e) => SpeakerSession.fromJson(e)).toList() ?? <SpeakerSession>[],
    );
  }
}

class SpeakerSocialLink {
  final int id;
  final String? name;
  final String url;
  final String? thumbnail;

  SpeakerSocialLink({required this.id, this.name, required this.url, this.thumbnail});

  factory SpeakerSocialLink.fromJson(Map<String, dynamic> json) {
    return SpeakerSocialLink(
      id: json['id'] as int,
      name: json['name'],
      url: json['url'] ?? '',
      thumbnail: json['thumbnail'],
    );
  }
}

class SpeakerSession {
  final int id;
  final String title;
  final String startTime;
  final String endTime;
  final String? location;

  SpeakerSession({required this.id, required this.title, required this.startTime, required this.endTime, this.location});

  factory SpeakerSession.fromJson(Map<String, dynamic> json) {
    return SpeakerSession(
      id: json['id'] as int,
      title: json['title'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      location: json['location'],
    );
  }
}

