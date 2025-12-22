import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/features/auth/domain/forget_password_response.dart';
import 'package:event_app/features/auth/domain/registration_response.dart';
import 'package:event_app/features/auth/domain/unverified_account_exception.dart';
import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../auth/domain/auth_model.dart';

class AuthRepository extends BaseApiRepository<AuthModel> {
    final ApiClient _apiClient;

    AuthRepository(this._apiClient)
      : super(_apiClient, fromJson: (json) => AuthModel.fromJson(json));

  Future<AuthModel> login(String username, String password) async {
    final response = await _apiClient.client.post(AppConfig.login, data: {
      "username": username,
      "password": password,
    });

    // Backend-specific: code == 100 means unverified email, regardless of HTTP status
    final code = response.data["code"] as int?;
    if (code == 100) {
      final message = response.data["message"] as String?;
      final data = response.data["data"] as Map<String, dynamic>?;
      final userId = data != null ? data["user_id"] as int? : null;
      throw UnverifiedAccountException(
        message ?? 'Please verify your account before logging in',
        userId: userId,
      );
    }

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    return fromJson!(response.data["data"]);
  }

  Future<RegistrationResponse> register(Map<String, dynamic> formData) async => postDataGeneric<RegistrationResponse>(AppConfig.register, formData, (json) => RegistrationResponse.fromJson(json));

  Future<bool> resendVerificationCode(int userId) async => postData<bool>(AppConfig.resendVerificationCode, {"userId": userId});

  Future<AuthModel> verifyCode(int userId, String code) async => postDataGeneric<AuthModel>(AppConfig.verifyCode, {"userId": userId, "code": code}, (json) => AuthModel.fromJson(json));

  Future<ForgetPasswordResponse> forgetPassword(String username) async => postDataGeneric<ForgetPasswordResponse>(AppConfig.forgetPassword, {"username": username}, (json) => ForgetPasswordResponse.fromJson(json));

  Future<AuthModel> resetPassword(int userId, String password, String code) async => postDataGeneric(AppConfig.resetPassword, {"userId": userId, "password": password, "code": code}, (json) => AuthModel.fromJson(json));
  
}
