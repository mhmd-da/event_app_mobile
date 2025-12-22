import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/sponsors/domain/sponsor_model.dart';

class SponsorRepository extends BaseApiRepository<SponsorModel> {
    SponsorRepository(super._apiClient)
            : super(fromJson: (json) => SponsorModel.fromJson(json));

  Future<List<SponsorModel>> getSponsors() async =>
      await fetchList(AppConfig.getSponsors);
}
