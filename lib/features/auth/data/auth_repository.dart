import 'package:event_app/core/base/base_api_repository.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../auth/domain/auth_model.dart';

class AuthRepository extends BaseApiRepository<AuthModel> {
    AuthRepository(ApiClient client)
      : super(client, (json) => AuthModel.fromJson(json));

  Future<AuthModel> login(String username, String password) async => postDataGeneric<AuthModel>(AppConfig.login, 
                                                                            (json) => AuthModel.fromJson(json),
                                                                            {
                                                                                "username": username,
                                                                                "password": password,
                                                                            });
  
}
