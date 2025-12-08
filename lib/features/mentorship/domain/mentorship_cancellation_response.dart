import 'package:event_app/core/base/base_model.dart';

class MentorshipCancellationResponse extends BaseModel {
  final bool cancelled;
  final String message;

  MentorshipCancellationResponse({
    required this.cancelled,
    required this.message,
  });

  factory MentorshipCancellationResponse.fromJson(Map<String, dynamic> json) {
    return MentorshipCancellationResponse(
      cancelled: json['cancelled'],
      message: json['message'],
    );
  }
}