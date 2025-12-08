import 'package:event_app/core/base/base_model.dart';

class MentorshipDetailsModel extends BaseModel {
  final Mentor mentor;
  final List<Slot> slots;

  MentorshipDetailsModel({
    required this.mentor,
    required this.slots,
  });

  factory MentorshipDetailsModel.fromJson(Map<String, dynamic> json) {
    return MentorshipDetailsModel(
      mentor: Mentor.fromJson(json['mentor']),
      slots: (json['slots'] as List<dynamic>).map((e) => Slot.fromJson(e)).toList(),
    );
  }
}

class Mentor {
  final int id;
  final String title;
  final String firstName;
  final String lastName;
  final String profileImageUrl;

  Mentor({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.profileImageUrl,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
      id: json['id'],
      title: json['title'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImageUrl: json['profileImageUrl'],
    );
  }
}

class Slot {
  final int slotId;
  final DateTime startTime;
  final DateTime endTime;
  final bool isBooked;
  final bool isAvailable;

  Slot({
    required this.slotId,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
    required this.isAvailable,
  });

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      slotId: json['slotId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      isBooked: json['isBooked'],
      isAvailable: json['isAvailable'],
    );
  }
}