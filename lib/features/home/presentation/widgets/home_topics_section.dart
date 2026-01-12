import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeAxesSection extends StatelessWidget {
  const HomeAxesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        Text(
          l10n.eventTopicsTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF2D9CDB),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        _DayCard(
          icon: Icons.settings_suggest_outlined,
          title: l10n.day1Title,
          description: l10n.day1Description,
        ),
        const SizedBox(height: AppSpacing.section),
        _DayCard(
          icon: Icons.psychology_alt_outlined,
          title: l10n.day2Title,
          description: l10n.day2Description,
        ),
        const SizedBox(height: AppSpacing.section),
        _DayCard(
          icon: Icons.people_outline,
          title: l10n.day3Title,
          description: l10n.day3Description,
        ),
      ],
    );
  }
}

class _DayCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _DayCard({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: AppSpacing.section, right: AppSpacing.section),
      decoration: BoxDecoration(
        color: Colors.white,
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
      padding: const EdgeInsets.all(AppSpacing.section),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 64,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: AppSpacing.item),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2D9CDB),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 18,
              height: 1.8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
