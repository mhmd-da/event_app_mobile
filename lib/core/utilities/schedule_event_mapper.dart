import 'package:calendar_view/calendar_view.dart';

import '../../features/my_schedule/domain/my_schedule_model.dart';

CalendarEventData<MyScheduleModel> scheduleToEvent(MyScheduleModel s) {
  return CalendarEventData(
    date: s.startTime,
    startTime: s.startTime,
    endTime: s.endTime,
    event: s,
    title: s.sessionName ?? "",
    description: s.location,
  );
}
