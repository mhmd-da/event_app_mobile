import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/features/profile/domain/update_profile_model.dart';
import 'package:event_app/features/profile/domain/profile_model.dart';
import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_scaffold.dart';

void _showUpdateProfileDialog(BuildContext context, WidgetRef ref, Profile profile) {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController(text: profile.firstName);
  final lastNameController = TextEditingController(text: profile.lastName);
  final bioController = TextEditingController(text: profile.bio);
  final universityController = TextEditingController(text: profile.university);
  final departmentController = TextEditingController(text: profile.department);
  final majorController = TextEditingController(text: profile.major);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Update Profile'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: bioController,
                decoration: InputDecoration(labelText: 'Bio'),
                maxLines: 3,
              ),
              TextFormField(
                controller: universityController,
                decoration: InputDecoration(labelText: 'University'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: departmentController,
                decoration: InputDecoration(labelText: 'Department'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: majorController,
                decoration: InputDecoration(labelText: 'Major'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final updatedProfile = UpdateProfile(
                  id: profile.id,
                  title: profile.title,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  bio: bioController.text,
                  university: universityController.text,
                  department: departmentController.text,
                  major: majorController.text,
                );

                ref.read(updateProfileProvider(updatedProfile));
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

void _changeLanguage(BuildContext context, WidgetRef ref, String language) async {
  final response = await ref.read(profileRepositoryProvider).changeLanguage(language);
  if (response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.languageUpdated(language))),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.languageUpdateFailed)),
    );
  }
}

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return AppScaffold(
      body: profileAsync.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error', style: AppTextStyles.bodyMedium)),
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
                        alignment: Alignment.topLeft, // Positioned in the corner
                        child: IconButton(
                          onPressed: () => _showUpdateProfileDialog(context, ref, profile),
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
                        value: profile.preferredLanguage,
                        onChanged: (String? newLanguage) {
                          if (newLanguage != null) {
                            _changeLanguage(context, ref, newLanguage);
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
                clipBehavior: Clip.none, // Allow the image to overflow the container
                children: [
                  Container(
                    height: 200, // Kept the original height of the blue container
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
                    top: 150, // Positioned the image to overlap the blue container
                    left: MediaQuery.of(context).size.width / 2 - 95, // Centered the image
                    child: CircleAvatar(
                      radius: 70, // Kept the image size consistent
                      backgroundImage: profile.profileImageUrl != null
                          ? NetworkImage(profile.profileImageUrl!)
                          : AssetImage('assets/images/default_avatar.png') as ImageProvider,
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
                            Icon(Icons.school, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text('University: ${profile.university}', style: AppTextStyles.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.apartment, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text('Department: ${profile.department}', style: AppTextStyles.bodyMedium),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.book, color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 8),
                            Text('Major: ${profile.major}', style: AppTextStyles.bodyMedium),
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
                          Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 8),
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
      )
      );
    }
  }
