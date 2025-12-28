import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/partners/domain/partner_model.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:event_app/core/widgets/info_row.dart';

class PartnerDetailsPage extends StatelessWidget {
  const PartnerDetailsPage({super.key, required this.partner});
  final PartnerModel partner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return AppScaffold(
      title: partner.name,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner with full-width logo
            Container(
              height: 180,
              width: double.infinity,
              color: theme.colorScheme.primary,
              child: partner.logoUrl.isNotEmpty
                  ? Image.network(
                      partner.logoUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 180,
                    )
                  : null,
            ),
            // Name and category below banner, centered and styled
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    partner.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  if (partner.type.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(theme.brightness == Brightness.dark ? 0.18 : 0.08),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        partner.type,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),

            // Single card for all contact info (except website)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Card(
                color: theme.brightness == Brightness.dark ? theme.colorScheme.surfaceVariant : theme.colorScheme.surface,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.contactInfo, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      if (partner.contactEmail != null && partner.contactEmail!.isNotEmpty)
                        InfoRow(
                          icon: Icons.email,
                          label: l10n.email,
                          value: partner.contactEmail!,
                          copyable: true,
                        ),
                      if (partner.contactMobile != null && partner.contactMobile!.isNotEmpty)
                        InfoRow(
                          icon: Icons.phone_android,
                          label: l10n.mobile,
                          value: partner.contactMobile!,
                          copyable: true,
                        ),
                      if (partner.contactPhone != null && partner.contactPhone!.isNotEmpty)
                        InfoRow(
                          icon: Icons.phone,
                          label: l10n.phone,
                          value: partner.contactPhone!,
                          copyable: true,
                        ),
                      if (partner.contactName != null && partner.contactName!.isNotEmpty)
                        InfoRow(
                          icon: Icons.person,
                          label: l10n.name,
                          value: partner.contactName!,
                          copyable: false,
                        ),
                      if (partner.contactPosition != null && partner.contactPosition!.isNotEmpty)
                        InfoRow(
                          icon: Icons.work,
                          label: l10n.position,
                          value: partner.contactPosition!,
                          copyable: false,
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Website title and card
            if (partner.websiteUrl != null && partner.websiteUrl!.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(l10n.website, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Card(
                  color: theme.brightness == Brightness.dark ? theme.colorScheme.surfaceVariant : theme.colorScheme.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    child: InfoRow(
                      icon: Icons.language,
                      label: l10n.website,
                      value: partner.websiteUrl!,
                      copyable: true,
                      onTap: () async {
                        final uri = Uri.parse(partner.websiteUrl!);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],





            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

