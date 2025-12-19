import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/my_schedule/data/my_schedule_repository.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myScheduleRepositoryProvider = Provider<MyScheduleRepository>((ref) {
  return MyScheduleRepository(ref.watch(apiClientProvider));
});

final myScheduleProvider = FutureProvider<List<SessionModel>>((ref) async {
    return ref.watch(myScheduleRepositoryProvider).getMySchedule();
});

final scheduleViewModeProvider = StateProvider<ScheduleViewMode>((ref) {
  return ScheduleViewMode.calendar;
});

enum ScheduleViewMode { calendar, list }
