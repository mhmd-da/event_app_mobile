import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/core/widgets/person_extra_cards.dart';
import 'package:event_app/features/mentors/presentation/mentor_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:event_app/core/widgets/info_row.dart';
import 'package:event_app/core/widgets/tappable_circle_image.dart';

class MentorDetailsPage extends ConsumerStatefulWidget {
  final int mentorId;
  const MentorDetailsPage({super.key, required this.mentorId});

  @override
  ConsumerState<MentorDetailsPage> createState() => _MentorDetailsPageState();
}

class _MentorDetailsPageState extends ConsumerState<MentorDetailsPage> {
  bool _didAutoRefresh = false;
  bool _isAutoRefreshing = false;

  @override
  Widget build(BuildContext context) {
    final mentorsAsync = ref.watch(mentorsListProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return mentorsAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, st) => Scaffold(
        body: Center(child: Text('${l10n.errorLoadingMentors}: $e')),
      ),
      data: (mentors) {
        final person = mentors
            .where((m) => m.id == widget.mentorId)
            .firstOrNull;
        if (person == null) {
          if (!_didAutoRefresh) {
            _didAutoRefresh = true;
            _isAutoRefreshing = true;
            Future.microtask(() async {
              try {
                await ref.refresh(mentorsListProvider.future);
              } finally {
                if (!mounted) return;
                setState(() => _isAutoRefreshing = false);
              }
            });
          }

          if (_isAutoRefreshing) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return Scaffold(body: Center(child: Text(l10n.noMentorsFound)));
        }

        return AppScaffold(
          title: "${person.title} ${person.firstName} ${person.lastName}",
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: TappableCircleImage(
                    imageUrl: person.profileImageUrl,
                    radius: 56,
                    placeholderIcon: Icons.person_outline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
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
                      if ((person.position ?? '').isNotEmpty ||
                          (person.companyName ?? '').isNotEmpty)
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
                            [
                              if ((person.position ?? '').isNotEmpty)
                                person.position,
                              if ((person.companyName ?? '').isNotEmpty)
                                person.companyName,
                            ].whereType<String>().join(' - '),
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

                if ((person.email ?? '').isNotEmpty ||
                    (person.phoneNumber ?? '').isNotEmpty)
                  AppCard(
                    title: l10n.contactInfo,
                    centerTitle: true,
                    useGradient: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if ((person.email ?? '').isNotEmpty)
                          InfoRow(
                            icon: Icons.email,
                            label: l10n.email,
                            value: person.email!,
                            copyable: true,
                          ),
                        if ((person.phoneNumber ?? '').isNotEmpty)
                          InfoRow(
                            icon: Icons.phone,
                            label: l10n.phone,
                            value: person.phoneNumber!,
                            copyable: true,
                          ),
                      ],
                    ),
                  ),

                if ((person.bio ?? '').isNotEmpty)
                  AppCard(
                    title: l10n.bio,
                    centerTitle: true,
                    useGradient: true,
                    child: Text(person.bio!, style: theme.textTheme.bodyLarge),
                  ),

                PersonSessionsCard(
                  title: l10n.sessions,
                  emptyText: l10n.noSessionsLinkedYet,
                  sessions: person.sessions,
                  getTitle: (s) => s.title,
                  getStartTime: (s) => s.startTime,
                  getEndTime: (s) => s.endTime,
                  getLocation: (s) => s.location,
                ),

                PersonSocialLinksCard(
                  title: l10n.socialLinks,
                  emptyText: l10n.noSocialLinksAvailable,
                  links: person.socialLinks ?? const [],
                  getName: (l) => l.name,
                  getUrl: (l) => l.url,
                  getThumbnailUrl: (l) => l.thumbnail,
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
