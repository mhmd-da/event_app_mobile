import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/features/home/presentation/venue_map_page.dart';
import 'package:event_app/features/home/presentation/widgets/home_announcements.dart';
import 'package:event_app/features/home/presentation/widgets/home_header.dart';
import 'package:event_app/features/home/presentation/widgets/home_quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_section_title.dart';
import '../../../core/theme/app_spacing.dart';
import 'about_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(selectedEventProvider);

    if (event == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          const SizedBox(height: AppSpacing.section),
          const AppSectionTitle(title: "Quick Actions"),
          const SizedBox(height: AppSpacing.item),
          const QuickActionsGrid(),
          const SizedBox(height: AppSpacing.section),
          const AppSectionTitle(title: "Announcements"),
          const SizedBox(height: AppSpacing.item),
          const AnnouncementCard(),
          const SizedBox(height: AppSpacing.section),
          const AppSectionTitle(title: "About Event"),
          const SizedBox(height: AppSpacing.item),
          const AboutCard(),
          const SizedBox(height: AppSpacing.section),
          const AppSectionTitle(title: "Venue & Info"),
          const SizedBox(height: AppSpacing.item),
          const VenueInfoList(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
