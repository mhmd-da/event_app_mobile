import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';

class SessionRepository extends BaseApiRepository<SessionModel> {

    SessionRepository(super._apiClient)
      : super(fromJson: (json) => SessionModel.fromJson(json));

  Future<List<SessionModel>> getSessions({String? category}) async => await fetchList(category == null ? AppConfig.getSessionsForAgenda : AppConfig.getSessionsByCategory(category)); 

  Future<bool> submitFeedback(int sessionId, int rating, String? comment) async {
    final payload = {
      'rating': rating,
      if (comment != null && comment.trim(). isNotEmpty) 'comment': comment.trim(),
    };
    return await putData<bool>(AppConfig.submitSessionFeedback(sessionId), payload);
  }

}
