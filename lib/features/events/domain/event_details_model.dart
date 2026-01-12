import 'package:event_app/core/utilities/date_time_parsing.dart';

class EventExtra {
  final int? speakers;
  final int? guidanceHours;
  final int? workshopsExperiences;
  final int? participatingEntities;
  final int? volunteers;

  EventExtra({
    this.speakers,
    this.guidanceHours,
    this.workshopsExperiences,
    this.participatingEntities,
    this.volunteers,
  });

  factory EventExtra.fromJson(Map<String, dynamic> json) {
    return EventExtra(
      speakers: json['speakers'] as int?,
      guidanceHours: json['guidanceHours'] as int?,
      workshopsExperiences: json['workshopsExperiences'] as int?,
      participatingEntities: json['participatingEntities'] as int?,
      volunteers: json['volunteers'] as int?,
    );
  }
}

class EventDetailsModel {
  final int id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String? bannerImageUrl;
  final Venue? venue;
  final EventExtra? extra;

  EventDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.venue,
    required this.startDate,
    required this.endDate,
    required this.bannerImageUrl,
    this.extra,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) {
    return EventDetailsModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      venue: json['venue'] != null ? Venue.fromJson(json['venue']) : null,
      startDate: AppDateTimeParsing.parseServerToLocalOrEpoch(
        json['startDate'] as String?,
      ),
      endDate: AppDateTimeParsing.parseServerToLocalOrEpoch(
        json['endDate'] as String?,
      ),
      bannerImageUrl: json['bannerImageUrl'] as String?,
      extra: json['extra'] != null ? EventExtra.fromJson(json['extra']) : null,
    );
  }
}

// class EventDaySchedule {
//   final DateTime day;
//   final List<EventCategorySchedule> categories;

//   EventDaySchedule({
//     required this.day,
//     required this.categories,
//   });

//   factory EventDaySchedule.fromJson(Map<String, dynamic> json) {
//     return EventDaySchedule(
//       day: DateTime.parse(json['day'] as String),
//       categories: (json['categories'] as List<dynamic>)
//           .map((c) => EventCategorySchedule.fromJson(c as Map<String, dynamic>))
//           .toList(),
//     );
//   }
// }

// class EventCategorySchedule {
//   final String category;
//   final List<EventSession> sessions;

//   EventCategorySchedule({
//     required this.category,
//     required this.sessions,
//   });

//   factory EventCategorySchedule.fromJson(Map<String, dynamic> json) {
//     return EventCategorySchedule(
//       category: json['category'] as String,
//       sessions: (json['sessions'] as List<dynamic>)
//           .map((s) => EventSession.fromJson(s as Map<String, dynamic>))
//           .toList(),
//     );
//   }
// }

// class EventSession {
//   final int id;
//   final String name;
//   final String location;
//   final String startTime;
//   final String endTime;

//   EventSession({
//     required this.id,
//     required this.name,
//     required this.location,
//     required this.startTime,
//     required this.endTime,
//   });

//   factory EventSession.fromJson(Map<String, dynamic> json) {
//     return EventSession(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       location: json['location'] as String,
//       startTime: json['startTime'] as String,
//       endTime: json['endTime'] as String,
//     );
//   }
// }

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
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
