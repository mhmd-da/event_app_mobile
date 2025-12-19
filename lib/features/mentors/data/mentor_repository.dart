import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/mentors/domain/mentor_model.dart';

class MentorRepository extends BaseApiRepository<MentorModel>{

    MentorRepository(ApiClient client)
      : super(client, fromJson: (json) => MentorModel.fromJson(json));

  Future<List<MentorModel>> getMentors(String? search) async => await fetchList(AppConfig.getMentors(search)); 

}