import 'package:event_app/features/mentors/data/mentor_repository.dart';
import 'package:event_app/features/mentors/domain/mentor_details_model.dart';
import 'package:event_app/features/mentors/domain/mentor_model.dart';
import 'package:event_app/core/widgets/listing_view_toggle.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/api_client_provider.dart';

part 'mentor_providers.g.dart';

@Riverpod(keepAlive: true)
MentorRepository mentorRepository(Ref ref) => MentorRepository(ref.watch(apiClientProvider));

@riverpod
Future<List<MentorModel>> mentorsList(Ref ref) async => ref.watch(mentorRepositoryProvider).getMentors('');

// Details provider (family)
@riverpod
Future<MentorDetailsModel> mentorDetails(
	Ref ref,
	int mentorId,
) async {
	return ref.watch(mentorRepositoryProvider).getMentorDetails(mentorId);
}

// View type toggle for Mentors page
@riverpod
class MentorsViewType extends _$MentorsViewType {
	@override
	ListingViewType build() => ListingViewType.imageCard;
	void set(ListingViewType value) => state = value;
}

// Search text state for Mentors page
@riverpod
class MentorSearchText extends _$MentorSearchText {
	@override
	String build() => "";
	void set(String value) => state = value;
}