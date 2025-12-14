import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';

class SessionRepository extends BaseApiRepository<SessionModel> {

    SessionRepository(ApiClient client)
      : super(client, (json) => SessionModel.fromJson(json));

  Future<List<SessionModel>> getSessionsForAgenda() async => await fetchList(AppConfig.getSessionsForAgenda); 

  Future<bool> registerSession(int sessionId) async  => await postData<bool>(AppConfig.registerSession(sessionId), null);

  Future<bool> cancelSessionRegistration(int sessionId) async  => await postData<bool>(AppConfig.cancelSessionRegistration(sessionId), null);

  Future<bool> submitFeedback(int sessionId, int rating, String? comment) async {
    final payload = {
      'rating': rating,
      if (comment != null && comment.trim(). isNotEmpty) 'comment': comment.trim(),
    };
    return await putData<bool>(AppConfig.submitSessionFeedback(sessionId), payload);
  }
}
