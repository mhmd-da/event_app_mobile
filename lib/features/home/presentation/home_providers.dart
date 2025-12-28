import 'package:event_app/core/network/api_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/home_repository.dart';
import '../domain/announcement_model.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref.watch(apiClientProvider));
});

final announcementsProvider = FutureProvider<List<AnnouncementModel>>((ref) async {
  return ref.watch(homeRepositoryProvider).getAnnouncements();
});
