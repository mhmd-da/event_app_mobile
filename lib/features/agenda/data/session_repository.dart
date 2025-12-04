import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';

class SessionRepository {
  final ApiClient _apiClient;

  SessionRepository(this._apiClient);

  Future<List<SessionModel>> getSessions(int eventId) async {
    final response = await _apiClient.client.get(AppConfig.getSessions(eventId));

    final list = response.data["data"]["items"];

    if (list is! List) {
      return [];
    }

    return list.map((u) => SessionModel.fromJson(u)).toList();
  }

  Future<List<SessionModel>> getSessionsForAgenda(int eventId) async {
    final response = await _apiClient.client.get(AppConfig.getSessionsForAgenda(eventId));

    final list = response.data["data"]["items"];

    if (list is! List) {
      return [];
    }

    return list.map((u) => SessionModel.fromJson(u)).toList();
  }

  Future<String> registerSession(int sessionId) async {
    final response = await _apiClient.client.post(AppConfig.registerSession(sessionId));

    final message = response.data["message"];

    return message;
  }

  Future<String> cancelSessionRegistration(int sessionId) async {
    final response = await _apiClient.client.post(AppConfig.cancelSessionRegistration(sessionId));

    final message = response.data["message"];

    return message;
  }
}
