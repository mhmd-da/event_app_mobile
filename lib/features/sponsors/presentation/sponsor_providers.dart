import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/sponsors/data/sponsor_repository.dart';
import 'package:event_app/features/sponsors/domain/sponsor_model.dart';
import 'package:event_app/core/widgets/listing_view_toggle.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sponsor_providers.g.dart';

@Riverpod(keepAlive: true)
SponsorRepository sponsorRepository(Ref ref) => SponsorRepository(ref.watch(apiClientProvider));

@Riverpod(keepAlive: true)
Future<List<SponsorModel>> sponsorsList(Ref ref) async => ref.watch(sponsorRepositoryProvider).getSponsors();
 
// Search text for Sponsors page
@riverpod
class SponsorSearchText extends _$SponsorSearchText {
  @override
  String build() => "";
  void set(String value) => state = value;
}

// View type toggle for Sponsors page
@riverpod
class SponsorsViewType extends _$SponsorsViewType {
	@override
	ListingViewType build() => ListingViewType.imageCard;
	void set(ListingViewType value) => state = value;
}
