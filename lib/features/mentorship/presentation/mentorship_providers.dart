import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/mentorship/data/mentorship_repository.dart';
import 'package:event_app/features/mentorship/domain/mentorship_details_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mentorshipRepositoryProvider = Provider<MentorshipRepository>((ref) {
  return MentorshipRepository(ref.watch(apiClientProvider));
});


final sessionsForMentorshipProvider = FutureProvider<List<SessionModel>>((ref) async {
  return ref.watch(mentorshipRepositoryProvider).getSessionsForMentorship();
});

final mentorshipSessionsProvider = FutureProvider.family<MentorshipDetailsModel, int>((ref, sessionId) async {
  return ref.watch(mentorshipRepositoryProvider).getMentorshipDetails(sessionId);
});

final selectedMentorshipDateProvider = StateProvider<String?>((ref) => null);
