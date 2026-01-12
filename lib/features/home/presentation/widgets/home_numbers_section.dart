import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeNumbersSection extends StatelessWidget {
  const HomeNumbersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      title: l10n.homeNumbersTitle,
      centerTitle: true,
      useGradient: true,
      child: _NumbersGrid(
        items: [
          _StatItem(label: l10n.homeNumbersGuidanceHours, value: 38),
          _StatItem(label: l10n.homeNumbersSpeakersExperts, value: 62),
          _StatItem(label: l10n.homeNumbersParticipatingEntities, value: 11),
          _StatItem(label: l10n.homeNumbersWorkshopsExperiences, value: 15),
          _StatItem(label: l10n.homeNumbersVolunteers, value: 77),
        ],
      ),
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
              width: constraints.maxWidth,
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
    final color = theme.colorScheme;

    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: theme.brightness == Brightness.dark
          ? color.surfaceVariant
          : color.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "+${item.value}",
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: color.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
