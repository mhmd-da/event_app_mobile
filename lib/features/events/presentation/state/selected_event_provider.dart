import 'package:event_app/core/storage/secure_storage_provider.dart';
import 'package:event_app/features/events/domain/event_details_model.dart';
import 'package:event_app/features/events/presentation/events_providers.dart';
import 'package:event_app/shared/providers/language_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_event_provider.g.dart';

@Riverpod(keepAlive: true)
Future<EventDetailsModel?> selectedEvent(Ref ref) async {
  // Watch locale to refetch when language changes
  ref.watch(appLocaleProvider);

  // Get event ID from storage (defaults to 1)
  final storage = ref.watch(secureStorageProvider);
  final eventId = await storage.getEventId();

  try {
    final repository = ref.watch(eventsRepositoryProvider);
    return await repository.getEventDetails(eventId);
  } catch (e) {
    // Return fallback on error
    return EventDetailsModel(
      id: eventId,
      name: '',
      description: null,
      venue: null,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      bannerImageUrl: null,
      feedbackUrl: null,
    );
  }
}
