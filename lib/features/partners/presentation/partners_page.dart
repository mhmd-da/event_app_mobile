import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/image_card.dart';
import 'package:event_app/core/widgets/info_row_card.dart';
import 'package:event_app/core/widgets/listing_view_toggle.dart';
import 'package:event_app/core/widgets/group_ribbon.dart';
import 'package:event_app/core/widgets/search_bar.dart';
import 'package:event_app/features/partners/presentation/partner_providers.dart';
import 'package:event_app/features/partners/presentation/partner_details_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

class PartnersPage extends ConsumerWidget {
  const PartnersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partnersAsync = ref.watch(partnersListProvider);
    final viewType = ref.watch(partnersViewTypeProvider);
    final searchText = ref.watch(partnerSearchTextProvider);

    return AppScaffold(
      title: AppLocalizations.of(context)!.partners,
      body: partnersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('${AppLocalizations.of(context)!.somethingWentWrong}: $e')),
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noSessionsAvailable));
          }

            final base = searchText.trim().isEmpty
              ? items
              : items.where((p) => (p.name).toLowerCase().contains(searchText.toLowerCase())).toList();
            final grouped = groupBy(base, (e) => e.type);
          final groups = grouped.entries.toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page, vertical: AppSpacing.small),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomSearchBar(
                        padding: EdgeInsets.zero,
                        onChanged: (text) => ref.read(partnerSearchTextProvider.notifier).set(text),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.small),
                    ListingViewToggle(
                      value: viewType,
                      onChanged: (v) => ref.read(partnersViewTypeProvider.notifier).set(v),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await ref.refresh(partnersListProvider.future);
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                            child: GroupRibbon(label: group.key, colorResolver: _partnerRibbonColor),
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
                                final p = list[i];
                                return ImageCard(
                                  imageUrl: p.logoUrl,
                                  cardTitle: p.name,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PartnerDetailsPage(partner: p),
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
                                final p = list[i];
                                return InfoRowCard(
                                  imageUrl: p.logoUrl,
                                  title: p.name,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PartnerDetailsPage(partner: p),
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
              ),
            ],
          );
        },
      ),
    );
  }
}

Color _partnerRibbonColor(String label, ThemeData theme) {
  // Deterministic color selection for arbitrary labels using a curated palette
  final palette = <Color>[
    Colors.teal.shade600,
    Colors.indigo.shade600,
    Colors.purple.shade600,
    Colors.deepOrange.shade500,
    Colors.blue.shade600,
    Colors.green.shade600,
    Colors.pink.shade400,
  ];
  final normalized = label.trim().toUpperCase();
  int hash = 0;
  for (final ch in normalized.runes) {
    hash = (hash * 31 + ch) & 0x7fffffff;
  }
  final idx = hash % palette.length;
  return palette[idx];
}
