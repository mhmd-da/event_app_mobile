import 'package:dio/dio.dart';
import 'package:event_app/core/base/base_model.dart';
import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/core/network/network_status_provider.dart';
import 'package:event_app/core/storage/local_cache_service.dart';
import 'package:sqlite3/sqlite3.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class BaseApiRepository<T extends BaseModel> {
  final ApiClient _apiClient;
  final T Function(Map<String, dynamic>)? fromJson;
  static Database? _db;
  static LocalCacheService? cache;

  BaseApiRepository(this._apiClient, {this.fromJson});

  static Future<void> ensureDbInitialized() async {
    if (_db != null && cache != null) return;
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/event_app_cache.db');
    _db = sqlite3.open(file.path);
    cache = LocalCacheService(_db!);
  }

  Future<List<T>> fetchList(String endpoint, {String? cacheKey}) async {
    return fetchListGeneric<T>(endpoint, fromJson!, cacheKey: cacheKey);
  }

  Future<List<TH>> fetchListGeneric<TH>(
    String endpoint,
    TH Function(Map<String, dynamic>) fromJson, {
    String? cacheKey,
  }) async {
    await ensureDbInitialized();
    final isOnline = NetworkStatusUtils.lastStatus == NetworkStatus.online;
    final table = cacheKey ?? endpoint.replaceAll('/', '_');
    if (isOnline) {
      try {
        final response = await _apiClient.client.get(endpoint);
        if (response.statusCode != 200) {
          throw (response.data["message"] ?? 'Something went wrong');
        }
        final list = response.data["data"]["items"];
        if (list is! List) return [];
        // Cache each item by id
        for (final item in list) {
          final id =
              item['id']?.toString() ??
              DateTime.now().microsecondsSinceEpoch.toString();
          cache!.put(table, id, item);
        }
        return list.map((u) => fromJson(u)).toList();
      } catch (e) {
        // Fallback to cache if API fails
        final cached = cache!.getAll(table);
        if (cached.isNotEmpty) {
          return cached.map((u) => fromJson(u)).toList();
        }
        throw Exception('No internet connection and no cached data available.');
      }
    } else {
      final cached = cache!.getAll(table);
      if (cached.isNotEmpty) {
        return cached.map((u) => fromJson(u)).toList();
      }
      throw Exception('No internet connection and no cached data available.');
    }
  }

  Future<T> fetchSingle(String endpoint, {String? cacheKey, String? id}) async {
    return fetchSingleGeneric<T>(
      endpoint,
      fromJson!,
      cacheKey: cacheKey,
      id: id,
    );
  }

  Future<TH> fetchSingleGeneric<TH>(
    String endpoint,
    TH Function(Map<String, dynamic>) fromJson, {
    String? cacheKey,
    String? id,
  }) async {
    await ensureDbInitialized();
    final isOnline = NetworkStatusUtils.lastStatus == NetworkStatus.online;
    final table = cacheKey ?? endpoint.replaceAll('/', '_');
    final cacheId = id ?? '0';
    if (isOnline) {
      try {
        final response = await _apiClient.client.get(endpoint);
        if (response.statusCode != 200) {
          throw (response.data["message"] ?? 'Something went wrong');
        }
        final data = response.data["data"];
        cache!.put(table, cacheId, data);
        return fromJson(data);
      } catch (e) {
        final cached = cache!.get(table, cacheId);
        if (cached != null) {
          return fromJson(cached);
        }
        throw Exception('Something went wrong. Please try again.');
      }
    } else {
      final cached = cache!.get(table, cacheId);
      if (cached != null) {
        return fromJson(cached);
      }
      throw Exception('No internet connection and no cached data available.');
    }
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

  Future<TH> putDataFile<TH>(String endpoint, File file) async {
    final fileName = file.path.split(Platform.pathSeparator).last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final response = await _apiClient.client.put(
      endpoint,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (response.statusCode != 200) {
      throw (response.data?["message"] ?? 'Something went wrong');
    }

    return response.data["data"];
  }

  Future<TH> postDataFile<TH>(String endpoint, File file) async {
    final fileName = file.path.split(Platform.pathSeparator).last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final response = await _apiClient.client.post(
      endpoint,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    if (response.statusCode != 200) {
      throw (response.data?["message"] ?? 'Something went wrong');
    }

    return response.data["data"];
  }

  Future<TH> deleteData<TH>(String endpoint, Map<String, dynamic>? data) async {
    final response = await _apiClient.client.delete(endpoint, data: data);

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    return response.data["data"];
  }

  Future<TH> deleteDataGeneric<TH>(
    String endpoint,
    Map<String, dynamic>? data,
    TH Function(Map<String, dynamic>) fromJson,
  ) async {
    final response = await _apiClient.client.delete(endpoint, data: data);

    if (response.statusCode != 200) {
      throw (response.data["message"] ?? 'Something went wrong');
    }

    return fromJson(response.data["data"]);
  }
}
