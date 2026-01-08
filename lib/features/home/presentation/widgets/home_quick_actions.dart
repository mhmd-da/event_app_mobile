import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/features/agenda/presentation/agenda_page.dart';
import 'package:event_app/features/faqs/presentation/faqs_page.dart';
import 'package:event_app/features/mentors/presentation/mentors_page.dart';
import 'package:event_app/features/speakers/presentation/speakers_page.dart';
import 'package:event_app/features/venue/presentation/venue_page.dart';
import 'package:event_app/main_navigation/main_navigation_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';

class QuickActionsGrid extends ConsumerWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    final items = [
      // (id, title, icon, page)
      ('agenda', l10n.agenda, Icons.event_note, AgendaPage()),
      // ("Workshops", Icons.school, AgendaPage()),
      // ("Panels", Icons.tab_rounded, AgendaPage()),
      // ("Round-Tables", Icons.table_restaurant, AgendaPage()),
      ('speakers', l10n.speakers, Icons.mic, SpeakersPage()),
      ('mentors', l10n.mentors, Icons.people, MentorsPage()),
      ('venueMap', l10n.venueMap, Icons.map, VenuePage()),
      ('faqs', l10n.faqs, Icons.help_outline, FaqsPage()),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (_, i) {
        final id = items[i].$1;
        final title = items[i].$2;
        final icon = items[i].$3;

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (id == 'agenda') {
              ref.read(mainNavigationIndexProvider.notifier).set(1);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => items[i].$4),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        );
      },
    );
  }
}
