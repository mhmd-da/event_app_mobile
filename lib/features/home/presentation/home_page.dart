import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/features/home/presentation/venue_map_page.dart';
import 'package:event_app/features/home/presentation/widgets/home_header.dart';
import 'package:event_app/features/home/presentation/widgets/home_numbers_section.dart';
import 'package:event_app/features/home/presentation/widgets/home_countdown_section.dart';
import 'package:event_app/features/home/presentation/widgets/home_quote_section.dart';
import 'package:event_app/features/home/presentation/widgets/home_quick_actions.dart';
import 'package:event_app/features/home/presentation/widgets/home_axes_section.dart';
import 'package:event_app/features/home/presentation/widgets/home_goal_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_section_title.dart';
import '../../../core/theme/app_spacing.dart';
import 'about_page.dart';
import 'package:event_app/l10n/app_localizations.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final eventAsync = ref.watch(selectedEventProvider);

    return eventAsync.when(
      data: (event) {
        if (event == null) {
          return const Center(child: Text('No event selected'));
        }
        
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SizedBox(height: AppSpacing.section),
              const HomeNumbersSection(),
              const SizedBox(height: AppSpacing.section),
              const HomeCountdownSection(),
              const SizedBox(height: AppSpacing.section),
              const HomeQuoteSection(),
              const SizedBox(height: AppSpacing.section),
              AppSectionTitle(title: l10n.quickActions),
              const SizedBox(height: AppSpacing.item),
              const QuickActionsGrid(),
              const SizedBox(height: AppSpacing.section),
              // AppSectionTitle(title: l10n.aboutEvent),
              const SizedBox(height: AppSpacing.item),
              const AboutCard(),
              const SizedBox(height: AppSpacing.section),
              const HomeGeneralObjectiveCard(),
              const SizedBox(height: AppSpacing.section),
              const HomeVisionCard(),
              const SizedBox(height: AppSpacing.section),
              const HomeMissionCard(),
              const SizedBox(height: AppSpacing.section),
              const HomeAxesSection(),
              const SizedBox(height: AppSpacing.section),
              // AppSectionTitle(title: l10n.venueAndInfo),
              const SizedBox(height: AppSpacing.item),
              const VenueInfoList(),
              const SizedBox(height: 80),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error loading event: $error'),
      ),
    );
  }


}
