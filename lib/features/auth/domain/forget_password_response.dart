import 'package:event_app/core/base/base_model.dart';

class ForgetPasswordResponse extends BaseModel {
  final int userId;

  ForgetPasswordResponse({
    required this.userId,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      userId: json['userId'],
    );
  }
}
