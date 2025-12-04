class AuthModel {
  final String token;
  final DateTime expiryDate;

  AuthModel({
    required this.token,
    required this.expiryDate,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return AuthModel(
      token: data['token'],
      expiryDate: DateTime.parse(data['expiry_date']),
    );
  }
}
