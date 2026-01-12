import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/features/home/presentation/venue_map_page.dart';
import 'package:event_app/features/home/presentation/widgets/home_header.dart';
import 'package:event_app/features/home/presentation/widgets/home_numbers_section.dart';
import 'package:event_app/features/home/presentation/widgets/home_countdown_section.dart';
import 'package:event_app/features/home/presentation/widgets/home_quote_section.dart';
import 'package:event_app/features/home/presentation/widgets/home_quick_actions.dart';
import 'package:event_app/features/home/presentation/widgets/home_topics_section.dart';
import 'package:event_app/features/home/presentation/widgets/home_goal_cards.dart';
import 'package:event_app/features/home/presentation/widgets/home_patronage_card.dart';
import 'package:event_app/features/home/presentation/widgets/home_people_carousel.dart';
import 'package:event_app/features/speakers/presentation/speaker_providers.dart';
import 'package:event_app/features/speakers/presentation/speaker_details_page.dart';
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
              const SizedBox(height: AppSpacing.largeSection),
              const HomeNumbersSection(),
              const HomeCountdownSection(),
              const HomeQuoteSection(),
              //const SizedBox(height: AppSpacing.section),
              //AppSectionTitle(title: l10n.quickActions),
              //const SizedBox(height: AppSpacing.item),
              //const QuickActionsGrid(),
              //const SizedBox(height: AppSpacing.section),
              // AppSectionTitle(title: l10n.aboutEvent),
              const SizedBox(height: AppSpacing.largeSection),
              const AboutCard(),
              const SizedBox(height: AppSpacing.largeSection),
              const HomePatronageCard(),
              const SizedBox(height: AppSpacing.largeSection),
              const HomeGeneralObjectiveCard(),
              const SizedBox(height: AppSpacing.largeSection),
              const HomeVisionCard(),
              const SizedBox(height: AppSpacing.largeSection),
              const HomeMissionCard(),
              const SizedBox(height: AppSpacing.largeSection),
              const SizedBox(height: AppSpacing.largeSection),
              const HomeAxesSection(),
              const SizedBox(height: AppSpacing.largeSection),
              // _buildSpeakersCarousel(context, ref, l10n),
              // const SizedBox(height: AppSpacing.largeSection),
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

  Widget _buildSpeakersCarousel(BuildContext context, WidgetRef ref, AppLocalizations l10n) {
    final speakersAsync = ref.watch(speakersListProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          child: AppSectionTitle(title: l10n.speakers),
        ),
        const SizedBox(height: AppSpacing.item),
        speakersAsync.when(
          data: (items) {
            final carouselItems = items
                .map(
                  (s) => HomeCarouselItem(
                    title: "${s.title} ${s.firstName} ${s.lastName}",
                    subtitle: [
                      if ((s.position ?? '').isNotEmpty) s.position!,
                      if ((s.companyName ?? '').isNotEmpty) s.companyName!,
                    ].join(' - '),
                    imageUrl: s.profileImageUrl,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SpeakerDetailsPage(speakerId: s.id),
                        ),
                      );
                    },
                  ),
                )
                .toList();
            return HomePeopleCarousel(items: carouselItems);
          },
          loading: () => const SizedBox(
            height: 240,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
            child: Text('${l10n.errorLoadingSpeakers}: $e'),
          ),
        ),
      ],
    );
  }
}