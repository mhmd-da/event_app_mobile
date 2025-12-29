import 'package:event_app/core/network/api_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/notifications_repository.dart';
import '../domain/notification_model.dart';

part 'notifications_providers.g.dart';

@Riverpod(keepAlive: true)
NotificationsRepository notificationsRepository(Ref ref) {
  return NotificationsRepository(ref.watch(apiClientProvider));
}

/// Badge count shown in the app bar.
///
/// Null means "not initialized yet" and the UI can fall back to
/// [unreadCountProvider] (server value).
@riverpod
class UnreadBadgeCount extends _$UnreadBadgeCount {
  @override
  int? build() => null;

  void setFromServer(int unreadCount) {
    state = unreadCount;
  }

  void increment([int by = 1]) {
    state = (state ?? 0) + by;
  }

  void decrement(int by) {
    final current = state;
    if (current == null) return;
    final next = current - by;
    state = next < 0 ? 0 : next;
  }
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
  final Set<int> _markReadSentIds = <int>{};

  @override
  NotificationsState build() {
    return NotificationsState(
      items: [],
      isLoading: false,
      hasMore: true,
      pageIndex: 1,
      pageSize: 20,
    );
  }

  NotificationsRepository get _repo =>
      ref.watch(notificationsRepositoryProvider);

  void _setBadgeFromServer(int unreadCount) {
    ref.read(unreadBadgeCountProvider.notifier).setFromServer(unreadCount);
  }

  void _decrementBadge(int by) {
    ref.read(unreadBadgeCountProvider.notifier).decrement(by);
  }

  void _markPageUnreadAsRead(List<AppNotification> pageItems) {
    final ids = pageItems
        .where((n) => !n.read)
        .map((n) => n.id)
        .where((id) => !_markReadSentIds.contains(id))
        .toList();

    if (ids.isEmpty) return;
    _markReadSentIds.addAll(ids);

    // Optimistically update badge + local models.
    _decrementBadge(ids.length);
    state = state.copyWith(
      items: state.items
          .map((n) => ids.contains(n.id) ? n.copyWith(read: true) : n)
          .toList(),
    );

    // Fire and forget; next fetch will reconcile.
    // ignore: discarded_futures
    _repo.markRead(ids);
  }

  Future<void> loadInitial() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, pageIndex: 1);
    final page = await _repo.getNotificationsPage(1, state.pageSize);
    final items = page.items;
    state = state.copyWith(
      items: items,
      isLoading: false,
      hasMore: items.length == state.pageSize,
      pageIndex: 1,
    );

    _setBadgeFromServer(page.unreadCount);
    _markPageUnreadAsRead(items);
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasMore) return;
    state = state.copyWith(isLoading: true);
    final nextPage = state.pageIndex + 1;
    final page = await _repo.getNotificationsPage(nextPage, state.pageSize);
    final items = page.items;
    state = state.copyWith(
      items: [...state.items, ...items],
      isLoading: false,
      hasMore: items.length == state.pageSize,
      pageIndex: nextPage,
    );

    _setBadgeFromServer(page.unreadCount);
    _markPageUnreadAsRead(items);
  }
}

/// Server source-of-truth unread count (used as fallback before
/// [unreadBadgeCountProvider] is initialized).
///
/// NOTE: This is referenced by the generated `notifications_providers.g.dart`.
@riverpod
Future<int> unreadCount(Ref ref) async {
  return ref.read(notificationsRepositoryProvider).getUnreadCountFast();
}
