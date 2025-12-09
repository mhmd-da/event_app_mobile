import 'package:event_app/core/base/base_model.dart';
import 'package:event_app/core/network/api_client.dart';

class BaseApiRepository<T extends BaseModel> {
  final ApiClient _apiClient;
  final T Function(Map<String, dynamic>) fromJson;

  BaseApiRepository(this._apiClient, this.fromJson);

  Future<List<T>> fetchList(String endpoint) async =>
      fetchListGeneric<T>(endpoint, fromJson);

  Future<List<TH>> fetchListGeneric<TH>(
    String endpoint,
    TH Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await _apiClient.client.get(endpoint);

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    final list = response.data["data"]["items"];

    if (list is! List) return [];

    return list.map((u) => fromJson(u)).toList();
  }

  Future<T> fetchSingle(String endpoint) async =>
      fetchSingleGeneric<T>(endpoint, fromJson);

  Future<TH> fetchSingleGeneric<TH>(
    String endpoint,
    TH Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await _apiClient.client.get(endpoint);

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    return fromJson(response.data["data"]);
  }

  Future<TH> postData<TH>(String endpoint, Map<String, dynamic>? data) async {
    final response = await _apiClient.client.post(endpoint, data: data);

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    return response.data["data"];
  }

  Future<TH> postDataGeneric<TH>(
    String endpoint,
    Map<String, dynamic>? data,
    TH Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await _apiClient.client.post(endpoint, data: data);

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    return fromJson(response.data["data"]);
  }

  Future<TH> putData<TH>(String endpoint, Map<String, dynamic>? data) async {
    final response = await _apiClient.client.put(endpoint, data: data);

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    return response.data["data"];
  }

  Future<TH> putDataGeneric<TH>(
    String endpoint,
    Map<String, dynamic>? data,
    TH Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await _apiClient.client.put(endpoint, data: data);

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    return fromJson(response.data["data"]);
  }
}
