import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/mentorship/domain/mentorship_booking_response.dart';
import 'package:event_app/features/mentorship/domain/mentorship_cancellation_response.dart';
import 'package:event_app/features/mentorship/domain/mentorship_details_model.dart';

class MentorshipRepository extends BaseApiRepository<MentorshipDetailsModel> {

    MentorshipRepository(ApiClient client)
      : super(client, (json) => MentorshipDetailsModel.fromJson(json));

  Future<List<SessionModel>> getSessionsForMentorship() async => await fetchListGeneric<SessionModel>(AppConfig.getSessionsForMentorship, (json) => SessionModel.fromJson(json)); 

  Future<MentorshipDetailsModel> getMentorshipDetails(int sessionId) async => await fetchSingle(AppConfig.getMentorshipDetails(sessionId)); 
  
  Future<MentorshipBookingResponse> bookTimeSlot(int mentorshipSlotId) async  => await postDataGeneric<MentorshipBookingResponse>(AppConfig.bookTimeSlot, {"mentorshipSlotId": mentorshipSlotId}, (json) => MentorshipBookingResponse.fromJson(json));

  Future<MentorshipCancellationResponse> cancelTimeSlot(int mentorshipSlotId) async  => await postDataGeneric<MentorshipCancellationResponse>(AppConfig.cancelTimeSlot, {"mentorshipSlotId": mentorshipSlotId}, (json) => MentorshipCancellationResponse.fromJson(json));
}
