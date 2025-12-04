import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/features/my_schedule/domain/my_schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class MyScheduleListWidget extends StatelessWidget {
  final List<MyScheduleModel> sessions;

  const MyScheduleListWidget(this.sessions, {super.key});

  @override
  Widget build(BuildContext context) {
    if (sessions.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.noSessionsFound, style: AppTextStyles.bodyMedium),
      );
    }

    // --- Group by day ---
    final Map<String, List<MyScheduleModel>> grouped = {};

    for (var s in sessions) {
      final dayKey = DateFormat("EEEE, MMM d").format(s.startTime);
      grouped.putIfAbsent(dayKey, () => []).add(s);
    }

    // Sort days by real date
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        final da = DateFormat("EEEE, MMM d").parse(a);
        final db = DateFormat("EEEE, MMM d").parse(b);
        return da.compareTo(db);
      });

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.page),
      itemCount: sortedKeys.length,
      itemBuilder: (_, index) {
        final day = sortedKeys[index];
        final daySessions = grouped[day]!
          ..sort((a, b) => a.startTime.compareTo(b.startTime));

        return _DaySection(
          dayLabel: day,
          sessions: daySessions,
        );
      },
    );
  }
}

class _DaySection extends StatelessWidget {
  final String dayLabel;
  final List<MyScheduleModel> sessions;

  const _DaySection({
    required this.dayLabel,
    required this.sessions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Day Header ---
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.section),
          child: Text(
            dayLabel,
            style: AppTextStyles.headlineMedium,
          ),
        ),

        // --- Sessions of the day ---
        ...sessions.map((s) => _ListSessionRow(s)).toList(),

        const SizedBox(height: AppSpacing.section * 1.5),
      ],
    );
  }
}

class _ListSessionRow extends StatelessWidget {
  final MyScheduleModel session;

  const _ListSessionRow(this.session);

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat("HH:mm");

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.item),
      padding: const EdgeInsets.all(AppSpacing.section),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Time Column ---
          SizedBox(
            width: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeFormat.format(session.startTime),
                  style: AppTextStyles.bodySmall,
                ),
                Text(
                  timeFormat.format(session.endTime),
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // --- Details ---
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.sessionName ?? "",
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: 4),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        session.location,
                        style: AppTextStyles.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                // Speakers / Mentors
                if (session.speakersOrMentors.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: session.speakersOrMentors.take(3).map((p) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(p.profileImageUrl),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
