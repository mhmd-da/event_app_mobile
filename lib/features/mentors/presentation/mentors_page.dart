import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/image_card.dart';
import 'package:event_app/core/widgets/search_bar.dart';
import 'package:event_app/features/mentors/presentation/mentor_details_page.dart';
import 'package:event_app/features/mentors/presentation/mentor_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';

// Holds the current search text typed in the CustomSearchBar
final mentorSearchTextProvider = StateProvider<String>((ref) => "");

class MentorsPage extends ConsumerWidget {
  const MentorsPage({super.key}); // no underscore prefix
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mentorsAsync = ref.watch(mentorsListProvider);
    final searchText = ref.watch(mentorSearchTextProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.mentors)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -------- SEARCH BAR TOP --------
          CustomSearchBar(
            onChanged: (text) =>
                ref.read(mentorSearchTextProvider.notifier).state = text,
          ),
          Expanded(
            child: mentorsAsync.when(
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
                    child: Text(AppLocalizations.of(context)!.noMentorsFound),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(mentorsListProvider),
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
                        final mentor = filtered[index];
                        return ImageCard(
                          imageUrl: mentor.profileImageUrl,
                          cardTitle:
                              "${mentor.title} ${mentor.firstName} ${mentor.lastName}",
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MentorDetailsPage(mentor),
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
                  '${AppLocalizations.of(context)!.errorLoadingMentors}: $err',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
