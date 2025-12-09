import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/my_schedule/domain/my_schedule_model.dart';

class MyScheduleRepository extends BaseApiRepository<MyScheduleModel>{

    MyScheduleRepository(ApiClient client)
      : super(client, (json) => MyScheduleModel.fromJson(json));

  Future<List<MyScheduleModel>> getMySchedule() async => await fetchList(AppConfig.getMySchedule); 

}