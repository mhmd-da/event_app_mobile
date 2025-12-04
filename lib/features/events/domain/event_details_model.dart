import 'dart:ffi';

class EventDetailsModel {
  final int id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String? bannerImageUrl;
  final List<EventDaySchedule> schedule;
  final Venue? venue;

  EventDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.venue,
    required this.startDate,
    required this.endDate,
    required this.bannerImageUrl,
    required this.schedule,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return EventDetailsModel(
      id: data['id'] as int,
      name: data['name'] as String,
      description: data['description'] as String?,
      venue: data['venue'] != null ? Venue.fromJson(data['venue']) : null,
      startDate: DateTime.parse(data['startDate'] as String),
      endDate: DateTime.parse(data['endDate'] as String),
      bannerImageUrl: data['bannerImageUrl'] as String?,
      schedule: (data['schedule'] as List<dynamic>)
          .map((e) => EventDaySchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EventDaySchedule {
  final DateTime day;
  final List<EventCategorySchedule> categories;

  EventDaySchedule({
    required this.day,
    required this.categories,
  });

  factory EventDaySchedule.fromJson(Map<String, dynamic> json) {
    return EventDaySchedule(
      day: DateTime.parse(json['day'] as String),
      categories: (json['categories'] as List<dynamic>)
          .map((c) => EventCategorySchedule.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EventCategorySchedule {
  final String category;
  final List<EventSession> sessions;

  EventCategorySchedule({
    required this.category,
    required this.sessions,
  });

  factory EventCategorySchedule.fromJson(Map<String, dynamic> json) {
    return EventCategorySchedule(
      category: json['category'] as String,
      sessions: (json['sessions'] as List<dynamic>)
          .map((s) => EventSession.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }
}

class EventSession {
  final int id;
  final String name;
  final String location;
  final String startTime;
  final String endTime;

  EventSession({
    required this.id,
    required this.name,
    required this.location,
    required this.startTime,
    required this.endTime,
  });

  factory EventSession.fromJson(Map<String, dynamic> json) {
    return EventSession(
      id: json['id'] as int,
      name: json['name'] as String,
      location: json['location'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );
  }
}





class Venue {
  final int id;
  final String name;
  final String? mapUrl;
  final List<FloorPlan>? floorPlans;

  Venue({required this.id, required this.name, this.mapUrl, this.floorPlans});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      id: json['id'] as int,
      name: json['name'] as String,
      mapUrl: json['mapUrl'] as String?,
      floorPlans: (json['floorPlans'] as List<dynamic>)
          .map((c) => FloorPlan.fromJson(c as Map<String, dynamic>))
          .toList(),
    );
  }
}

class FloorPlan {
  final int id;
  final String name;
  final String? imageUrl;

  FloorPlan({required this.id, required this.name, this.imageUrl});

  factory FloorPlan.fromJson(Map<String, dynamic> json) {
    return FloorPlan(
        id: json['id'] as int,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String?
    );
  }
}