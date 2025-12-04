import 'dart:convert';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/profile/domain/update_profile_model.dart';
import '../domain/profile_model.dart';

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository(this._apiClient);

  Future<Profile> getProfile() async {
    final response = await _apiClient.client.get(AppConfig.getProfile);

    if (response.statusCode == 200) {
      return Profile.fromJson(response.data["data"]);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> updateProfile(UpdateProfile profile) async {
    final response = await _apiClient.client.post(
      AppConfig.updateProfile,
      //headers: {'Content-Type': 'application/json'},
      data: json.encode({
        'id': profile.id,
        'title': profile.title,
        'firstName': profile.firstName,
        'lastName': profile.lastName,
        'bio': profile.bio,
        'university': profile.university,
        'department': profile.department,
        'major': profile.major,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }

  Future<bool> changeLanguage(String language) async {
    final response = await _apiClient.client.post(
      AppConfig.updateProfileLanguage,
      //headers: {'Content-Type': 'application/json'},
      data: json.encode({'preferredLanguage': language}),
    );

    return response.statusCode == 200;
  }
}