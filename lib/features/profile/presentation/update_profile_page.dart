import 'dart:io';

import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/widgets/app_text_input.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/profile/domain/profile_model.dart';
import 'package:event_app/features/profile/domain/update_profile_model.dart';
import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProfilePage extends ConsumerStatefulWidget {
  final Profile profile;

  const UpdateProfilePage({super.key, required this.profile});

  @override
  ConsumerState<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends ConsumerState<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _bioController;
  late final TextEditingController _universityController;
  late final TextEditingController _departmentController;
  late final TextEditingController _majorController;

  File? _localImageFile;
  bool _isUploadingImage = false;
  bool _isSaving = false;
  bool _didChangeAnything = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.profile.firstName,
    );
    _lastNameController = TextEditingController(text: widget.profile.lastName);
    _bioController = TextEditingController(text: widget.profile.bio);
    _universityController = TextEditingController(
      text: widget.profile.university,
    );
    _departmentController = TextEditingController(
      text: widget.profile.department,
    );
    _majorController = TextEditingController(text: widget.profile.major);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _universityController.dispose();
    _departmentController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  ImageProvider _avatarProvider() {
    if (_localImageFile != null) return FileImage(_localImageFile!);
    final url = widget.profile.profileImageUrl;
    if (url != null && url.trim().isNotEmpty) return NetworkImage(url);
    return const AssetImage('assets/images/default_avatar.png');
  }

  Future<void> _pickAndUploadImage() async {
    if (_isUploadingImage) return;
    final l10n = AppLocalizations.of(context)!;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: false,
    );

    if (!mounted) return;
    if (result == null || result.files.isEmpty) return;

    final path = result.files.single.path;
    if (path == null || path.trim().isEmpty) {
      AppNotifier.error(context, l10n.actionFailed);
      return;
    }

    final file = File(path);

    setState(() {
      _isUploadingImage = true;
      _localImageFile = file;
    });

    try {
      await ref.read(profileRepositoryProvider).uploadProfileImage(file);
      if (!mounted) return;
      _didChangeAnything = true;
      ref.invalidate(profileProvider);
      AppNotifier.success(context, l10n.success);
    } catch (e) {
      if (!mounted) return;
      AppNotifier.error(context, e.toString());
    } finally {
      if (!mounted) return;
      setState(() {
        _isUploadingImage = false;
      });
    }
  }

  Future<void> _save() async {
    if (_isSaving) return;
    final l10n = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final updatedProfile = UpdateProfile(
        id: widget.profile.id,
        title: widget.profile.title,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        bio: _bioController.text,
        university: _universityController.text,
        department: _departmentController.text,
        major: _majorController.text,
      );

      await ref.read(updateProfileProvider(updatedProfile).future);
      if (!mounted) return;
      _didChangeAnything = true;
      AppNotifier.success(context, l10n.success);
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      AppNotifier.error(context, e.toString());
    } finally {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      title: l10n.profile,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundImage: _avatarProvider(),
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: _isUploadingImage
                            ? null
                            : _pickAndUploadImage,
                        icon: _isUploadingImage
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.photo_camera_outlined),
                        label: Text(
                          _isUploadingImage ? l10n.loading : l10n.changePhoto,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppTextInput(
                  controller: _firstNameController,
                  label: l10n.firstName,
                  validator: (value) => value == null || value.isEmpty
                      ? l10n.requiredField
                      : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.item),
                AppTextInput(
                  controller: _lastNameController,
                  label: l10n.lastName,
                  validator: (value) => value == null || value.isEmpty
                      ? l10n.requiredField
                      : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.item),
                AppTextInput(
                  controller: _bioController,
                  label: l10n.bio,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                ),
                const SizedBox(height: AppSpacing.item),
                AppTextInput(
                  controller: _universityController,
                  label: l10n.university,
                  validator: (value) => value == null || value.isEmpty
                      ? l10n.requiredField
                      : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.item),
                AppTextInput(
                  controller: _departmentController,
                  label: l10n.department,
                  validator: (value) => value == null || value.isEmpty
                      ? l10n.requiredField
                      : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.item),
                AppTextInput(
                  controller: _majorController,
                  label: l10n.major,
                  validator: (value) => value == null || value.isEmpty
                      ? l10n.requiredField
                      : null,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(context, _didChangeAnything),
                      child: Text(l10n.cancel),
                    ),
                    const SizedBox(width: 8),
                    AppElevatedButton(
                      onPressed: _isSaving ? null : _save,
                      child: _isSaving
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.save),
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
