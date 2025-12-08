import 'package:event_app/core/base/base_model.dart';

class RegistrationResponse extends BaseModel {
  final int userId;
  final bool isRegistered;

  RegistrationResponse({
    required this.userId,
    required this.isRegistered,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      userId: json['userId'],
        isRegistered: json['isRegistered'],
    );
  }
}
