import 'package:event_app/core/base/base_model.dart';

class SessionModel extends BaseModel {
  final int id;
  final String? name;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String category;
  final bool isRegistered;
  final List<Person> speakers;
  final List<Person> mentors;
  final List<Sponsor> sponsors;
  final List<Partner> partners;

  SessionModel({
    required this.id,
    this.name,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.category,
    required this.isRegistered,
    required this.speakers,
    required this.mentors,
    required this.sponsors,
    required this.partners,
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
