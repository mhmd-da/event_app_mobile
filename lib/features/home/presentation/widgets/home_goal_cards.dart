import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeGeneralObjectiveCard extends StatelessWidget {
  const HomeGeneralObjectiveCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _GoalContent(
      icon: Icons.track_changes,
      title: l10n.generalObjectiveTitle,
      description: l10n.generalObjectiveDescription,
      iconColor: const Color(0xFF1E88E5),
      borderColor: const Color(0xFFE3F2FD),
    );
  }
}

class HomeVisionCard extends StatelessWidget {
  const HomeVisionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _GoalContent(
      icon: Icons.visibility_outlined,
      title: l10n.visionTitle,
      description: l10n.visionDescription,
      iconColor: const Color(0xFF26A69A),
      borderColor: const Color(0xFFE0F2F1),
    );
  }
}

class HomeMissionCard extends StatelessWidget {
  const HomeMissionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _GoalContent(
      icon: Icons.groups_outlined,
      title: l10n.missionTitle,
      description: l10n.missionDescription,
      iconColor: const Color(0xFF5E35B1),
      borderColor: const Color(0xFFEDE7F6),
    );
  }
}

class _GoalContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color iconColor;
  final Color borderColor;

  const _GoalContent({
    required this.icon,
    required this.title,
    required this.description,
    required this.iconColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.only(
        left: AppSpacing.section,
        right: AppSpacing.section,
      ),
      padding: const EdgeInsets.all(AppSpacing.section),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(height: AppSpacing.item),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: iconColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 15,
              height: 2.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
