import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/features/my_schedule/presentation/my_schedule_providers.dart';
import 'package:event_app/features/my_schedule/presentation/widgets/my_schedule_calendar_widget.dart';
import 'package:event_app/features/my_schedule/presentation/widgets/my_schedule_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MySchedulePage extends ConsumerWidget {
  const MySchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(myScheduleProvider);
    final viewMode = ref.watch(scheduleViewModeProvider);
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      body: scheduleAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            '${l10n.errorLoadingSchedule} => ${err.toString()}',
            style: AppTextStyles.bodyMedium,
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Text(
                l10n.noSessionsInYourSchedule,
                style: AppTextStyles.bodyMedium,
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // View toggle (Calendar / Table)
                    ToggleButtons(
                      isSelected: [
                        viewMode == MyScheduleViewMode.calendar,
                        viewMode == MyScheduleViewMode.list,
                      ],
                      onPressed: (index) {
                        final mode = index == 0
                            ? MyScheduleViewMode.calendar
                            : MyScheduleViewMode.list;
                        ref.read(scheduleViewModeProvider.notifier).set(mode);
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.calendar_view_day_outlined),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.table_rows_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: viewMode == MyScheduleViewMode.calendar
                    ? const MyScheduleCalendarWidget()
                    : MyScheduleListWidget(items),
              ),
            ],
          );
        },
      ),
    );
  }
}
