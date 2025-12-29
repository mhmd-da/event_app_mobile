import 'package:event_app/features/speakers/data/speaker_repository.dart';
import 'package:event_app/features/speakers/domain/speaker_model.dart';
import 'package:event_app/core/widgets/listing_view_toggle.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/api_client_provider.dart';

part 'speaker_providers.g.dart';

// Repository as a generated provider (singleton)
@Riverpod(keepAlive: true)
SpeakerRepository speakerRepository(Ref ref) {
  return SpeakerRepository(ref.watch(apiClientProvider));
}

// Existing non-parameterized list (backward-compatible)
@Riverpod(keepAlive: true)
Future<List<SpeakerModel>> speakersList(Ref ref) async {
  return ref.watch(speakerRepositoryProvider).getSpeakers('');
}

// @riverpod
// Future<List<SpeakerModel>> speakersListBySearch(
//   Ref ref,
//   String? search,
// ) async {
//   return ref.watch(speakerRepositoryProvider).getSpeakers(search);
// }

// Details provider (family)
// @riverpod
// Future<SpeakerDetailsModel> speakerDetails(
//   Ref ref,
//   int speakerId,
// ) async {
//   return ref.watch(speakerRepositoryProvider).getSpeakerDetails(speakerId);
// }

// UI view type for Speakers list (grid vs row)
@riverpod
class SpeakersViewType extends _$SpeakersViewType {
  @override
  ListingViewType build() => ListingViewType.imageCard;
  void set(ListingViewType value) => state = value;
}

// Holds the current search text typed in the CustomSearchBar
@riverpod
class SpeakerSearchText extends _$SpeakerSearchText {
  @override
  String build() => "";
  void set(String value) => state = value;
}
