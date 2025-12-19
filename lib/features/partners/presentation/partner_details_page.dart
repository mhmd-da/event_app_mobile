import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/partners/domain/partner_model.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerDetailsPage extends StatelessWidget {
  const PartnerDetailsPage({super.key, required this.partner});

  final PartnerModel partner;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: partner.name,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: Image.network(
                    partner.logoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.section),
            Text(partner.name, style: AppTextStyles.headlineMedium),
            const SizedBox(height: AppSpacing.item),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Chip(label: '${AppLocalizations.of(context)!.type}: ${partner.type}'),
              ],
            ),
            const SizedBox(height: AppSpacing.section),
            if (partner.websiteUrl != null && partner.websiteUrl!.isNotEmpty)
              ElevatedButton.icon(
                icon: const Icon(Icons.open_in_new),
                label: Text(AppLocalizations.of(context)!.openWebsite),
                onPressed: () async {
                  final uri = Uri.parse(partner.websiteUrl!);
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
        color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(label, style: AppTextStyles.bodySmall),
    );
  }
}
