import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/features/my_schedule/presentation/my_schedule_providers.dart';
import 'package:event_app/features/my_schedule/presentation/widgets/my_schedule_calendar_widget.dart';
import 'package:event_app/features/my_schedule/presentation/widgets/my_schedule_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MySchedulePage extends ConsumerWidget {
  const MySchedulePage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(myScheduleProvider);
    final viewMode = ref.watch(scheduleViewModeProvider);

    return AppScaffold(
      body: scheduleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
          Center(child: Text('${AppLocalizations.of(context)!.errorLoadingSchedule} => ${err.toString()}', style: AppTextStyles.bodyMedium)),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.noSessionsInYourSchedule,
                  style: AppTextStyles.bodyMedium),
            );
          }

          return viewMode == ScheduleViewMode.calendar
              ? MyScheduleCalendarWidget()
              : MyScheduleListWidget(items);
        },
      ),
    );
  }
}
