import 'package:event_app/features/speakers/data/speaker_repository.dart';
import 'package:event_app/features/speakers/domain/speaker_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client_provider.dart';

final speakerRepositoryProvider = Provider<SpeakerRepository>((ref) {
  return SpeakerRepository(ref.watch(apiClientProvider));
});

final speakersListProvider = FutureProvider<List<SpeakerModel>>((ref) async {
  return ref.watch(speakerRepositoryProvider).getSpeakers('');
});
