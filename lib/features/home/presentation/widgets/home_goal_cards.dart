import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeGeneralObjectiveCard extends StatelessWidget {
  const HomeGeneralObjectiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      child: _GoalContent(
        icon: Icons.arrow_upward_rounded,
        title: l10n.generalObjectiveTitle,
        description: l10n.generalObjectiveDescription,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class HomeVisionCard extends StatelessWidget {
  const HomeVisionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      child: _GoalContent(
        icon: Icons.visibility_outlined,
        title: l10n.visionTitle,
        description: l10n.visionDescription,
        color: Colors.green,
      ),
    );
  }
}

class HomeMissionCard extends StatelessWidget {
  const HomeMissionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AppCard(
      child: _GoalContent(
        icon: Icons.groups_outlined,
        title: l10n.missionTitle,
        description: l10n.missionDescription,
        color: Colors.deepPurple,
      ),
    );
  }
}

class _GoalContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _GoalContent({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: AppSpacing.item),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(description, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}
