import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/image_card.dart';
import 'package:event_app/core/widgets/search_bar.dart';
import 'package:event_app/features/speakers/presentation/speaker_details_page.dart';
import 'package:event_app/features/speakers/presentation/speaker_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Holds the current search text typed in the CustomSearchBar
final speakerSearchTextProvider = StateProvider<String>((ref) => "");

class SpeakersPage extends ConsumerWidget {
  const SpeakersPage({super.key}); // no underscore prefix

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speakersAsync = ref.watch(speakersListProvider);
    final searchText = ref.watch(speakerSearchTextProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.speakers)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -------- SEARCH BAR TOP --------
          CustomSearchBar(
            onChanged: (text) =>
                ref.read(speakerSearchTextProvider.notifier).state = text,
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
                  onRefresh: () async => ref.invalidate(speakersListProvider),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.page),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: AppSpacing.section,
                        crossAxisSpacing: AppSpacing.section,
                        childAspectRatio: 0.80, // MATCHES EXPLORE PAGE STYLE
                      ),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final speaker = filtered[index];
                        return ImageCard(
                          imageUrl: speaker.profileImageUrl,
                          cardTitle:
                              "${speaker.title} ${speaker.firstName} ${speaker.lastName}",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SpeakerDetailsPage(speaker),
                            ),
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