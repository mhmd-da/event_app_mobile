class MyScheduleModel {
  final int bookingId;
  final int? sessionId;
  final int? mentorSlotId;
  final String type;
  final String? sessionName;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final List<Person> speakersOrMentors;

  MyScheduleModel({
    required this.bookingId,
    required this.sessionId,
    required this.mentorSlotId,
    required this.type,
    required this.sessionName,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.speakersOrMentors,
  });

  factory MyScheduleModel.fromJson(Map<String, dynamic> json) {
    return MyScheduleModel(
      bookingId: json['bookingId'],
      sessionId: json['sessionId'],
      mentorSlotId: json['mentorSlotId'],
      type: json['type'] ?? '',
      sessionName: json['sessionName'] ?? '',
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      location: json['location'] ?? '',
      speakersOrMentors: (json['speakersOrMentors'] as List?)
          ?.map((s) => Person.fromJson(s))
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
