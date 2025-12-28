import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:event_app/features/qr/presentation/my_qr_page.dart';
import 'package:event_app/features/settings/presentation/settings_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/shared/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_scaffold.dart';
import 'profile_details_page.dart';
import '../../auth/presentation/login_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    final l10n = AppLocalizations.of(context)!;
    return AppScaffold(
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(l10n.somethingWentWrong, style: AppTextStyles.bodyMedium),
        ),
        data: (profile) {
          final themeMode = ref.watch(appThemeModeProvider);
          final isDark =
              Theme.of(context).brightness == Brightness.dark ||
              themeMode == ThemeMode.dark;
          final name = [
            profile.title,
            profile.firstName,
            profile.lastName,
          ].where((e) => (e ?? '').trim().isNotEmpty).join(' ');
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with background color and centered avatar
                CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 44,
                    backgroundImage: profile.profileImageUrl != null
                        ? NetworkImage(profile.profileImageUrl!)
                        : const AssetImage('assets/images/default_avatar.png')
                              as ImageProvider,
                  ),
                ),
                const SizedBox(height: 72),
                // Name + contact card
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            name.isNotEmpty ? name : l10n.profile,
                            style: AppTextStyles.headlineLarge.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        _kvRow(
                          context,
                          label: l10n.profile_phone,
                          value: profile.phone ?? '—',
                        ),
                        const SizedBox(height: 8),
                        _kvRow(
                          context,
                          label: l10n.profile_email,
                          value: profile.email ?? '—',
                        ),
                        const SizedBox(height: 8),
                        _kvRow(
                          context,
                          label: l10n.userIdentifier,
                          value: profile.userIdentifier ?? '—',
                        ),
                        // const SizedBox(height: 4),
                        // Text(
                        //   l10n.notEditable,
                        //   style: AppTextStyles.bodyMedium.copyWith(
                        //     color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // List options
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      SwitchListTile(
                        secondary: const Icon(Icons.nightlight_round),
                        title: Text(l10n.darkMode),
                        value: isDark,
                        onChanged: (val) {
                          final notifier = ref.read(
                            appThemeModeProvider.notifier,
                          );
                          notifier.set(val ? ThemeMode.dark : ThemeMode.light);
                        },
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.person_outline),
                        title: Text(l10n.profileDetails),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfileDetailsPage(),
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.qr_code_2_rounded),
                        title: Text(l10n.myQrTitle),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MyQrPage()),
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.tune_outlined),
                        title: Text(l10n.settings),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsPage(),
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: Text(
                          l10n.logout,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () async {
                          final loginController = ref.read(
                            loginControllerProvider.notifier,
                          );
                          await loginController.logout();
                          if (context.mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _kvRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        Text(value, style: AppTextStyles.bodyMedium),
      ],
    );
  }
}
