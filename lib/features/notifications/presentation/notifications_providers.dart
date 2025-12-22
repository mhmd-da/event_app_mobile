import 'package:event_app/core/network/api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/notifications_repository.dart';
import '../domain/notification_model.dart';

part 'notifications_providers.g.dart';

@Riverpod(keepAlive: true)
NotificationsRepository notificationsRepository(Ref ref) {
  return NotificationsRepository(ref.watch(apiClientProvider));
}


class NotificationsState {
  final List<AppNotification> items;
  final bool isLoading;
  final bool hasMore;
  final int pageIndex;
  final int pageSize;

  NotificationsState({
    required this.items,
    required this.isLoading,
    required this.hasMore,
    required this.pageIndex,
    required this.pageSize,
  });

  NotificationsState copyWith({
    List<AppNotification>? items,
    bool? isLoading,
    bool? hasMore,
    int? pageIndex,
    int? pageSize,
  }) {
    return NotificationsState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class NotificationsController extends _$NotificationsController {
  @override
  NotificationsState build() {
    return NotificationsState(items: [], isLoading: false, hasMore: true, pageIndex: 1, pageSize: 20);
  }

  NotificationsRepository get _repo => ref.watch(notificationsRepositoryProvider);

  Future<void> loadInitial() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, pageIndex: 1);
    final items = await _repo.getNotificationsPage(1, state.pageSize);
    state = state.copyWith(
      items: items,
      isLoading: false,
      hasMore: items.length == state.pageSize,
      pageIndex: 1,
    );
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasMore) return;
    state = state.copyWith(isLoading: true);
    final nextPage = state.pageIndex + 1;
    final items = await _repo.getNotificationsPage(nextPage, state.pageSize);
    state = state.copyWith(
      items: [...state.items, ...items],
      isLoading: false,
      hasMore: items.length == state.pageSize,
      pageIndex: nextPage,
    );
  }
}

@riverpod
Future<int> unreadCount(Ref ref) async {
  return ref.read(notificationsRepositoryProvider).getUnreadCount();
}
