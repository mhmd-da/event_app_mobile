import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeAxesSection extends StatelessWidget {
  const HomeAxesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AppCard(
      title: l10n.forumAxesTitle,
      centerTitle: true,
      useGradient: true,
      child: Column(
        children: [
          _DayCard(
            icon: Icons.settings_suggest_outlined,
            title: l10n.day1Title,
            description: l10n.day1Description,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.item),
          _DayCard(
            icon: Icons.psychology_alt_outlined,
            title: l10n.day2Title,
            description: l10n.day2Description,
            color: theme.colorScheme.secondary,
          ),
          const SizedBox(height: AppSpacing.item),
          _DayCard(
            icon: Icons.people_outline,
            title: l10n.day3Title,
            description: l10n.day3Description,
            color: theme.colorScheme.tertiary ?? theme.colorScheme.primary,
          ),
        ],
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _DayCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: AppSpacing.item),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
