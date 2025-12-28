import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/my_schedule/data/my_schedule_repository.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_schedule_providers.g.dart';

@Riverpod(keepAlive: true)
MyScheduleRepository myScheduleRepository(Ref ref) {
  return MyScheduleRepository(ref.watch(apiClientProvider));
}

@riverpod
Future<List<SessionModel>> mySchedule(Ref ref) async {
  return ref.watch(myScheduleRepositoryProvider).getMySchedule();
}

@riverpod
class ScheduleViewMode extends _$ScheduleViewMode {
  @override
  MyScheduleViewMode build() => MyScheduleViewMode.list;
  void set(MyScheduleViewMode mode) => state = mode;
}

enum MyScheduleViewMode { calendar, list }
