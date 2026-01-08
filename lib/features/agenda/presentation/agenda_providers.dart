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
Future<List<SessionModel>> sessionsForAgendaList(
  Ref ref,
  String? category,
) async {
  return ref.watch(sessionRepositoryProvider).getSessions(category: category);
}

@riverpod
class SelectedAgendaDate extends _$SelectedAgendaDate {
  @override
  String? build() => null;
  void set(String? value) => state = value;
}

@riverpod
class GroupingMethod extends _$GroupingMethod {
  @override
  String build() => 'time';
  void set(String value) => state = value;
}
