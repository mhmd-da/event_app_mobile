import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/tappable_circle_image.dart';
import 'package:event_app/features/sponsors/domain/sponsor_model.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorDetailsPage extends StatelessWidget {
  const SponsorDetailsPage({super.key, required this.sponsor});

  final SponsorModel sponsor;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: sponsor.name,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: TappableCircleImage(
                imageUrl: sponsor.logoUrl,
                radius: 56,
                placeholderIcon: Icons.business_outlined,
              ),
            ),
            const SizedBox(height: AppSpacing.section),

            // Basic details
            Text(sponsor.name, style: AppTextStyles.headlineMedium),
            const SizedBox(height: AppSpacing.item),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Chip(
                  label:
                      '${AppLocalizations.of(context)!.category}: ${sponsor.category}',
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.section),

            if (sponsor.websiteUrl != null && sponsor.websiteUrl!.isNotEmpty)
              AppElevatedButton(
                icon: const Icon(Icons.open_in_new),
                label: Text(AppLocalizations.of(context)!.openWebsite),
                onPressed: () async {
                  final uri = Uri.parse(sponsor.websiteUrl!);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  const _Chip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(label, style: AppTextStyles.bodySmall),
    );
  }
}
