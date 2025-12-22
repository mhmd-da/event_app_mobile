import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/partners/domain/partner_model.dart';

class PartnerRepository extends BaseApiRepository<PartnerModel> {
    PartnerRepository(super._apiClient)
            : super(fromJson: (json) => PartnerModel.fromJson(json));

  Future<List<PartnerModel>> getPartners() async =>
      await fetchList(AppConfig.getPartners);
}
