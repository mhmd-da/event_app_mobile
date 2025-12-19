import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/sponsors/data/sponsor_repository.dart';
import 'package:event_app/features/sponsors/domain/sponsor_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sponsorRepositoryProvider = Provider<SponsorRepository>((ref) {
  return SponsorRepository(ref.watch(apiClientProvider));
});

final sponsorsListProvider = FutureProvider<List<SponsorModel>>((ref) async {
  return ref.watch(sponsorRepositoryProvider).getSponsors();
});
