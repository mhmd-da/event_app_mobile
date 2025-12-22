import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/partners/data/partner_repository.dart';
import 'package:event_app/features/partners/domain/partner_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'partner_providers.g.dart';

@Riverpod(keepAlive: true)
PartnerRepository partnerRepository(Ref ref) => PartnerRepository(ref.watch(apiClientProvider));

@riverpod
Future<List<PartnerModel>> partnersList(Ref ref) async => ref.watch(partnerRepositoryProvider).getPartners();
