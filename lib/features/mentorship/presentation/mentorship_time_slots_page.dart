import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/mentorship/presentation/mentorship_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                    final isDarkMode =
                        Theme.of(context).brightness == Brightness.dark;
                    final buttonTextColor = isDarkMode
                        ? Colors.black
                        : Colors.white;
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
                                  ? AppLocalizations.of(context)!.maxCapacityReached
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
                                    backgroundColor: Theme.of(context).colorScheme.error,
                                    foregroundColor: Theme.of(context).colorScheme.onError,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  )
                                : !timeSlot.isAvailable
                                ? ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).disabledColor,
                                    foregroundColor: Theme.of(context).colorScheme.onSurface,
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
                                    ref.refresh(
                                      mentorshipSessionsProvider(sessionId),
                                    );
                                  }
                                : timeSlot.isAvailable
                                ? () async {
                                    await ref
                                        .read(mentorshipRepositoryProvider)
                                        .bookTimeSlot(timeSlot.slotId);
                                    ref.refresh(
                                      mentorshipSessionsProvider(sessionId),
                                    );
                                  }
                                : null,
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
