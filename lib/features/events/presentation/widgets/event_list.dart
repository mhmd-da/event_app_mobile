import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/event_model.dart';
import 'event_card.dart';

class EventsList extends ConsumerWidget {
  final List<EventModel> events;

  const EventsList({super.key, required this.events});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: events.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        return EventCard(event: events[index]);
      },
    );
  }
}
