import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/app_text_input.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/features/profile/domain/update_profile_model.dart';
import 'package:event_app/features/profile/domain/profile_model.dart';
import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProfilePage extends ConsumerWidget {
  final Profile profile;

  const UpdateProfilePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final firstNameController = TextEditingController(text: profile.firstName);
    final lastNameController = TextEditingController(text: profile.lastName);
    final bioController = TextEditingController(text: profile.bio);
    final universityController = TextEditingController(text: profile.university);
    final departmentController = TextEditingController(text: profile.department);
    final majorController = TextEditingController(text: profile.major);

    return AppScaffold(
      title: AppLocalizations.of(context)!.profile,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextInput(
                controller: firstNameController,
                label: AppLocalizations.of(context)!.firstName,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: AppSpacing.item),
              AppTextInput(
                controller: lastNameController,
                label: AppLocalizations.of(context)!.lastName,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: AppSpacing.item),
              AppTextInput(
                controller: bioController,
                label: AppLocalizations.of(context)!.bio,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                textInputAction: TextInputAction.newline,
              ),
              SizedBox(height: AppSpacing.item),
              AppTextInput(
                controller: universityController,
                label: AppLocalizations.of(context)!.university,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: AppSpacing.item),
              AppTextInput(
                controller: departmentController,
                label: AppLocalizations.of(context)!.department,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: AppSpacing.item),
              AppTextInput(
                controller: majorController,
                label: AppLocalizations.of(context)!.major,
                validator: (value) => value == null || value.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                  const SizedBox(width: 8),
                  AppElevatedButton(
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
                        // ...existing code...
                        ref.read(updateProfileProvider(updatedProfile));
                        Navigator.pop(context);
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.save),
                  ),
                ],
              ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}