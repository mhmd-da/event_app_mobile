import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/image_card.dart';
import 'package:event_app/core/widgets/info_row_card.dart';
import 'package:event_app/core/widgets/listing_view_toggle.dart';
import 'package:event_app/core/widgets/search_bar.dart';
import 'package:event_app/features/speakers/presentation/speaker_details_page.dart';
import 'package:event_app/features/speakers/presentation/speaker_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpeakersPage extends ConsumerWidget {
  const SpeakersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speakersAsync = ref.watch(speakersListProvider);
    final searchText = ref.watch(speakerSearchTextProvider);
    final viewType = ref.watch(speakersViewTypeProvider);

    return AppScaffold(
      title: AppLocalizations.of(context)!.speakers,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -------- SEARCH BAR TOP --------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page, vertical: AppSpacing.small),
            child: Row(
              children: [
                Expanded(
                  child: CustomSearchBar(
                    padding: EdgeInsets.zero,
                    onChanged: (text) => ref.read(speakerSearchTextProvider.notifier).set(text),
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                ListingViewToggle(
                  value: viewType,
                  onChanged: (v) => ref.read(speakersViewTypeProvider.notifier).set(v),
                ),
              ],
            ),
          ),
          Expanded(
            child: speakersAsync.when(
              data: (list) {
                // -------- APPLY LOCAL SEARCH FILTER --------
                final filtered = searchText.trim().isEmpty
                  ? list
                  : list.where((person) {
                    final combined =
                      "${person.title} ${person.firstName} ${person.lastName} "
                          "${person.companyName ?? ''} "
                          "${person.position ?? ''}"
                        .toLowerCase();
                    return combined.contains(searchText.toLowerCase());
                    }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.noSpeakersFound),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.refresh(speakersListProvider.future);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.page),
                    child: viewType == ListingViewType.imageCard
                        ? GridView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppSpacing.section,
                              crossAxisSpacing: AppSpacing.section,
                              childAspectRatio: 0.80,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final speaker = filtered[index];
                              return ImageCard(
                                imageUrl: speaker.profileImageUrl,
                                cardTitle: "${speaker.title} ${speaker.firstName} ${speaker.lastName}",
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => SpeakerDetailsPage(speakerId: speaker.id)),
                                ),
                              );
                            },
                          )
                        : ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.item),
                            itemBuilder: (context, index) {
                              final speaker = filtered[index];
                              final name = "${speaker.title} ${speaker.firstName} ${speaker.lastName}";
                              final descParts = [
                                if ((speaker.position ?? '').isNotEmpty) speaker.position!,
                                if ((speaker.companyName ?? '').isNotEmpty) 'at ${speaker.companyName!}',
                              ];
                              final description = descParts.join(' ');
                              return InfoRowCard(
                                imageUrl: speaker.profileImageUrl,
                                title: name,
                                description: description,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => SpeakerDetailsPage(speakerId: speaker.id)),
                                ),
                              );
                            },
                          ),
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(
                child: Text(
                  '${AppLocalizations.of(context)!.errorLoadingSpeakers}: $err',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}