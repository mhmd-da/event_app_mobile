import 'package:event_app/core/base/base_model.dart';

class MentorshipBookingResponse extends BaseModel {
  final bool booked;
  final String message;

  MentorshipBookingResponse({
    required this.booked,
    required this.message,
  });

  factory MentorshipBookingResponse.fromJson(Map<String, dynamic> json) {
    return MentorshipBookingResponse(
      booked: json['booked'],
      message: json['message'],
    );
  }
}