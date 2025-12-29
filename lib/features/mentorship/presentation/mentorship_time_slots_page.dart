import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_feedback.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_info_card.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_reminder_chip.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_sponsors_partners_sections.dart';
import 'package:event_app/features/mentors/presentation/mentor_details_page.dart';
import 'package:event_app/features/mentorship/presentation/mentorship_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MentorshipTimeSlotsPage extends ConsumerWidget {
  final SessionModel session;

  const MentorshipTimeSlotsPage({super.key, required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mentorshipDetailsAsync = ref.watch(
      mentorshipSessionsProvider(session.id),
    );

    return AppScaffold(
      title: AppLocalizations.of(context)!.mentorshipTimeSlots,
      body: mentorshipDetailsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text(
            AppLocalizations.of(context)!.errorLoadingTimeSlots,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        data: (mentorshipDetails) {
          final mentor = mentorshipDetails.mentor;
          final timeSlots = mentorshipDetails.slots;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.page),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SessionInfoCard(
                  session: session,
                  showTime: false,
                  showCapacity: false,
                ),
                const SizedBox(height: AppSpacing.section),
                SessionReminderChip(sessionId: session.id),
                const SizedBox(height: AppSpacing.item),
                SizedBox(
                  width: double.infinity,
                  child: SessionFeedbackButton(sessionId: session.id),
                ),
                const SizedBox(height: AppSpacing.section),
                Container(
                  decoration: AppDecorations.cardContainer(context),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: mentor.profileImageUrl.isNotEmpty
                          ? NetworkImage(mentor.profileImageUrl)
                          : null,
                      child: mentor.profileImageUrl.isEmpty
                          ? const Icon(Icons.person_outline)
                          : null,
                    ),
                    title: Text(
                      '${mentor.title} ${mentor.firstName} ${mentor.lastName}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              MentorDetailsPage(mentorId: mentor.id),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.section),
                if (session.sponsors.isNotEmpty)
                  SessionSponsorsSection(sponsors: session.sponsors),
                if (session.sponsors.isNotEmpty)
                  const SizedBox(height: AppSpacing.section),
                if (session.partners.isNotEmpty)
                  SessionPartnersSection(partners: session.partners),
                if (session.partners.isNotEmpty)
                  const SizedBox(height: AppSpacing.section),
                ListView.builder(
                  itemCount: timeSlots.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final timeSlot = timeSlots[index];
                    final timeRange = AppTimeFormatting.formatTimeRange(
                      context,
                      start: timeSlot.startTime,
                      end: timeSlot.endTime,
                    );

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Align(
                            alignment:
                                Directionality.of(context) == TextDirection.rtl
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Text(
                              timeRange,
                              textAlign:
                                  Directionality.of(context) ==
                                      TextDirection.rtl
                                  ? TextAlign.right
                                  : TextAlign.left,
                            ),
                          ),
                        ),
                        subtitle: Text(
                          timeSlot.isBooked
                              ? AppLocalizations.of(context)!.registered
                              : timeSlot.isAvailable
                              ? AppLocalizations.of(context)!.available
                              : AppLocalizations.of(
                                  context,
                                )!.maxCapacityReached,
                        ),
                        trailing: SizedBox(
                          width: 140,
                          child: AppElevatedButton(
                            label: Text(
                              timeSlot.isBooked
                                  ? AppLocalizations.of(context)!.unregister
                                  : !timeSlot.isAvailable
                                  ? AppLocalizations.of(
                                      context,
                                    )!.maxCapacityReached
                                  : AppLocalizations.of(context)!.register,
                            ),
                            icon: Icon(
                              timeSlot.isBooked
                                  ? Icons.remove_circle_outline
                                  : !timeSlot.isAvailable
                                  ? Icons.block
                                  : Icons.check_circle_outline,
                            ),
                            style: timeSlot.isBooked
                                ? ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.error,
                                    foregroundColor: Theme.of(
                                      context,
                                    ).colorScheme.onError,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  )
                                : !timeSlot.isAvailable
                                ? ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).disabledColor,
                                    foregroundColor: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  )
                                : AppDecorations.primaryButton(context),
                            onPressed: timeSlot.isBooked
                                ? () async {
                                    await ref
                                        .read(mentorshipRepositoryProvider)
                                        .cancelTimeSlot(timeSlot.slotId);
                                    await ref.refresh(
                                      mentorshipSessionsProvider(
                                        session.id,
                                      ).future,
                                    );
                                  }
                                : timeSlot.isAvailable
                                ? () async {
                                    await ref
                                        .read(mentorshipRepositoryProvider)
                                        .bookTimeSlot(timeSlot.slotId);
                                    await ref.refresh(
                                      mentorshipSessionsProvider(
                                        session.id,
                                      ).future,
                                    );
                                  }
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
