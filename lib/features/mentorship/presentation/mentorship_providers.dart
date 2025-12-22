import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/mentorship/data/mentorship_repository.dart';
import 'package:event_app/features/mentorship/domain/mentorship_details_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mentorship_providers.g.dart';

@Riverpod(keepAlive: true)
MentorshipRepository mentorshipRepository(Ref ref) {
  return MentorshipRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<List<SessionModel>> sessionsForMentorship(Ref ref) async {
  return ref.watch(mentorshipRepositoryProvider).getSessionsForMentorship();
}

@riverpod
Future<MentorshipDetailsModel> mentorshipSessions(Ref ref, int sessionId) async {
  return ref.watch(mentorshipRepositoryProvider).getMentorshipDetails(sessionId);
}

@riverpod
class SelectedMentorshipDate extends _$SelectedMentorshipDate {
  @override
  String? build() => null;
  void set(String? value) => state = value;
}
