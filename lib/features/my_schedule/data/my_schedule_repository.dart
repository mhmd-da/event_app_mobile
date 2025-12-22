import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';

class MyScheduleRepository extends BaseApiRepository<SessionModel>{

    MyScheduleRepository(super._apiClient)
      : super(fromJson: (json) => SessionModel.fromJson(json));

  Future<List<SessionModel>> getMySchedule() async => await fetchList(AppConfig.getMySchedule); 

}