import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/home_providers.dart';

class AnnouncementCard extends ConsumerWidget {
  const AnnouncementCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncAnnouncements = ref.watch(announcementsProvider);
    return AppCard(
      child: asyncAnnouncements.when(
        data: (announcements) {
          if (announcements.isEmpty) {
            return Text(
              'No announcements available.',
              style: Theme.of(context).textTheme.bodyMedium,
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: announcements
                .map(
                  (a) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          a.message,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        if (a.date != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: Text(
                                AppTimeFormatting.formatDateTimeYMMMdJm(
                                  context,
                                  a.date!,
                                ),
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Text(
          'Failed to load announcements',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
