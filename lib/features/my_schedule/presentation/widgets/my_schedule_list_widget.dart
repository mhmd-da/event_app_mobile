import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/utilities/session_category_helper.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/agenda/presentation/session_details_page.dart';
import 'package:event_app/features/mentorship/presentation/mentorship_time_slots_page.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';

class MyScheduleListWidget extends StatelessWidget {
  final List<SessionModel> sessions;

  const MyScheduleListWidget(this.sessions, {super.key});

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.noSessionsFound,
          style: AppTextStyles.bodyMedium,
        ),
      );
    }

    // --- Group by calendar day ---
    final Map<DateTime, List<SessionModel>> grouped = {};

    for (var s in sessions) {
      final key = DateTime(
        s.startTime.year,
        s.startTime.month,
        s.startTime.day,
      );
      grouped.putIfAbsent(key, () => []).add(s);
    }

    // Sort day keys
    final sortedKeys = grouped.keys.toList()..sort();

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.page),
      itemCount: sortedKeys.length,
      itemBuilder: (_, index) {
        final day = sortedKeys[index];
        final daySessions = grouped[day]!
          ..sort((a, b) => a.startTime.compareTo(b.startTime));

        return _DaySection(day: day, sessions: daySessions);
      },
    );
  }
}

class _DaySection extends StatelessWidget {
  final DateTime day;
  final List<SessionModel> sessions;

  const _DaySection({required this.day, required this.sessions});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final isToday = DateTime(day.year, day.month, day.day) == today;
    final isTomorrow = DateTime(day.year, day.month, day.day) == tomorrow;

    final dateLabel = AppTimeFormatting.formatShortMonthDay(context, day);
    final suffix = isToday
        ? ' • ${l10n.today}'
        : (isTomorrow ? ' • ${l10n.tomorrow}' : '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Day Header ---
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.section),
          child: Text('$dateLabel$suffix', style: AppTextStyles.headlineMedium),
        ),

        // --- Sessions of the day ---
        ...sessions.map((s) => _ListSessionRow(s)),

        const SizedBox(height: AppSpacing.section * 1.5),
      ],
    );
  }
}

class _ListSessionRow extends StatelessWidget {
  final SessionModel session;

  const _ListSessionRow(this.session);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final baseColor = SessionCategoryHelper.getCategoryColor(
      context,
      session.categoryTag,
    );

    final accent = _strongerOf(baseColor, context);
    final bg = baseColor.withValues(alpha: 0.08);
    final duration = session.endTime.difference(session.startTime);

    void openDetails() {
      final tag = session.categoryTag.trim().toUpperCase();
      final isMentorship = tag == 'MENTORSHIP';
      final page = isMentorship
          ? MentorshipTimeSlotsPage(session: session)
          : SessionDetailsPage(session: session);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Time + duration column
            SizedBox(
              width: 76,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      AppTimeFormatting.formatTime(context, session.startTime),
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatDuration(duration, l10n),
                    style: AppTextStyles.bodyTiny.copyWith(
                      color: Theme.of(
                        context,
                      ).textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Timeline divider
            Container(
              width: 3,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Event tile with accent bar
            Expanded(
              child: GestureDetector(
                onTap: openDetails,
                child: Container(
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: bg.withValues(alpha: 0.8)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 4,
                        decoration: BoxDecoration(
                          color: accent,
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                session.name ?? '',
                                style: AppTextStyles.headlineSmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 1.5),
                                    child: Icon(
                                      Icons.location_on_outlined,
                                      size: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      session.location,
                                      style: AppTextStyles.bodySmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _strongerOf(Color base, BuildContext context) {
  // Nudge towards theme primary for better contrast if too pale
  if (base.a < 0.8) {
    final primary = Theme.of(context).colorScheme.primary;
    return Color.alphaBlend(base.withValues(alpha: 0.6), primary);
  }
  return base;
}

String _formatDuration(Duration d, AppLocalizations l10n) {
  final mins = d.inMinutes;
  if (mins < 60) return l10n.minutesShort(mins);
  final hours = mins ~/ 60;
  final rem = mins % 60;
  if (rem == 0) return l10n.hoursShort(hours);
  return '${l10n.hoursShort(hours)} ${l10n.minutesShort(rem)}';
}
