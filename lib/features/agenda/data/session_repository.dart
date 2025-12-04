import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';

class SessionRepository extends BaseApiRepository<SessionModel> {

    SessionRepository(ApiClient client)
      : super(client, (json) => SessionModel.fromJson(json));

  Future<List<SessionModel>> getSessions(int eventId) async => await fetchList(AppConfig.getSessions(eventId)); 

  Future<List<SessionModel>> getSessionsForAgenda(int eventId) async => await fetchList(AppConfig.getSessionsForAgenda(eventId)); 

  Future<String> registerSession(int sessionId) async  => await postData<String>(AppConfig.registerSession(sessionId), null);

  Future<String> cancelSessionRegistration(int sessionId) async  => await postData<String>(AppConfig.cancelSessionRegistration(sessionId), null);
}
