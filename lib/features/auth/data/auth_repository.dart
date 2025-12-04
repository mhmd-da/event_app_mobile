import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../auth/domain/auth_model.dart';

class AuthRepository {
  final ApiClient _api = ApiClient();

  Future<AuthModel> login(String username, String password) async {
    final response = await _api.client.post(
      AppConfig.login,
      data: {
        "username": username,
        "password": password,
      },
    );

    return AuthModel.fromJson(response.data);
  }
}
