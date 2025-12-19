import 'package:event_app/features/agenda/presentation/agenda_page.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/features/settings/presentation/settings_page.dart';
import 'package:event_app/features/speakers/presentation/speakers_page.dart';
import 'package:event_app/features/faqs/presentation/faqs_page.dart';
import 'package:event_app/features/venue/presentation/venue_page.dart';
import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main_navigation_providers.dart';
import 'placeholder_page.dart';
import 'package:event_app/features/sponsors/presentation/sponsors_page.dart';
import 'package:event_app/features/partners/presentation/partners_page.dart';
import 'package:event_app/features/auth/presentation/login_page.dart';
import 'package:event_app/features/contact/presentation/contact_form_page.dart';

class SideNavigationDrawer extends ConsumerWidget {
  const SideNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainNavigationIndexProvider);

    Widget tile({required IconData icon, required String label, VoidCallback? onTap, bool selected = false}) {
      final colorScheme = Theme.of(context).colorScheme;
      return ListTile(
        leading: Icon(icon, color: selected ? colorScheme.primary : colorScheme.onSurfaceVariant),
        title: Text(label, style: TextStyle(color: selected ? colorScheme.primary : colorScheme.onSurface)),
        selected: selected,
        selectedTileColor: colorScheme.primary.withOpacity(0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () {
          Navigator.pop(context); // close drawer
          onTap?.call();
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      );
    }

    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                      child: Icon(Icons.event, color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.appTitle,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            AppLocalizations.of(context)!.mentors,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
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
                      icon: Icons.workspaces_filled,
                      label: AppLocalizations.of(context)!.workshops,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AgendaPage(category: 'WORKSHOP'))),
                    ),
                    tile(
                      icon: Icons.forum_rounded,
                      label: AppLocalizations.of(context)!.roundtables,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AgendaPage(category: 'ROUNDTABLE'))),
                    ),
                    tile(
                      icon: Icons.group_rounded,
                      label: AppLocalizations.of(context)!.mentorship,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AgendaPage(category: 'MENTORSHIP'))),
                    ),
                    tile(
                      icon: Icons.schedule_rounded,
                      label: AppLocalizations.of(context)!.mySchedule,
                      onTap: () => ref.read(mainNavigationIndexProvider.notifier).state = 1,
                      // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MySchedulePage())),
                    ),
                    const Divider(),
                    tile(
                      icon: Icons.record_voice_over_rounded,
                      label: AppLocalizations.of(context)!.speakers,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SpeakersPage())),
                    ),
                    tile(
                      icon: Icons.favorite_border,
                      label: AppLocalizations.of(context)!.sponsors,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SponsorsPage())),
                    ),
                    tile(
                      icon: Icons.handshake_outlined,
                      label: AppLocalizations.of(context)!.partners,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PartnersPage())),
                    ),
                    tile(
                      icon: Icons.storefront_rounded,
                      label: AppLocalizations.of(context)!.exhibitions,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Exhibitions'))),
                    ),
                    const Divider(),
                    tile(
                      icon: Icons.menu_book_rounded,
                      label: AppLocalizations.of(context)!.resources,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlaceholderPage(title: 'Resources'))),
                    ),
                    tile(
                      icon: Icons.apartment_outlined,
                      label: AppLocalizations.of(context)!.venue,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VenuePage())),
                    ),
                    tile(
                      icon: Icons.question_answer_outlined,
                      label: AppLocalizations.of(context)!.faqs,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FaqsPage())),
                    ),
                    const Divider(),
                    // Settings above logout
                    tile(
                      icon: Icons.person_rounded,
                      label: AppLocalizations.of(context)!.profile,
                      selected: currentIndex == 3,
                      onTap: () => ref.read(mainNavigationIndexProvider.notifier).state = 3,
                    ),
                    tile(
                      icon: Icons.settings_rounded,
                      label: AppLocalizations.of(context)!.settings,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage())),
                    ),
                    tile(
                      icon: Icons.contact_page_outlined,
                      label: AppLocalizations.of(context)!.contactUs,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactFormPage())),
                    ),
                    const SizedBox(height: 12),
                    // Logout button anchored near bottom with destructive style
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        AppLocalizations.of(context)!.logout,
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onTap: () async {
                        try {
                          final storage = ref.read(secureStorageProvider);
                          final token = await storage.getFcmToken();
                          if (token != null) {
                            await ref.read(profileRepositoryProvider).unregisterDevice(token);
                          }
                        } catch (_) {
                          // ignore failures removing device token
                        }

                        final loginController = ref.read(loginControllerProvider.notifier);
                        await loginController.logout();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
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
