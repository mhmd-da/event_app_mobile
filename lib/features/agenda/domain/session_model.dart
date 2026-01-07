import 'package:event_app/core/base/base_model.dart';
import 'package:event_app/core/utilities/date_time_parsing.dart';

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
  final bool isChatMember;
  final bool hasQuickPolls;
  final int? currentBookings;
  final int? maxCapacity;
  final bool isMaxCapacityReached;
  final List<Person> speakers;
  final Person? mentor;
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
    this.isChatMember = false,
    this.hasQuickPolls = false,
    this.currentBookings,
    this.maxCapacity,
    this.isMaxCapacityReached = false,
    required this.speakers,
    this.mentor,
    required this.sponsors,
    required this.partners,
    required this.materials,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      startTime: AppDateTimeParsing.parseServerToLocalOrEpoch(
        json['startTime'],
      ),
      endTime: AppDateTimeParsing.parseServerToLocalOrEpoch(json['endTime']),
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      categoryTag: json['categoryTag'] ?? '',
      track: json['track'] ?? '',
      isRegistered: json['isRegistered'] ?? false,
      isChatMember: json['isChatMember'] ?? false,
      hasQuickPolls: json['hasQuickPolls'] ?? false,
      currentBookings: json['currentBookings'] ?? 0,
      maxCapacity: json['maxCapacity'] ?? json['MaxCapacity'],
      isMaxCapacityReached:
          json['isMaxCapacityReached'] ?? json['IsMaxCapacityReached'] ?? false,
      speakers:
          (json['speakers'] as List?)
              ?.map((s) => Person.fromJson(s))
              .toList() ??
          [],
      mentor: json['mentor'] != null
          ? Person.fromJson(json['mentor'])
          : ((json['mentors'] is List && (json['mentors'] as List).isNotEmpty)
                ? Person.fromJson((json['mentors'] as List).first)
                : null),
      sponsors:
          (json['sponsors'] as List?)
              ?.map((s) => Sponsor.fromJson(s))
              .toList() ??
          [],
      partners:
          (json['partners'] as List?)
              ?.map((p) => Partner.fromJson(p))
              .toList() ??
          [],
      materials:
          (json['materials'] as List?)
              ?.map((m) => SessionMaterial.fromJson(m))
              .toList() ??
          [],
    );
  }
}

class Person {
  final int? id;
  final String title;
  final String firstName;
  final String lastName;
  final String profileImageUrl;
  final bool isModerator;

  Person({
    this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.profileImageUrl,
    required this.isModerator,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      isModerator: json['isModerator'] ?? false,
    );
  }
}

class Sponsor {
  final int? id;
  final String name;
  final String logoUrl;

  Sponsor({this.id, required this.name, required this.logoUrl});

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] ?? '',
      logoUrl: json['logoUrl'] ?? '',
    );
  }
}

class Partner {
  final int? id;
  final String name;
  final String logoUrl;

  Partner({this.id, required this.name, required this.logoUrl});

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: (json['id'] as num?)?.toInt(),
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
