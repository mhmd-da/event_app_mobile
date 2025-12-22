import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:event_app/core/network/api_client_provider.dart';
import '../data/event_photos_repository.dart';
import '../domain/event_photos_page.dart';

part 'event_photos_providers.g.dart';

@Riverpod(keepAlive: true)
EventPhotosRepository eventPhotosRepository(Ref ref) {
  return EventPhotosRepository(ref.watch(apiClientProvider));
}

@riverpod
class EventPhotosPageIndex extends _$EventPhotosPageIndex {
  @override
  int build(int eventId) => 1;
  void set(int value) => state = value;
}

@Riverpod(keepAlive: false)
Future<EventPhotosPage> eventPhotos(Ref ref, {required int eventId, int pageSize = 24}) async {
  final pageIndex = ref.watch(eventPhotosPageIndexProvider(eventId));
  final items = await ref.read(eventPhotosRepositoryProvider).getEventPhotos(eventId, pageIndex: pageIndex, pageSize: pageSize);
  return EventPhotosPage(items: items, totalRows: items.length, pageIndex: pageIndex, pageSize: pageSize);
}
