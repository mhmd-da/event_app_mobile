import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/speakers/domain/speaker_model.dart';

class SpeakerRepository extends BaseApiRepository<SpeakerModel>{

    SpeakerRepository(ApiClient client)
      : super(client, (json) => SpeakerModel.fromJson(json));

  Future<List<SpeakerModel>> getSpeakers(String? search) async => await fetchList(AppConfig.getSpeakers(search)); 

}