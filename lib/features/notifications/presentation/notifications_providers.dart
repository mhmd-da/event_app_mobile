import 'package:event_app/core/network/api_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/notifications_repository.dart';
import '../domain/notification_model.dart';

final notificationsRepositoryProvider = Provider<NotificationsRepository>((ref) {
  return NotificationsRepository(ref.watch(apiClientProvider));
});


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

class NotificationsController extends StateNotifier<NotificationsState> {
  NotificationsController(this._repo)
      : super(NotificationsState(items: [], isLoading: false, hasMore: true, pageIndex: 1, pageSize: 20));

  final NotificationsRepository _repo;

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

final notificationsControllerProvider = StateNotifierProvider<NotificationsController, NotificationsState>((ref) {
  return NotificationsController(ref.read(notificationsRepositoryProvider));
});

final unreadCountProvider = FutureProvider<int>((ref) async {
  return ref.read(notificationsRepositoryProvider).getUnreadCount();
});
