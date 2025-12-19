import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/core/base/base_model.dart';

class ContactRequestResponse extends BaseModel {
  final bool success;
  ContactRequestResponse({required this.success});
  factory ContactRequestResponse.fromJson(Map<String, dynamic> json) {
    return ContactRequestResponse(success: json['success'] ?? true);
  }
}

class ContactRepository extends BaseApiRepository<BaseModel> {
  ContactRepository(ApiClient client)
      : super(client);

  Future<bool> submitContact({required String category, required String subject, required String message}) async {
    final result = await postData<bool>(AppConfig.submitContactRequest, {
      'category': category,
      'subject': subject,
      'message': message,
    });
    return result;
  }
}
