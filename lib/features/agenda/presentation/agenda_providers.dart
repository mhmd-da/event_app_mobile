import 'package:event_app/features/agenda/data/session_repository.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/api_client_provider.dart';

part 'agenda_providers.g.dart';

@Riverpod(keepAlive: true)
SessionRepository sessionRepository(Ref ref) {
  return SessionRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<List<SessionModel>> sessionsForAgendaList(Ref ref, String? category) async {
  return ref.watch(sessionRepositoryProvider).getSessions(category: category);
}

@riverpod
class SelectedAgendaDate extends _$SelectedAgendaDate {
  @override
  String? build() => null;
  void set(String? value) => state = value;
}

@riverpod
class SessionRegistrationState extends _$SessionRegistrationState {
  @override
  bool build(SessionModel session) => session.isRegistered;
  void set(bool value) => state = value;
}

@riverpod
class GroupingMethod extends _$GroupingMethod {
  @override
  String build() => 'time';
  void set(String value) => state = value;
}

// Reminder state per session (server-driven notifications)
@riverpod
class SessionReminderEnabled extends _$SessionReminderEnabled {
  @override
  bool build(int sessionId) => false;
  void set(bool value) => state = value;
}

@riverpod
class SessionReminderLeadMinutes extends _$SessionReminderLeadMinutes {
  @override
  int? build(int sessionId) => null;
  void set(int? value) => state = value;
}

@riverpod
class SessionReminderSaving extends _$SessionReminderSaving {
  @override
  bool build(int sessionId) => false;
  void set(bool value) => state = value;
}

@riverpod
class SessionChatMembership extends _$SessionChatMembership {
  @override
  bool build(int sessionId) => false;
  void set(bool value) => state = value;
  void initialize(bool initial) {
    // Only initialize to true when backend says user is a member.
    // Do NOT force to false, to avoid overriding a freshly joined state.
    if (initial && state != true) {
      Future.microtask(() => state = true);
    }
  }
}
