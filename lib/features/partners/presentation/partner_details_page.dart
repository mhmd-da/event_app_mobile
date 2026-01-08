import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/features/partners/domain/partner_model.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:event_app/core/widgets/info_row.dart';
import 'package:event_app/core/widgets/tappable_circle_image.dart';

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
            const SizedBox(height: 16),
            Center(
              child: TappableCircleImage(
                imageUrl: partner.logoUrl,
                radius: 56,
                placeholderIcon: Icons.business_outlined,
              ),
            ),
            // Name and category below banner, centered and styled
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(
                          theme.brightness == Brightness.dark ? 0.18 : 0.08,
                        ),
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
              child: AppCard(
                title: l10n.contactInfo,
                centerTitle: true,
                useGradient: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (partner.contactEmail != null &&
                        partner.contactEmail!.isNotEmpty)
                      InfoRow(
                        icon: Icons.email,
                        label: l10n.email,
                        value: partner.contactEmail!,
                        copyable: true,
                      ),
                    if (partner.contactMobile != null &&
                        partner.contactMobile!.isNotEmpty)
                      InfoRow(
                        icon: Icons.phone_android,
                        label: l10n.mobile,
                        value: partner.contactMobile!,
                        copyable: true,
                      ),
                    if (partner.contactPhone != null &&
                        partner.contactPhone!.isNotEmpty)
                      InfoRow(
                        icon: Icons.phone,
                        label: l10n.phone,
                        value: partner.contactPhone!,
                        copyable: true,
                      ),
                    if (partner.contactName != null &&
                        partner.contactName!.isNotEmpty)
                      InfoRow(
                        icon: Icons.person,
                        label: l10n.name,
                        value: partner.contactName!,
                        copyable: false,
                      ),
                    if (partner.contactPosition != null &&
                        partner.contactPosition!.isNotEmpty)
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

            // Website card
            if (partner.websiteUrl != null &&
                partner.websiteUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: AppCard(
                  title: l10n.website,
                  centerTitle: true,
                  useGradient: true,
                  child: InfoRow(
                    icon: Icons.language,
                    label: l10n.website,
                    value: partner.websiteUrl!,
                    copyable: true,
                    onTap: () async {
                      final uri = Uri.parse(partner.websiteUrl!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
