import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';

class SessionRepository extends BaseApiRepository<SessionModel> {

    SessionRepository(super._apiClient)
      : super(fromJson: (json) => SessionModel.fromJson(json));

  Future<List<SessionModel>> getSessions({String? category}) async => await fetchList(category == null ? AppConfig.getSessionsForAgenda : AppConfig.getSessionsByCategory(category)); 

  Future<bool> registerSession(int sessionId) async  => await postData<bool>(AppConfig.registerSession(sessionId), null);

  Future<bool> cancelSessionRegistration(int sessionId) async  => await postData<bool>(AppConfig.cancelSessionRegistration(sessionId), null);

  Future<bool> submitFeedback(int sessionId, int rating, String? comment) async {
    final payload = {
      'rating': rating,
      if (comment != null && comment.trim(). isNotEmpty) 'comment': comment.trim(),
    };
    return await putData<bool>(AppConfig.submitSessionFeedback(sessionId), payload);
  }

  Future<bool> setReminder(int sessionId, int leadMinutes, bool enabled) async {
    return await putData<bool>(
      AppConfig.setSessionReminder(sessionId),
      {
        'enabled': enabled,
        'leadMinutes': leadMinutes,
      },
    );
  }

  Future<bool> deleteReminder(int sessionId) async => deleteData(AppConfig.deleteSessionReminder(sessionId), null);

}
