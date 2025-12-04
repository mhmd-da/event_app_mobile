import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/directory/domain/person_model.dart';

class DirectoryRepository extends BaseApiRepository<PersonModel>{

    DirectoryRepository(ApiClient client)
      : super(client, (json) => PersonModel.fromJson(json));

  Future<List<PersonModel>> getSpeakers(int eventId, String search) async => await fetchList(AppConfig.getSpeakers(eventId, search)); 

  Future<List<PersonModel>> getMentors(int eventId, String search) async => await fetchList(AppConfig.getMentors(eventId, search)); 

}