import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/partners/data/partner_repository.dart';
import 'package:event_app/features/partners/domain/partner_model.dart';
import 'package:event_app/core/widgets/listing_view_toggle.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'partner_providers.g.dart';

@Riverpod(keepAlive: true)
PartnerRepository partnerRepository(Ref ref) => PartnerRepository(ref.watch(apiClientProvider));

@riverpod
Future<List<PartnerModel>> partnersList(Ref ref) async => ref.watch(partnerRepositoryProvider).getPartners();

// Search text for Partners page
@riverpod
class PartnerSearchText extends _$PartnerSearchText {
	@override
	String build() => "";
	void set(String value) => state = value;
}

// View type toggle for Partners page
@riverpod
class PartnersViewType extends _$PartnersViewType {
	@override
	ListingViewType build() => ListingViewType.imageCard;
	void set(ListingViewType value) => state = value;
}
