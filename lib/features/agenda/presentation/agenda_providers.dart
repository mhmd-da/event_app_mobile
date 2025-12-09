import 'package:event_app/features/agenda/data/session_repository.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client_provider.dart';


final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository(ref.watch(apiClientProvider));
});

final sessionsForAgendaListProvider = FutureProvider<List<SessionModel>>((ref) async {
  return ref.watch(sessionRepositoryProvider).getSessionsForAgenda();
});

final selectedAgendaDateProvider = StateProvider<String?>((ref) => null);

final sessionRegistrationStateProvider = StateProvider.family<bool, SessionModel>((ref, session) {
  return session.isRegistered;
});

final groupingMethodProvider = StateProvider<String>((ref) => 'time');
