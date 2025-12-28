import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/image_card.dart';
import 'package:event_app/core/widgets/info_row_card.dart';
import 'package:event_app/core/widgets/group_ribbon.dart';
import 'package:event_app/core/widgets/search_bar.dart';
import 'package:event_app/core/widgets/listing_view_toggle.dart';
import 'package:event_app/features/sponsors/presentation/sponsor_providers.dart';
import 'package:event_app/features/sponsors/presentation/sponsor_details_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class SponsorsPage extends ConsumerWidget {
  const SponsorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sponsorsAsync = ref.watch(sponsorsListProvider);
    final viewType = ref.watch(sponsorsViewTypeProvider);
    final searchText = ref.watch(sponsorSearchTextProvider);

    return AppScaffold(
      title: AppLocalizations.of(context)!.sponsors,
      body: sponsorsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('${AppLocalizations.of(context)!.somethingWentWrong}: $e')),
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noSessionsAvailable));
          }

            // Local filter by name
            final base = searchText.trim().isEmpty
              ? items
              : items.where((s) => (s.name).toLowerCase().contains(searchText.toLowerCase())).toList();

            // Group by category
            final grouped = groupBy(base, (e) => e.category);
          final groups = grouped.entries.toList();

          return Column(
            children: [
              // Toggle row (right-aligned)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page, vertical: AppSpacing.small),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSearchBar(
                        padding: EdgeInsets.zero,
                        onChanged: (text) => ref.read(sponsorSearchTextProvider.notifier).set(text),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.small),
                    ListingViewToggle(
                      value: viewType,
                      onChanged: (v) => ref.read(sponsorsViewTypeProvider.notifier).set(v),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppSpacing.page),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final group = groups[index];
                    final list = [...group.value]..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.item),
                          child: GroupRibbon(label: group.key),
                        ),
                        if (viewType == ListingViewType.imageCard)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: AppSpacing.section,
                              crossAxisSpacing: AppSpacing.section,
                              childAspectRatio: 0.80,
                            ),
                            itemCount: list.length,
                            itemBuilder: (context, i) {
                              final s = list[i];
                              return ImageCard(
                                imageUrl: s.logoUrl,
                                cardTitle: s.name,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SponsorDetailsPage(sponsor: s),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.item),
                            itemBuilder: (context, i) {
                              final s = list[i];
                              return InfoRowCard(
                                imageUrl: s.logoUrl,
                                title: s.name,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SponsorDetailsPage(sponsor: s),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        const SizedBox(height: AppSpacing.section * 1.5),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
