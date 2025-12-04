import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/features/agenda/presentation/agenda_page.dart';
import 'package:event_app/features/directory/presentation/mentors_page.dart';
import 'package:event_app/features/directory/presentation/speakers_page.dart';
import 'package:event_app/features/faqs/presentation/faqs_page.dart';
import 'package:event_app/features/my_schedule/presentation/my_schedule_page.dart';
import 'package:event_app/features/venue/presentation/venue_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main_navigation_providers.dart';
import 'placeholder_page.dart';

class SideNavigationDrawer extends ConsumerWidget {
  const SideNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainNavigationIndexProvider);

    Widget tile({required IconData icon, required String label, VoidCallback? onTap, bool selected = false}) {
      return ListTile(
        leading: Icon(icon, color: selected ? Theme.of(context).colorScheme.primary : null),
        textColor: selected ? Theme.of(context).colorScheme.primary : Theme.of(context).textTheme.headlineMedium?.color,
        title: Text(label),
        selected: selected,
        onTap: () {
          Navigator.pop(context); // close drawer
          onTap?.call();
        },
      );
    }

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient
        ),
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(AppLocalizations.of(context)!.appTitle, style: Theme.of(context).textTheme.headlineSmall),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    tile(
                      icon: Icons.home_rounded,
                      label: AppLocalizations.of(context)!.home,
                      selected: currentIndex == 0,
                      onTap: () => ref.read(mainNavigationIndexProvider.notifier).state = 0,
                    ),
                    tile(
                      icon: Icons.event_rounded,
                      label: AppLocalizations.of(context)!.agenda,
                      selected: currentIndex == 1,
                      onTap: () => ref.read(mainNavigationIndexProvider.notifier).state = 1,
                    ),
                    tile(
                      icon: Icons.record_voice_over_rounded,
                      label: AppLocalizations.of(context)!.speakers,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SpeakersPage())),
                    ),
                    tile(
                      icon: Icons.workspaces_filled,
                      label: AppLocalizations.of(context)!.workshops,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Workshops'))),
                    ),
                    tile(
                      icon: Icons.forum_rounded,
                      label: AppLocalizations.of(context)!.roundtables,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Roundtables'))),
                    ),
                    tile(
                      icon: Icons.group_rounded,
                      label: AppLocalizations.of(context)!.mentorship,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MentorsPage())),
                    ),
                    const Divider(),
                    tile(
                      icon: Icons.schedule_rounded,
                      label: AppLocalizations.of(context)!.mySchedule,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MySchedulePage())),
                    ),
                    tile(
                      icon: Icons.menu_book_rounded,
                      label: AppLocalizations.of(context)!.resources,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Resources'))),
                    ),
                    tile(
                      icon: Icons.notifications_rounded,
                      label: AppLocalizations.of(context)!.notifications,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Notifications'))),
                    ),
                    tile(
                      icon: Icons.favorite_border,
                      label: AppLocalizations.of(context)!.sponsors,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Sponsors'))),
                    ),
                    tile(
                      icon: Icons.handshake_outlined,
                      label: AppLocalizations.of(context)!.partners,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Partners'))),
                    ),
                    tile(
                      icon: Icons.storefront_rounded,
                      label: AppLocalizations.of(context)!.exhibitions,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Exhibitions'))),
                    ),
                    const Divider(),
                    tile(
                      icon: Icons.person_rounded,
                      label: AppLocalizations.of(context)!.profile,
                      selected: currentIndex == 3,
                      onTap: () => ref.read(mainNavigationIndexProvider.notifier).state = 3,
                    ),
                    tile(
                      icon: Icons.info_outline,
                      label: AppLocalizations.of(context)!.eventInfo,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Event Info'))),
                    ),
                    tile(
                      icon: Icons.contact_page_outlined,
                      label: AppLocalizations.of(context)!.contactUs,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Contact Us'))),
                    ),
                    tile(
                      icon: Icons.apartment_outlined,
                      label: AppLocalizations.of(context)!.venue,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VenuePage())),
                    ),
                    tile(
                      icon: Icons.question_answer_outlined,
                      label: AppLocalizations.of(context)!.faqs,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FaqsPage())),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
