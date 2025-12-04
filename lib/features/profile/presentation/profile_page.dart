import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/features/profile/domain/profile_model.dart';
import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_scaffold.dart';
import 'package:event_app/features/profile/presentation/update_profile_page.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final locale = ref.watch(languageProvider);

    return AppScaffold(
      body: profileAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error', style: AppTextStyles.bodyMedium),
        ),
        data: (profile) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Align(
                        alignment:
                            Alignment.topLeft, // Positioned in the corner
                        child: IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateProfilePage(profile: profile),
                            ),
                          ),
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                            size: 30, // Increased size for better visibility
                          ),
                          //tooltip: AppLocalizations.of(context)!.updateProfile,
                        ),
                      ),
                    ),
                    Flexible(
                      child: DropdownButton<String>(
                        value: ref.watch(languageProvider).languageCode, // Synchronize with languageProvider
                        onChanged: (String? newLanguage) async {
                          if (newLanguage != null) {
                            try {
                              // Update the app's language
                              ref.read(languageProvider.notifier).setLanguage(newLanguage);

                              // Call the changeLanguageProvider
                              await ref.read(changeLanguageProvider(newLanguage).future);

                              // Show success feedback
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppLocalizations.of(context)!.languageUpdated(newLanguage))),
                              );
                            } catch (e) {
                              // Show error feedback
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(AppLocalizations.of(context)!.languageUpdateFailed)),
                              );
                            }
                          }
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'en',
                            child: Text(AppLocalizations.of(context)!.english),
                          ),
                          DropdownMenuItem(
                            value: 'ar',
                            child: Text(AppLocalizations.of(context)!.arabic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                clipBehavior:
                    Clip.none, // Allow the image to overflow the container
                children: [
                  Container(
                    height:
                        200, // Kept the original height of the blue container
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${profile.title} ${profile.firstName} ${profile.lastName}',
                        style: AppTextStyles.headlineLarge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top:
                        150, // Positioned the image to overlap the blue container
                    left:
                        MediaQuery.of(context).size.width / 2 -
                        95, // Centered the image
                    child: CircleAvatar(
                      radius: 70, // Kept the image size consistent
                      backgroundImage: profile.profileImageUrl != null
                          ? NetworkImage(profile.profileImageUrl!)
                          : AssetImage('assets/images/default_avatar.png')
                                as ImageProvider,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.school,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'University: ',
                              style: AppTextStyles.headlineSmall,
                            ),
                            Text(
                              '${profile.university}',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.apartment,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Department: ',
                              style: AppTextStyles.headlineSmall,
                            ),
                            Text(
                              '${profile.department}',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.book,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Text('Major: ', style: AppTextStyles.headlineSmall),
                            Text(
                              '${profile.major}',
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              if (profile.bio != null && profile.bio!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text('Bio: ', style: AppTextStyles.headlineSmall),
                          Expanded(
                            child: Text(
                              profile.bio!,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
