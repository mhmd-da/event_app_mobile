import 'package:event_app/features/agenda/data/session_repository.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client_provider.dart';
import '../../events/presentation/state/selected_event_provider.dart';


final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository(ref.watch(apiClientProvider));
});

final sessionsListProvider = FutureProvider<List<SessionModel>>((ref) async {
  return ref.watch(sessionRepositoryProvider).getSessions(ref.watch(selectedEventProvider)!.id);
});

final sessionsForAgendaListProvider = FutureProvider<List<SessionModel>>((ref) async {
  return ref.watch(sessionRepositoryProvider).getSessionsForAgenda(ref.watch(selectedEventProvider)!.id);
});

final sessionRegistrationProvider = FutureProvider.family<String, int>((ref, sessionId) async {
  return ref.watch(sessionRepositoryProvider).registerSession(sessionId);
});

final sessionCancellationProvider = FutureProvider.family<String, int>((ref, sessionId) async {
  return ref.watch(sessionRepositoryProvider).cancelSessionRegistration(sessionId);
});

final selectedAgendaDateProvider = StateProvider<String?>((ref) => null);

final sessionPanelStateProvider = StateProvider.family<bool, int>((ref, sessionId) => false);
