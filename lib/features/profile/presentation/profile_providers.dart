import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/profile/domain/update_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/profile_repository.dart';
import '../domain/profile_model.dart';
import 'package:flutter/material.dart';


final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(apiClientProvider));
});

final profileProvider = FutureProvider<Profile>((ref) async {
  return ref.watch(profileRepositoryProvider).getProfile();
});

final updateProfileProvider = FutureProvider.family<void, UpdateProfile>((ref, profile) async {
  await ref.watch(profileRepositoryProvider).updateProfile(profile);
});

final changeLanguageProvider = FutureProvider.family<bool, String>((ref, language) async {
  return ref.watch(profileRepositoryProvider).changeLanguage(language);
});

final languageProvider = StateNotifierProvider<LanguageController, Locale>((ref) {
  return LanguageController();
});

class LanguageController extends StateNotifier<Locale> {
  LanguageController() : super(const Locale('en'));

  void setLanguage(String languageCode) {
    if (languageCode == 'ar') {
      state = const Locale('ar');
    } else {
      state = const Locale('en');
    }
  }
}