import 'package:event_app/features/agenda/data/session_repository.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client_provider.dart';


final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository(ref.watch(apiClientProvider));
});

final sessionsForAgendaListProvider = FutureProvider.family<List<SessionModel>, String?>((ref, category) async {
  return ref.watch(sessionRepositoryProvider).getSessions(category: category);
});

final selectedAgendaDateProvider = StateProvider<String?>((ref) => null);

final sessionRegistrationStateProvider = StateProvider.family<bool, SessionModel>((ref, session) {
  return session.isRegistered;
});

final groupingMethodProvider = StateProvider<String>((ref) => 'time');

// Reminder state per session (server-driven notifications)
final sessionReminderEnabledProvider =
  StateProvider.family<bool, int>((ref, sessionId) => false);

final sessionReminderLeadMinutesProvider =
  StateProvider.family<int?, int>((ref, sessionId) => null);

final sessionReminderSavingProvider =
  StateProvider.family<bool, int>((ref, sessionId) => false);
