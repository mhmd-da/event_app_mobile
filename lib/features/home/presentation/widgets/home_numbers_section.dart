import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeNumbersSection extends ConsumerWidget {
  const HomeNumbersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final eventAsync = ref.watch(selectedEventProvider);

    return eventAsync.when(
      data: (event) {
        final extra = event?.extra;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF4B5563),
                const Color(0xFF6B7280),
                const Color(0xFF4B5563),
              ],
            ),
          ),
          padding: const EdgeInsets.all(AppSpacing.section),
          child: Column(
            children: [
              Text(
                l10n.homeNumbersTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.section),
              _NumbersGrid(
                items: [
                  _StatItem(
                      label: l10n.homeNumbersSpeakersExperts,
                      value: extra?.speakers ?? 0),
                  _StatItem(
                      label: l10n.homeNumbersGuidanceHours,
                      value: extra?.guidanceHours ?? 0),
                  _StatItem(
                      label: l10n.homeNumbersWorkshopsExperiences,
                      value: extra?.workshopsExperiences ?? 0),
                  _StatItem(
                      label: l10n.homeNumbersParticipatingEntities,
                      value: extra?.participatingEntities ?? 0),
                  _StatItem(
                      label: l10n.homeNumbersVolunteers,
                      value: extra?.volunteers ?? 0),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox(
        height: 300,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
}

class _NumbersGrid extends StatelessWidget {
  final List<_StatItem> items;
  const _NumbersGrid({required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double spacing = AppSpacing.item;
        final double halfWidth = (constraints.maxWidth - spacing) / 2;

        return Column(
          children: [
            Row(
              children: [
                SizedBox(width: halfWidth, child: _StatCard(item: items[0], theme: theme)),
                SizedBox(width: spacing),
                SizedBox(width: halfWidth, child: _StatCard(item: items[1], theme: theme)),
              ],
            ),
            const SizedBox(height: AppSpacing.item),
            Row(
              children: [
                SizedBox(width: halfWidth, child: _StatCard(item: items[2], theme: theme)),
                SizedBox(width: spacing),
                SizedBox(width: halfWidth, child: _StatCard(item: items[3], theme: theme)),
              ],
            ),
            const SizedBox(height: AppSpacing.item),
            SizedBox(
              width: halfWidth,
              child: _StatCard(item: items[4], theme: theme),
            ),
          ],
        );
      },
    );
  }
}

class _StatItem {
  final String label;
  final int value;
  const _StatItem({required this.label, required this.value});
}

class _StatCard extends StatelessWidget {
  final _StatItem item;
  final ThemeData theme;
  const _StatCard({required this.item, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "+${item.value}",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF60D4F7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
