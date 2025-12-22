import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/sponsors/data/sponsor_repository.dart';
import 'package:event_app/features/sponsors/domain/sponsor_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sponsor_providers.g.dart';

@Riverpod(keepAlive: true)
SponsorRepository sponsorRepository(Ref ref) => SponsorRepository(ref.watch(apiClientProvider));

@riverpod
Future<List<SponsorModel>> sponsorsList(Ref ref) async => ref.watch(sponsorRepositoryProvider).getSponsors();
