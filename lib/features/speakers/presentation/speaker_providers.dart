import 'package:event_app/features/speakers/data/speaker_repository.dart';
import 'package:event_app/features/speakers/domain/speaker_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/api_client_provider.dart';
part 'speaker_providers.g.dart';

// Repository as a generated provider (singleton)
@Riverpod(keepAlive: true)
SpeakerRepository speakerRepository(Ref ref) {
  return SpeakerRepository(ref.watch(apiClientProvider));
}

// Existing non-parameterized list (backward-compatible)
@riverpod
Future<List<SpeakerModel>> speakersList(Ref ref) async {
  return ref.watch(speakerRepositoryProvider).getSpeakers('');
}

// Parameterized (family) provider for search
@riverpod
Future<List<SpeakerModel>> speakersListBySearch(
  Ref ref,
  String? search,
) async {
  return ref.watch(speakerRepositoryProvider).getSpeakers(search);
}
