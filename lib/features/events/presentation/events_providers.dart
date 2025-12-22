import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/events/domain/event_details_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/events_repository.dart';
import '../domain/event_model.dart';

part 'events_providers.g.dart';

@Riverpod(keepAlive: true)
EventsRepository eventsRepository(Ref ref) {
  return EventsRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<List<EventModel>> eventsList(Ref ref) async {
  return ref.watch(eventsRepositoryProvider).getEvents();
}

@riverpod
Future<EventDetailsModel> eventDetails(Ref ref, int eventId) async {
  return ref.watch(eventsRepositoryProvider).getEventDetails(eventId);
}

@riverpod
class EventsTab extends _$EventsTab {
  @override
  int build() => 1;
  void set(int index) => state = index;
}
