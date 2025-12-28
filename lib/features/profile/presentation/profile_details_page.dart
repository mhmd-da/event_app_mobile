import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/info_row.dart';
import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:event_app/features/profile/presentation/update_profile_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String _displayOrDash(String? value) {
  final v = value?.trim() ?? '';
  return v.isEmpty ? '—' : v;
}

class ProfileDetailsPage extends ConsumerWidget {
  const ProfileDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      title: l10n.profileDetails,
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            l10n.somethingWentWrong,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        data: (profile) {
          final name = [
            profile.title,
            profile.firstName,
            profile.lastName,
          ].where((e) => (e ?? '').trim().isNotEmpty).join(' ');

          final avatarProvider =
              (profile.profileImageUrl != null &&
                  profile.profileImageUrl!.trim().isNotEmpty)
              ? NetworkImage(profile.profileImageUrl!) as ImageProvider
              : const AssetImage('assets/images/default_avatar.png');

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 34,
                            backgroundImage: avatarProvider,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name.isNotEmpty ? name : l10n.profile,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _displayOrDash(profile.email),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          InfoRow(
                            icon: Icons.phone_outlined,
                            label: l10n.profile_phone,
                            value: _displayOrDash(profile.phone),
                          ),
                          InfoRow(
                            icon: Icons.mail_outline,
                            label: l10n.profile_email,
                            value: _displayOrDash(profile.email),
                          ),
                          InfoRow(
                            icon: Icons.badge_outlined,
                            label: l10n.userIdentifier,
                            value: _displayOrDash(profile.userIdentifier),
                          ),
                          InfoRow(
                            icon: Icons.person_outline,
                            label: l10n.gender,
                            value: _displayOrDash(profile.gender),
                          ),
                          InfoRow(
                            icon: Icons.school_outlined,
                            label: l10n.profile_university,
                            value: _displayOrDash(profile.university),
                          ),
                          InfoRow(
                            icon: Icons.account_tree_outlined,
                            label: l10n.profile_department,
                            value: _displayOrDash(profile.department),
                          ),
                          InfoRow(
                            icon: Icons.book_outlined,
                            label: l10n.profile_major,
                            value: _displayOrDash(profile.major),
                          ),
                          InfoRow(
                            icon: Icons.info_outline,
                            label: l10n.bio,
                            value: _displayOrDash(profile.bio),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppElevatedButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpdateProfilePage(profile: profile),
                        ),
                      );
                      ref.invalidate(profileProvider);
                    },
                    child: Text(l10n.edit),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
