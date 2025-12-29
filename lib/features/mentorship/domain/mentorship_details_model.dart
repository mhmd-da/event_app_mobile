import 'package:event_app/core/base/base_model.dart';

class MentorshipDetailsModel extends BaseModel {
  final Mentor mentor;
  final List<Slot> slots;

  MentorshipDetailsModel({required this.mentor, required this.slots});

  factory MentorshipDetailsModel.fromJson(Map<String, dynamic> json) {
    return MentorshipDetailsModel(
      mentor: Mentor.fromJson((json['mentor'] as Map<String, dynamic>?) ?? const {}),
      slots:
          ((json['slots'] as List<dynamic>?) ?? const <dynamic>[]) // tolerate null
              .map((e) => Slot.fromJson((e as Map<String, dynamic>?) ?? const {}))
              .toList(),
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
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] as String?) ?? '',
      firstName: (json['firstName'] as String?) ?? '',
      lastName: (json['lastName'] as String?) ?? '',
      profileImageUrl: (json['profileImageUrl'] as String?) ?? '',
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
    final startRaw = json['startTime']?.toString();
    final endRaw = json['endTime']?.toString();
    final startParsed = startRaw == null ? null : DateTime.tryParse(startRaw);
    final endParsed = endRaw == null ? null : DateTime.tryParse(endRaw);

    return Slot(
      slotId: (json['slotId'] as num?)?.toInt() ?? 0,
      startTime: (startParsed ?? DateTime.fromMillisecondsSinceEpoch(0)).toLocal(),
      endTime: (endParsed ?? DateTime.fromMillisecondsSinceEpoch(0)).toLocal(),
      isBooked: json['isBooked'] == true,
      isAvailable: json['isAvailable'] == true,
    );
  }
}
