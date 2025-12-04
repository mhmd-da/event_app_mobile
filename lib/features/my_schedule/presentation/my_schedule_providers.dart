import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/features/my_schedule/data/my_schedule_repository.dart';
import 'package:event_app/features/my_schedule/domain/my_schedule_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myScheduleRepositoryProvider = Provider<MyScheduleRepository>((ref) {
  return MyScheduleRepository(ref.watch(apiClientProvider));
});

final myScheduleProvider = FutureProvider<List<MyScheduleModel>>((ref) async {
  final event = ref.watch(selectedEventProvider);

  if (event == null) return [];

  return ref
      .watch(myScheduleRepositoryProvider)
      .getMySchedule(event.id);
});

final scheduleViewModeProvider = StateProvider<ScheduleViewMode>((ref) {
  return ScheduleViewMode.calendar;
});

enum ScheduleViewMode { calendar, list }
