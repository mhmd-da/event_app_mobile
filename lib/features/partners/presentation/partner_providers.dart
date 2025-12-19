import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/partners/data/partner_repository.dart';
import 'package:event_app/features/partners/domain/partner_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final partnerRepositoryProvider = Provider<PartnerRepository>((ref) {
  return PartnerRepository(ref.watch(apiClientProvider));
});

final partnersListProvider = FutureProvider<List<PartnerModel>>((ref) async {
  return ref.watch(partnerRepositoryProvider).getPartners();
});
