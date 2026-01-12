import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeQuoteSection extends StatelessWidget {
  const HomeQuoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return AppCard(
      // No title to match screenshot style
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder styled similar to screenshot
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 120,
              height: 160,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1F1F1F), Color(0xFF3A3A3A)],
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.item),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.format_quote, color: theme.colorScheme.primary),
                const SizedBox(height: 6),
                Text(
                  l10n.homeQuoteText,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.item),
                Icon(Icons.format_quote, color: theme.colorScheme.primary),
                const SizedBox(height: AppSpacing.item),
                Text(
                  l10n.homeQuoteLeaderTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.homeQuoteLeaderName,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.homeQuoteLeaderRole,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
