import 'package:event_app/features/mentorship/domain/mentorship_details_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MentorshipDetailsModel.fromJson', () {
    test('parses null mentor/profileImageUrl without throwing', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'mentor': <String, dynamic>{
          'id': 1,
          'title': null,
          'firstName': 'John',
          'lastName': 'Doe',
          'profileImageUrl': null,
        },
        'slots': [],
      };

      final model = MentorshipDetailsModel.fromJson(json);

      expect(model.mentor.id, 1);
      expect(model.mentor.profileImageUrl, '');
      expect(model.slots, isEmpty);
    });

    test('tolerates missing mentor and null slots', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'slots': null,
      };

      final model = MentorshipDetailsModel.fromJson(json);

      expect(model.mentor.id, 0);
      expect(model.mentor.firstName, '');
      expect(model.slots, isEmpty);
    });

    test('parses slot times with tryParse and defaults safely', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'mentor': <String, dynamic>{},
        'slots': [
          <String, dynamic>{
            'slotId': null,
            'startTime': null,
            'endTime': null,
            'isBooked': null,
            'isAvailable': true,
          },
          <String, dynamic>{
            'slotId': 10,
            'startTime': '2025-01-01T10:00:00Z',
            'endTime': '2025-01-01T11:00:00Z',
            'isBooked': true,
            'isAvailable': false,
          },
        ],
      };

      final model = MentorshipDetailsModel.fromJson(json);

      expect(model.slots, hasLength(2));
      expect(model.slots.first.slotId, 0);
      expect(model.slots.first.isBooked, isFalse);
      expect(model.slots.first.isAvailable, isTrue);

      expect(model.slots.last.slotId, 10);
      expect(model.slots.last.isBooked, isTrue);
      expect(model.slots.last.isAvailable, isFalse);
    });
  });
}
