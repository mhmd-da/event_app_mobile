import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/image_card.dart';
import 'package:event_app/core/widgets/info_row_card.dart';
import 'package:event_app/core/widgets/listing_view_toggle.dart';
import 'package:event_app/core/widgets/search_bar.dart';
import 'package:event_app/features/mentors/presentation/mentor_details_page.dart';
import 'package:event_app/features/mentors/presentation/mentor_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';

class MentorsPage extends ConsumerWidget {
  const MentorsPage({super.key}); // no underscore prefix
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mentorsAsync = ref.watch(mentorsListProvider);
    final searchText = ref.watch(mentorSearchTextProvider);
    final viewType = ref.watch(mentorsViewTypeProvider);

    return AppScaffold(
      title: AppLocalizations.of(context)!.mentors,
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
                    onChanged: (text) => ref.read(mentorSearchTextProvider.notifier).set(text),
                  ),
                ),
                const SizedBox(width: AppSpacing.small),
                ListingViewToggle(
                  value: viewType,
                  onChanged: (v) => ref.read(mentorsViewTypeProvider.notifier).set(v),
                ),
              ],
            ),
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
                    child: viewType == ListingViewType.imageCard
                        ? GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppSpacing.section,
                              crossAxisSpacing: AppSpacing.section,
                              childAspectRatio: 0.80,
                            ),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final mentor = filtered[index];
                              return ImageCard(
                                imageUrl: mentor.profileImageUrl,
                                cardTitle: "${mentor.title} ${mentor.firstName} ${mentor.lastName}",
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => MentorDetailsPage(mentorId: mentor.id)),
                                ),
                              );
                            },
                          )
                        : ListView.separated(
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.item),
                            itemBuilder: (context, index) {
                              final mentor = filtered[index];
                              final name = "${mentor.title} ${mentor.firstName} ${mentor.lastName}";
                              final descParts = [
                                if ((mentor.position ?? '').isNotEmpty) mentor.position!,
                                if ((mentor.companyName ?? '').isNotEmpty) 'at ${mentor.companyName!}',
                              ];
                              final description = descParts.join(' ');
                              return InfoRowCard(
                                imageUrl: mentor.profileImageUrl,
                                title: name,
                                description: description,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => MentorDetailsPage(mentorId: mentor.id)),
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
