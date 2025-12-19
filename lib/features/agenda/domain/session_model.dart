import 'package:event_app/core/base/base_model.dart';

class SessionModel extends BaseModel {
  final int id;
  final String? name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String category;
  final String categoryTag;
  final String track;
  final bool isRegistered;
  final List<Person> speakers;
  final List<Person> mentors;
  final List<Sponsor> sponsors;
  final List<Partner> partners;
  final List<SessionMaterial> materials;

  SessionModel({
    required this.id,
    this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.category,
    required this.categoryTag,
    required this.track,
    required this.isRegistered,
    required this.speakers,
    required this.mentors,
    required this.sponsors,
    required this.partners,
    required this.materials,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      categoryTag: json['categoryTag'] ?? '',
      track: json['track'] ?? '',
      isRegistered: json['isRegistered'] ?? false,
      speakers: (json['speakers'] as List?)
          ?.map((s) => Person.fromJson(s))
          .toList() ??
          [],
      mentors: (json['mentors'] as List?)
          ?.map((m) => Person.fromJson(m))
          .toList() ??
          [],
      sponsors: (json['sponsors'] as List?)
          ?.map((s) => Sponsor.fromJson(s))
          .toList() ??
          [],
      partners: (json['partners' ] as List?)
          ?.map((p) => Partner.fromJson(p))
          .toList() ??
          [],
      materials: (json['materials'] as List?)
          ?.map((m) => SessionMaterial.fromJson(m))
          .toList() ??
          [],
    );
  }
}

class Person {
  final String title;
  final String firstName;
  final String lastName;
  final String profileImageUrl;

  Person({required this.title, required this.firstName, required this.lastName, required this.profileImageUrl});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      title: json['title'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
    );
  }
}

class Sponsor {
  final String name;
  final String logoUrl;

  Sponsor({required this.name, required this.logoUrl});

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      name: json['name'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
    );
  }
}

class Partner {
  final String name;
  final String logoUrl;

  Partner({required this.name, required this.logoUrl});

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      name: json['name'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
    );
  }
}

class SessionMaterial {
  final String name;
  final String url;
  final String type;

  SessionMaterial({required this.name, required this.url, required this.type});

  factory SessionMaterial.fromJson(Map<String, dynamic> json) {
    return SessionMaterial(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
