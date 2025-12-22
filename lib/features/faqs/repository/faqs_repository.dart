import 'package:event_app/core/base/base_api_repository.dart';
import 'package:event_app/core/config/app_config.dart';
import '../domain/faqs_model.dart';

class FaqsRepository  extends BaseApiRepository<Faq>{

    FaqsRepository(super._apiClient)
      : super(fromJson: (json) => Faq.fromJson(json));

  Future<List<Faq>> getFaqs() async => await fetchList(AppConfig.getFaqs); 

}