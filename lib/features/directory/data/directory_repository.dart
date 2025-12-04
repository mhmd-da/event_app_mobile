import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/directory/domain/person_model.dart';

class DirectoryRepository {
  final ApiClient _apiClient;

  DirectoryRepository(this._apiClient);

  Future<List<PersonModel>> getSpeakers(int eventId, String search) async {
    final response = await _apiClient.client.get(AppConfig.getSpeakers(eventId, search));

    final list = response.data["data"]["items"];

    if (list is! List) {
      return [];
    }

    return list.map((u) => PersonModel.fromJson(u)).toList();
  }

  Future<List<PersonModel>> getMentors(int eventId, String search) async {
    final response = await _apiClient.client.get(AppConfig.getMentors(eventId, search));

    final list = response.data["data"]["items"];

    if (list is! List) {
      return [];
    }

    return list.map((u) => PersonModel.fromJson(u)).toList();
  }
}
