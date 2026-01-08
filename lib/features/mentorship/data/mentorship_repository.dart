import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/mentorship/domain/mentorship_details_model.dart';

class MentorshipRepository extends BaseApiRepository<MentorshipDetailsModel> {

    MentorshipRepository(super._apiClient)
      : super(fromJson: (json) => MentorshipDetailsModel.fromJson(json));

  Future<List<SessionModel>> getSessionsForMentorship() async => await fetchListGeneric<SessionModel>(AppConfig.getSessionsForMentorship, (json) => SessionModel.fromJson(json)); 

  Future<MentorshipDetailsModel> getMentorshipDetails(int sessionId) async => await fetchSingle(AppConfig.getMentorshipDetails(sessionId));
}
