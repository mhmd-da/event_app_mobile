import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/mentors/presentation/mentor_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:event_app/core/widgets/info_row.dart';

class MentorDetailsPage extends ConsumerWidget {
  final int mentorId;
  const MentorDetailsPage({super.key, required this.mentorId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDetails = ref.watch(mentorDetailsProvider(mentorId));
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return asyncDetails.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (person) => AppScaffold(
        title: "${person.title} ${person.firstName} ${person.lastName}",
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Banner with full-width image
              Container(
                height: 180,
                width: double.infinity,
                color: theme.colorScheme.primary,
                child: (person.profileImageUrl != null && person.profileImageUrl!.isNotEmpty)
                    ? Image.network(
                        person.profileImageUrl!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 180,
                      )
                    : null,
              ),
              // Name and position/company below banner
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${person.title} ${person.firstName} ${person.lastName}",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    if ((person.position ?? '').isNotEmpty || (person.companyName ?? '').isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(theme.brightness == Brightness.dark ? 0.18 : 0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          [if ((person.position ?? '').isNotEmpty) person.position, if ((person.companyName ?? '').isNotEmpty) person.companyName].whereType<String>().join(' - '),
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

              // Contact/social info card
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
                        for (final link in (person.socialLinks ?? []))
                          InfoRow(
                            icon: Icons.link,
                            label: link.name ?? 'Link',
                            value: link.url,
                            copyable: true,
                            onTap: () async {
                              final uri = Uri.parse(link.url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri, mode: LaunchMode.externalApplication);
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bio
              if ((person.bio ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Card(
                    color: theme.brightness == Brightness.dark ? theme.colorScheme.surfaceVariant : theme.colorScheme.surface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      child: Text(
                        person.bio!,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

