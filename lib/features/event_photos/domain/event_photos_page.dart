import 'event_photo_model.dart';

class EventPhotosPage {
  final List<EventPhotoModel> items;
  final int totalRows;
  final int pageIndex;
  final int pageSize;

  EventPhotosPage({
    required this.items,
    required this.totalRows,
    required this.pageIndex,
    required this.pageSize,
  });
}