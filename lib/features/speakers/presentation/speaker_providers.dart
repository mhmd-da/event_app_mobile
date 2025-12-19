import 'package:event_app/features/speakers/data/speaker_repository.dart';
import 'package:event_app/features/speakers/domain/speaker_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/api_client_provider.dart';
part 'speaker_providers.g.dart';

// Repository as a generated provider (singleton)
@riverpod
SpeakerRepository speakerRepository(SpeakerRepositoryRef ref) {
  return SpeakerRepository(ref.watch(apiClientProvider));
}

// Existing non-parameterized list (backward-compatible)
@riverpod
Future<List<SpeakerModel>> speakersList(SpeakersListRef ref) async {
  return ref.watch(speakerRepositoryProvider).getSpeakers('');
}

// Parameterized (family) provider for search
@riverpod
Future<List<SpeakerModel>> speakersListBySearch(
  SpeakersListBySearchRef ref,
  String? search,
) async {
  return ref.watch(speakerRepositoryProvider).getSpeakers(search);
}
