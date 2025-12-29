import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import '../domain/notification_model.dart';

class NotificationsPageResult {
  final List<AppNotification> items;
  final int unreadCount;

  const NotificationsPageResult({
    required this.items,
    required this.unreadCount,
  });
}

class NotificationsRepository extends BaseApiRepository<AppNotification> {
  final ApiClient _apiClient;

  NotificationsRepository(this._apiClient)
    : super(_apiClient, fromJson: (json) => AppNotification.fromJson(json));

  Future<NotificationsPageResult> getNotificationsPage(
    int pageIndex,
    int pageSize,
  ) async {
    final endpoint = AppConfig.getNotificationsPaged(pageIndex, pageSize);
    final response = await _apiClient.client.get(endpoint);

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    final data = response.data["data"];
    final list = (data is Map<String, dynamic>) ? data["items"] : null;
    final itemsJson = (list is List) ? list : const [];

    final unreadRaw = (data is Map<String, dynamic>)
        ? (data["unreadCount"] ?? data["UnreadCount"] ?? data["unread_count"])
        : null;
    final unreadCount = unreadRaw is int
        ? unreadRaw
        : int.tryParse(unreadRaw?.toString() ?? '') ?? 0;

    final items = itemsJson.map((e) => AppNotification.fromJson(e)).toList();
    return NotificationsPageResult(items: items, unreadCount: unreadCount);
  }

  Future<int> getUnreadCountFast() async {
    // Smallest possible page; backend returns unreadCount in the data object.
    final page = await getNotificationsPage(1, 1);
    return page.unreadCount;
  }

  Future<void> markRead(List<int> ids) async {
    if (ids.isEmpty) return;
    await putData<dynamic>(AppConfig.markNotificationRead, {"ids": ids});
  }
}
