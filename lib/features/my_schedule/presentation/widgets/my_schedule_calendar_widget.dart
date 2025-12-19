import 'package:event_app/core/utilities/session_category_helper.dart';
import 'package:event_app/features/agenda/presentation/session_details_page.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../my_schedule_providers.dart';
import '../../../../core/theme/app_text_styles.dart';

class MyScheduleCalendarWidget extends ConsumerWidget {
  const MyScheduleCalendarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(myScheduleProvider);

    return sessionsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(
        child: Text(
          AppLocalizations.of(context)!.errorLoadingSchedule,
          style: AppTextStyles.bodyMedium,
        ),
      ),
      data: (sessions) {
        final events = sessions.map((s) {
          return CalendarEventData(
            date: s.startTime,
            startTime: s.startTime,
            endTime: s.endTime,
            title: s.name ?? '',
            description: s.location,
            event: s,
          );
        }).toList();

        // Compute initial day
        final earliestDay = sessions
            .map((s) => s.startTime)
            .reduce((a, b) => a.isBefore(b) ? a : b);

        // 🔥 Compute startHour and endHour automatically
        final earliestHour = sessions
            .map((s) => s.startTime.hour)
            .reduce((a, b) => a < b ? a : b);

        final latestHour = sessions
            .map((s) => s.endTime.hour)
            .reduce((a, b) => a > b ? a : b);

        // Add padding (optional)
        final startHour = (earliestHour - 2).clamp(0, 23);
        final endHour = (latestHour + 2).clamp(1, 23);

        return CalendarControllerProvider(
          controller: EventController()..addAll(events),
          child: _CalendarContent(
            initialDay: earliestDay,
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
  final int startHour;
  final int endHour;

  const _CalendarContent({
    required this.initialDay,
    required this.startHour,
    required this.endHour,
  });

  @override
  Widget build(BuildContext context) {
    return DayView(
      initialDay: initialDay, // 👈 Scroll to this date automatically
      startHour: startHour, // 👈 show hours starting 9 AM
      endHour: endHour, // 👈 end at 5 PM
      eventTileBuilder: (date, events, boundary, start, end) {
        return _eventCardBuilder(
          context, // 👈 YOU PASS IT
          date,
          events,
          boundary,
          start,
          end,
        );
      },
      showVerticalLine: true,
      heightPerMinute: 2,
      minDay: DateTime.now().subtract(const Duration(days: 365)),
      maxDay: DateTime.now().add(const Duration(days: 365)),
      timeLineBuilder: (date) => Text(
        DateFormat('HH:mm').format(date),
        style: AppTextStyles.bodySmall,
        textAlign: TextAlign.center,
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
  final SessionModel? session = event.event as SessionModel?;

  // --- Color based on type ---
  final baseColor = SessionCategoryHelper.getCategoryColor(
    context,
    session!.category,
  );

  void _openDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SessionDetailsPage(session: session!)),
    );
  }

  return GestureDetector(
    onTap: _openDetails,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(color: baseColor.withOpacity(0.10)),
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
                    // Title + type chip
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            event.title,
                            style: AppTextStyles.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (session?.category.isNotEmpty == true) ...[
                          const SizedBox(width: 6),
                          Flexible(
                            fit: FlexFit.loose,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: baseColor.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  session!.category,
                                  style: AppTextStyles.bodySmall,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Time row
                    if (event.startTime != null && event.endTime != null)
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 14),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              "${DateFormat('HH:mm').format(event.startTime!)} - "
                              "${DateFormat('HH:mm').format(event.endTime!)}",
                              style: AppTextStyles.bodySmall,
                            ),
                          ),
                        ],
                      ),

                    // Location row
                    if (event.description != null &&
                        event.description!.trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              event.description!,
                              style: AppTextStyles.bodySmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // Speakers row (avatars)
                    if (session != null && session.speakers.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 14),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Wrap(
                              spacing: 4,
                              runSpacing: 2,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                ...session.speakers
                                    .take(3)
                                    .map(
                                      (p) => CircleAvatar(
                                        radius: 10,
                                        backgroundImage: NetworkImage(
                                          p.profileImageUrl,
                                        ),
                                      ),
                                    ),
                                  if (session.speakers.length > 3)
                                  Text(
                                      "+${session.speakers.length - 3}",
                                    style: AppTextStyles.bodySmall,
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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
