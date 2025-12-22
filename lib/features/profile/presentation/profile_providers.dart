import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/profile/domain/update_profile_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/profile_repository.dart';
import '../domain/profile_model.dart';

part 'profile_providers.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) => ProfileRepository(ref.watch(apiClientProvider));

@riverpod
Future<Profile> profile(Ref ref) async => ref.watch(profileRepositoryProvider).getProfile();

@riverpod
Future<void> updateProfile(Ref ref, UpdateProfile profile) async {
  await ref.watch(profileRepositoryProvider).updateProfile(profile);
}
