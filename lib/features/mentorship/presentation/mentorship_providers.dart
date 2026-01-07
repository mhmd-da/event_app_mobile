import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/mentorship/data/mentorship_repository.dart';
import 'package:event_app/features/mentorship/domain/mentorship_details_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mentorship_providers.g.dart';

@Riverpod(keepAlive: true)
MentorshipRepository mentorshipRepository(Ref ref) {
  return MentorshipRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<MentorshipDetailsModel> mentorshipSessions(Ref ref, int sessionId) async {
  return ref.watch(mentorshipRepositoryProvider).getMentorshipDetails(sessionId);
}

