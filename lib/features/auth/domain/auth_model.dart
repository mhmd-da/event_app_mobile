import 'package:event_app/core/base/base_model.dart';
import 'package:event_app/core/utilities/date_time_parsing.dart';

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
      expiryDate: AppDateTimeParsing.parseServerToUtcOr(
        json['expiry_date'],
        fallback: DateTime.fromMillisecondsSinceEpoch(0).toUtc(),
      ),
      isVerified: json['is_verified'],
    );
  }
}
