import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/features/agenda/presentation/agenda_page.dart';
import 'package:event_app/features/faqs/presentation/faqs_page.dart';
import 'package:event_app/features/faqs/presentation/faqs_providers.dart';
import 'package:event_app/features/mentors/presentation/mentors_page.dart';
import 'package:event_app/features/speakers/presentation/speakers_page.dart';
import 'package:event_app/features/my_schedule/presentation/my_schedule_page.dart';
import 'package:event_app/features/venue/presentation/venue_page.dart';
import 'package:event_app/main_navigation/main_navigation_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuickActionsGrid extends ConsumerWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = [
      ("Agenda", Icons.event_note, AgendaPage()),
      // ("Workshops", Icons.school, AgendaPage()),
      // ("Panels", Icons.tab_rounded, AgendaPage()),
      // ("Round-Tables", Icons.table_restaurant, AgendaPage()),
      ("Speakers", Icons.mic, SpeakersPage()),
      ("Mentors", Icons.people, MentorsPage()),
      ("My Schedule", Icons.schedule, MySchedulePage()),
      ("Venue Map", Icons.map, VenuePage()),
      ("FAQs", Icons.help_outline, FaqsPage()),
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
        final title = items[i].$1;
        final icon = items[i].$2;

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            if (title == "Agenda") {
              ref.read(mainNavigationIndexProvider.notifier).state = 1;
            } else {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => items[i].$3));
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
                child: Icon(icon, color: Colors.white),
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
