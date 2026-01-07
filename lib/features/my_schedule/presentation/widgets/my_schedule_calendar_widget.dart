import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/features/agenda/presentation/session_details_page.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/mentorship/presentation/mentorship_time_slots_page.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/shared/providers/timezone_provider.dart';
import '../my_schedule_providers.dart';
import '../../../../core/theme/app_text_styles.dart';

class MyScheduleCalendarWidget extends ConsumerWidget {
  const MyScheduleCalendarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(myScheduleProvider);
    final timezonePreference = ref.watch(appTimezonePreferenceProvider);

    return sessionsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(
        child: Text(
          AppLocalizations.of(context)!.errorLoadingSchedule,
          style: AppTextStyles.bodyMedium,
        ),
      ),
      data: (sessions) {
        if (sessions.isEmpty) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.noSessionsInYourSchedule,
              style: AppTextStyles.bodyMedium,
            ),
          );
        }

        final events = sessions.map((s) {
          final displayStart = AppTimeFormatting.toDisplayTime(
            s.startTime,
            timezonePreference: timezonePreference,
          );
          final displayEnd = AppTimeFormatting.toDisplayTime(
            s.endTime,
            timezonePreference: timezonePreference,
          );
          return CalendarEventData(
            date: displayStart,
            startTime: displayStart,
            endTime: displayEnd,
            title: s.name ?? '',
            description: s.location,
            event: s,
          );
        }).toList();

        final now = DateTime.now();
        final initialDay = DateUtils.dateOnly(
          sessions
              .map(
                (s) => AppTimeFormatting.toDisplayTime(
                  s.startTime,
                  timezonePreference: timezonePreference,
                ),
              )
              .reduce((a, b) => a.isBefore(b) ? a : b),
        );
        final minDay = now.subtract(const Duration(days: 365));
        final maxDay = now.add(const Duration(days: 365));

        // 🔥 Compute startHour and endHour automatically
        final earliestHour = sessions
            .map(
              (s) => AppTimeFormatting.toDisplayTime(
                s.startTime,
                timezonePreference: timezonePreference,
              ).hour,
            )
            .reduce((a, b) => a < b ? a : b);

        final latestHour = sessions
            .map(
              (s) => AppTimeFormatting.toDisplayTime(
                s.endTime,
                timezonePreference: timezonePreference,
              ).hour,
            )
            .reduce((a, b) => a > b ? a : b);

        // Add padding (optional)
        final startHour = (earliestHour - 2).clamp(0, 23);
        final endHour = (latestHour + 2).clamp(1, 23);

        return CalendarControllerProvider(
          controller: EventController()..addAll(events),
          child: _CalendarContent(
            initialDay: initialDay,
            minDay: minDay,
            maxDay: maxDay,
            startHour: startHour,
            endHour: endHour,
          ),
        );
      },
    );
  }
}

class _CalendarContent extends StatelessWidget {
  final DateTime initialDay;
  final DateTime minDay;
  final DateTime maxDay;
  final int startHour;
  final int endHour;

  const _CalendarContent({
    required this.initialDay,
    required this.minDay,
    required this.maxDay,
    required this.startHour,
    required this.endHour,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appTextDirection = Directionality.of(context);

    // calendar_view defaults can look too bright in dark mode.
    // Forcing canvas/scaffold colors makes the internal Materials respect
    // dark theme surfaces.
    final calendarTheme = theme.copyWith(
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
      cardColor: colorScheme.surface,
      dividerColor: colorScheme.outline.withValues(alpha: 0.25),
    );

    // IMPORTANT: DayView internally keeps paging state.
    // Keying it by initialDay forces it to start at the first session day
    // instead of sticking to "today" from a previous build.
    return Theme(
      data: calendarTheme,
      child: Material(
        color: colorScheme.surface,
        // calendar_view uses a Stack with AlignmentDirectional.topStart.
        // In RTL, that becomes top-right which places the timeline column on the right,
        // making the Arabic time labels appear "inside" the grid.
        // Force the DayView layout direction to LTR so the timeline stays on the left,
        // while preserving the app's direction for event tiles.
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: DayView(
            backgroundColor: colorScheme.surface,
            headerStyle: HeaderStyle(
              decoration: BoxDecoration(color: colorScheme.surface),
              headerTextStyle: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
              leftIconConfig: IconDataConfig(
                color: colorScheme.onSurface,
                size: 22,
                padding: const EdgeInsets.all(8),
              ),
              rightIconConfig: IconDataConfig(
                color: colorScheme.onSurface,
                size: 22,
                padding: const EdgeInsets.all(8),
              ),
            ),
            initialDay: initialDay,
            startHour: startHour,
            endHour: endHour,
            timeLineWidth: 84,
            eventTileBuilder: (date, events, boundary, start, end) {
              return Directionality(
                textDirection: appTextDirection,
                child: _eventCardBuilder(
                  context,
                  date,
                  events,
                  boundary,
                  start,
                  end,
                ),
              );
            },
            showVerticalLine: true,
            heightPerMinute: 3.6,
            minDay: minDay,
            maxDay: maxDay,
            timeLineBuilder: (date) {
              // Keep Arabic ordering for (ص/م) while keeping the timeline column outside.
              return Padding(
                padding: const EdgeInsets.only(right: 10, top: 4, bottom: 4),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      AppTimeFormatting.formatTime(context, date),
                      style: AppTextStyles.bodyTiny.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.72),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _eventCardBuilder(
  BuildContext context,
  DateTime date,
  List<CalendarEventData> events,
  Rect boundary,
  DateTime startDuration,
  DateTime endDuration,
) {
  final event = events.first;
  final SessionModel session = event.event as SessionModel;

  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  final isDark = theme.brightness == Brightness.dark;

  // --- Color based on type ---
  // final baseColor = SessionCategoryHelper.getCategoryColor(
  //   context,
  //   session.categoryTag,
  // );
  final baseColor = AppColors.defaultBg(context);

  final titleColor = colorScheme.onSurface;
  final subtitleColor = colorScheme.onSurface.withValues(alpha: 0.82);
  final timeColor = colorScheme.onSurface.withValues(alpha: 0.78);

  void openDetails() {
    final tag = session.categoryTag.trim().toUpperCase();
    final isMentorship = tag == 'MENTORSHIP';
    final page = isMentorship
        ? MentorshipTimeSlotsPage(session: session)
        : SessionDetailsPage(session: session);

    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  return GestureDetector(
    onTap: openDetails,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              baseColor.withValues(alpha: isDark ? 0.20 : 0.14),
              baseColor.withValues(alpha: isDark ? 0.32 : 0.24),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Left colored bar ---
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 8),

            // --- Main content (scrollable to avoid overflow) ---
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // prevent flex overflow
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      event.title,
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: titleColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Subtitle: location
                    if (event.description != null &&
                        event.description!.trim().isNotEmpty)
                      Text(
                        event.description!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: subtitleColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                    const SizedBox(height: 6),

                    // Small time label
                    if (event.startTime != null && event.endTime != null)
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          AppTimeFormatting.formatTimeRange(
                            context,
                            start: event.startTime!,
                            end: event.endTime!,
                          ),
                          style: AppTextStyles.bodyTiny.copyWith(
                            color: timeColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
