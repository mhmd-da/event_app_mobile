import 'package:event_app/core/base/base_model.dart';
import 'package:event_app/core/utilities/date_time_parsing.dart';

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
  final List<SpeakerSocialLink> socialLinks;
  final List<SpeakerSession> sessions;
  final DateTime? lastUpdatedDate;

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
    required this.socialLinks,
    required this.sessions,
    this.lastUpdatedDate,
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
      socialLinks: (json['socialLinks'] as List<dynamic>?)?.map((e) => SpeakerSocialLink.fromJson(e)).toList() ?? <SpeakerSocialLink>[],
      sessions: (json['sessions'] as List<dynamic>?)?.map((e) => SpeakerSession.fromJson(e)).toList() ?? <SpeakerSession>[],
      lastUpdatedDate: json['lastUpdatedDate'] != null
          ? AppDateTimeParsing.parseServerToLocalOrEpoch(json['lastUpdatedDate'])
          : null,
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

