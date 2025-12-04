import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client.dart';
import '../domain/faqs_model.dart';


class FaqsRepository {
  final ApiClient _apiClient;

  FaqsRepository(this._apiClient);

Future<List<Faq>> getFaqs(int eventId) async {
    final response = await _apiClient.client.get(AppConfig.getFaqs(eventId));

    final list = response.data["data"]["items"];

    if (list is! List) {
      return [];
    }

    return list.map((e) => Faq.fromJson(e)).toList();
  }
}