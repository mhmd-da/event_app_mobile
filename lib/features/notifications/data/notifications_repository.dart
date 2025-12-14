import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import '../domain/notification_model.dart';

class NotificationsRepository extends BaseApiRepository<AppNotification>{
  
    NotificationsRepository(ApiClient client)
      : super(client, (json) => AppNotification.fromJson(json));

  Future<List<AppNotification>> getNotifications() async => await fetchList(AppConfig.getNotifications); 

  Future<int> getUnreadCount() async {
    try {
      final list = await getNotifications();
      return list.where((n) => !n.read).length;
    } catch (_) {
      return 0;
    }
  }

  Future<List<AppNotification>> getNotificationsPage(int pageIndex, int pageSize) async {
    return await fetchList(AppConfig.getNotificationsPaged(pageIndex, pageSize));
  }
}