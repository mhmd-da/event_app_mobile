import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/speakers/domain/speaker_model.dart';
import 'package:event_app/features/speakers/domain/speaker_details_model.dart';

class SpeakerRepository extends BaseApiRepository<SpeakerModel>{
    SpeakerRepository(super._apiClient)
            : super(fromJson: (json) => SpeakerModel.fromJson(json));

  Future<List<SpeakerModel>> getSpeakers(String? search) async => await fetchList(AppConfig.getSpeakers(search)); 

  Future<SpeakerDetailsModel> getSpeakerDetails(int speakerId) async => await fetchSingleGeneric(AppConfig.getSpeakerDetails(speakerId), SpeakerDetailsModel.fromJson); 
}