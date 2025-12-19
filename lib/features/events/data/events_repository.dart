import 'package:event_app/core/base/base_api_repository.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../domain/event_model.dart';
import '../domain/event_details_model.dart';

class EventsRepository extends BaseApiRepository<EventModel>{

    EventsRepository(ApiClient client)
      : super(client, fromJson: (json) => EventModel.fromJson(json));

  Future<List<EventModel>> getEvents() async => await fetchList(AppConfig.getEvents);

  Future<EventDetailsModel> getEventDetails(int eventId) async => await fetchSingleGeneric<EventDetailsModel>(AppConfig.getEventDetails(eventId), (json) => EventDetailsModel.fromJson(json));

 }