import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/mentorship/presentation/mentorship_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MentorshipTimeSlotsPage extends ConsumerWidget {
  final int sessionId;

  const MentorshipTimeSlotsPage({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mentorshipDetailsAsync = ref.watch(
      mentorshipSessionsProvider(sessionId),
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(mentor.profileImageUrl),
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${mentor.title} ${mentor.firstName} ${mentor.lastName}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    final timeSlot = timeSlots[index];
                    final startTime = DateFormat.jm().format(
                      timeSlot.startTime,
                    );
                    final endTime = DateFormat.jm().format(timeSlot.endTime);

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Text('$startTime - $endTime'),
                        subtitle: Text(
                          timeSlot.isAvailable
                              ? AppLocalizations.of(context)!.available
                              : timeSlot.isBooked
                              ? AppLocalizations.of(context)!.registered
                              : AppLocalizations.of(
                                  context,
                                )!.maxCapacityReached,
                        ),
                        trailing: ElevatedButton(
                          onPressed: timeSlot.isAvailable
                              ? () async {
                                  await ref
                                      .read(mentorshipRepositoryProvider)
                                      .bookTimeSlot(timeSlot.slotId);
                                  final _ = ref.refresh(
                                    mentorshipSessionsProvider(sessionId),
                                  );
                                }
                              : timeSlot.isBooked
                                  ? () async {
                                      await ref
                                          .read(mentorshipRepositoryProvider)
                                          .cancelTimeSlot(timeSlot.slotId);
                                      final _ = ref.refresh(
                                        mentorshipSessionsProvider(sessionId),
                                      );
                                    }
                                  : null,
                          child: Text(
                            timeSlot.isAvailable
                                ? AppLocalizations.of(context)!.register
                                : timeSlot.isBooked
                                ? AppLocalizations.of(context)!.unregister
                                : AppLocalizations.of(
                                    context,
                                  )!.maxCapacityReached,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
