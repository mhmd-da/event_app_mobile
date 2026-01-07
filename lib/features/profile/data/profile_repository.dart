import 'dart:io';

import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/profile/domain/update_profile_model.dart';
import '../domain/profile_model.dart';

class ProfileRepository extends BaseApiRepository<Profile> {
  ProfileRepository(super._apiClient)
    : super(fromJson: (json) => Profile.fromJson(json));

  Future<Profile> getProfile() async => await fetchSingle(AppConfig.getProfile);

  Future<bool> updateProfile(UpdateProfile profile) async =>
      await putData<bool>(AppConfig.updateProfile, {
        "id": profile.id,
        "title": profile.title,
        "firstName": profile.firstName,
        "lastName": profile.lastName,
        "bio": profile.bio,
        "university": profile.university,
        "department": profile.department,
        "major": profile.major,
      });

  Future<bool> uploadProfileImage(File file) async =>
      putDataFile<bool>(AppConfig.uploadProfileImage, file);

  Future<bool> updatePreferredLanguage(String languageCode) async {
    final normalized = languageCode.trim().toLowerCase();
    if (normalized != 'en' && normalized != 'ar') {
      throw ArgumentError.value(
        languageCode,
        'languageCode',
        'Only "en" or "ar" is supported',
      );
    }
    return await putData<bool>(AppConfig.updateProfileLanguage, {
      "PreferredLanguage": normalized,
    });
  }
}
