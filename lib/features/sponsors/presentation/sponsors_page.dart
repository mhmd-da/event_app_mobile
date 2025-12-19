import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/image_card.dart';
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

    return AppScaffold(
      title: AppLocalizations.of(context)!.sponsors,
      body: sponsorsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('${AppLocalizations.of(context)!.somethingWentWrong}: $e')),
        data: (items) {
          if (items.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noSessionsAvailable));
          }

          // Group by category
          final grouped = groupBy(items, (e) => e.category);
          final groups = grouped.entries.toList();

          return ListView.builder(
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
                    child: Text(group.key, style: Theme.of(context).textTheme.titleLarge),
                  ),
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
                  ),
                  const SizedBox(height: AppSpacing.section * 1.5),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
