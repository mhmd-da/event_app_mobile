import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/events/domain/event_details_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/events_repository.dart';
import '../domain/event_model.dart';

final eventsRepositoryProvider = Provider<EventsRepository>((ref) {
  return EventsRepository(ref.watch(apiClientProvider));
});

final eventsListProvider = FutureProvider<List<EventModel>>((ref) async {
  return ref.watch(eventsRepositoryProvider).getEvents();
});

final eventDetailsProvider = FutureProvider.family<EventDetailsModel, int>((ref, eventId) async {
  return ref.watch(eventsRepositoryProvider).getEventDetails(eventId);
});

final eventsTabProvider = StateProvider<int>((ref) => 1);
