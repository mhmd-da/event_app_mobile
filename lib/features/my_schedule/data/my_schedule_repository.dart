import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/my_schedule/domain/my_schedule_model.dart';

class MyScheduleRepository {
  final ApiClient _apiClient;

  MyScheduleRepository(this._apiClient);

  Future<List<MyScheduleModel>> getMySchedule(int eventId) async {
    final response = await _apiClient.client.get(AppConfig.getMySchedule(eventId));

    final list = response.data["data"]["items"];

    if (list is! List) {
      return [];
    }

    return list.map((u) => MyScheduleModel.fromJson(u)).toList();
  }
}
