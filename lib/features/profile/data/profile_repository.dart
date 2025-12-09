import 'dart:io';

import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/profile/domain/update_profile_model.dart';
import '../domain/profile_model.dart';


class ProfileRepository extends BaseApiRepository<Profile>{

    ProfileRepository(ApiClient client)
      : super(client, (json) => Profile.fromJson(json));

  Future<Profile> getProfile() async => await fetchSingle(AppConfig.getProfile);

  Future<bool> updateProfile(UpdateProfile profile) async => await putData<bool>(AppConfig.updateProfile, 
                                                                            {
                                                                              "id": profile.id,
                                                                              "title": profile.title,
                                                                              "firstName": profile.firstName,
                                                                              "lastName": profile.lastName,
                                                                              "bio": profile.bio,
                                                                              "university": profile.university,
                                                                              "department": profile.department,
                                                                              "major": profile.major,
                                                                            });

  Future<bool> changeLanguage(String language) async => await putData<bool>(AppConfig.updateProfileLanguage, 
                                                                            {
                                                                              "preferredLanguage": language
                                                                            });

  Future<bool> registerDevice(String deviceToken) async => await putData<bool>(AppConfig.registerDevice, 
                                                                            {
                                                                              "token": deviceToken,
                                                                              "platform": Platform.operatingSystem
                                                                            });
}