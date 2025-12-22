import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/base/base_model.dart';
import 'package:event_app/core/config/app_config.dart';
import '../domain/event_photo_model.dart';

class EventPhotosRepository extends BaseApiRepository<BaseModel> {
  EventPhotosRepository(super._apiClient) : super();

  Future<List<EventPhotoModel>> getEventPhotos(int eventId, {int pageIndex = 1, int pageSize = 24}) async {
    return await fetchListGeneric<EventPhotoModel>(
      AppConfig.getEventPhotos(eventId, pageIndex: pageIndex, pageSize: pageSize),
      (json) => EventPhotoModel.fromJson(json),
    );
  }
}