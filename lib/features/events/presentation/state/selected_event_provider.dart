import 'package:event_app/features/events/domain/event_details_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedEventProvider = StateProvider<EventDetailsModel?>((ref) => null);
