import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/features/auth/domain/registration_response.dart';
import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../auth/domain/auth_model.dart';

class AuthRepository extends BaseApiRepository<AuthModel> {
    AuthRepository(ApiClient client)
      : super(client, (json) => AuthModel.fromJson(json));

  Future<AuthModel> login(String username, String password) async => postDataGeneric<AuthModel>(AppConfig.login, 
                                                                            {
                                                                                "username": username,
                                                                                "password": password,
                                                                            },
                                                                            (json) => AuthModel.fromJson(json)
                                                                            );

  Future<RegistrationResponse> register(Map<String, dynamic> formData) async => postDataGeneric<RegistrationResponse>(AppConfig.register, formData, (json) => RegistrationResponse.fromJson(json));

  Future<bool> resendVerificationCode(int userId) async => postData<bool>(AppConfig.resendVerificationCode, {"userId": userId});

  Future<AuthModel> verifyCode(int userId, String code) async => postDataGeneric<AuthModel>(AppConfig.verifyCode, {"userId": userId, "code": code}, (json) => AuthModel.fromJson(json));

}
