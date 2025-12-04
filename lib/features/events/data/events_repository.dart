import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../domain/event_model.dart';
import '../domain/event_details_model.dart';

class EventsRepository {
  final ApiClient _apiClient;

  EventsRepository(this._apiClient);

  Future<List<EventModel>> getEvents() async {
    final response = await _apiClient.client.get(AppConfig.getEvents);

    final list = response.data["data"]["items"];

    if (list is! List) {
      return [];
    }

    return list.map((e) => EventModel.fromJson(e)).toList();
  }

  Future<EventDetailsModel> getEventDetails(int eventId) async {
    final response = await _apiClient.client.get(AppConfig.getEventDetails(eventId));

    return EventDetailsModel.fromJson(response.data as Map<String, dynamic>);
  }
}
