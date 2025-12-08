import 'package:event_app/core/base/base_model.dart';

class AuthModel extends BaseModel {
  final String token;
  final DateTime expiryDate;
  final bool isVerified;

  AuthModel({
    required this.token,
    required this.expiryDate,
    required this.isVerified,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'],
      expiryDate: DateTime.parse(json['expiry_date']),
      isVerified: json['is_verified'],
    );
  }
}
