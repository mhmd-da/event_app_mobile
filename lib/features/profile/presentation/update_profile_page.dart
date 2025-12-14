import 'package:event_app/features/profile/domain/update_profile_model.dart';
import 'package:event_app/features/profile/domain/profile_model.dart';
import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProfilePage extends ConsumerWidget {
  final Profile profile;

  const UpdateProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final firstNameController = TextEditingController(text: profile.firstName);
    final lastNameController = TextEditingController(text: profile.lastName);
    final bioController = TextEditingController(text: profile.bio);
    final universityController = TextEditingController(text: profile.university);
    final departmentController = TextEditingController(text: profile.department);
    final majorController = TextEditingController(text: profile.major);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
                maxLines: 3,
              ),
              TextFormField(
                controller: universityController,
                decoration: const InputDecoration(labelText: 'University'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: departmentController,
                decoration: const InputDecoration(labelText: 'Department'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: majorController,
                decoration: const InputDecoration(labelText: 'Major'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
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
                    child: const Text('Save'),
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