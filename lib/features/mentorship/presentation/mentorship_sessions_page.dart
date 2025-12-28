import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/agenda/presentation/widgets/agenda_date_tabs.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_tile.dart';
import 'package:event_app/features/mentorship/presentation/mentorship_providers.dart';
import 'package:event_app/features/mentorship/presentation/mentorship_time_slots_page.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:event_app/l10n/app_localizations.dart';

class MentorshipSessionsPage extends ConsumerWidget {
  const MentorshipSessionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mentorshipSessionsAsync = ref.watch(sessionsForMentorshipProvider);
    final selectedDate = ref.watch(selectedMentorshipDateProvider);

    return AppScaffold(
      body: mentorshipSessionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            AppLocalizations.of(context)!.somethingWentWrong,
            style: AppTextStyles.bodyMedium,
          ),
        ),
        data: (sessions) {
          if (sessions.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noSessionsAvailable,
                style: AppTextStyles.bodyMedium,
              ),
            );
          }

          final groupedSessions = groupBy(
            sessions,
            (s) => AppTimeFormatting.formatDayLabelEeeD(context, s.startTime),
          );
          final dateTabs = groupedSessions.keys.toList();

          return Column(
            children: [
              DateTabs(
                dates: dateTabs,
                selectedDate: selectedDate,
                onSelect: (date) =>
                    ref.read(selectedMentorshipDateProvider.notifier).set(date),
              ),
              SizedBox(height: 5),
              Divider(height: 1),
              Expanded(
                child: ListView(
                  children:
                      groupedSessions[selectedDate]
                          ?.map(
                            (s) => SessionTile(
                              session: s,
                              onTapWidgetBuilder: (_) =>
                                  MentorshipTimeSlotsPage(sessionId: s.id),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
