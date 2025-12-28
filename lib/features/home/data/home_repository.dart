import 'package:event_app/core/base/base_api_repository.dart';
import '../domain/announcement_model.dart';

class HomeRepository extends BaseApiRepository<AnnouncementModel> {
  HomeRepository(super._apiClient)
      : super(fromJson: (json) => AnnouncementModel.fromJson(json));

  Future<List<AnnouncementModel>> getAnnouncements() async => await fetchList('/announcements');
}
