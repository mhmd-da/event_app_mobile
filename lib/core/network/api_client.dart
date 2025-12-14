import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../storage/secure_storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/global_loading.dart';
import 'package:event_app/shared/providers/language_provider.dart';

class ApiClient {
  final Ref? _ref;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      validateStatus: (status) => true
    ),
  );

  ApiClient(Ref? ref) : _ref = ref {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final suppress = options.extra['suppressLoading'] == true;
          if (_ref != null && !suppress) {
            _ref!.read(globalLoadingProvider.notifier).begin();
          }
          // Load token from secure storage
          var storage = SecureStorageService();

          final token = await storage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          final eventId = await storage.getEventId();
          if (eventId != null) {
            options.headers["Event-Id"] = eventId;
          }

          // Add language header from current app locale
          if (_ref != null) {
            final locale = _ref!.read(appLocaleProvider);
            options.headers["Language-Code"] = locale.languageCode; // 'en' or 'ar'
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          final suppress = response.requestOptions.extra['suppressLoading'] == true;
          if (_ref != null && !suppress) {
            _ref!.read(globalLoadingProvider.notifier).end();
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          final suppress = error.requestOptions.extra['suppressLoading'] == true;
          if (_ref != null && !suppress) {
            _ref!.read(globalLoadingProvider.notifier).end();
          }
          // (Optional) Handle refresh token or auto-logout later
          return handler.next(error);
        },
      ),
    );

    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    ));

    print("ApiClient Log => calling ${client.options.baseUrl}");

  }

  Dio get client => _dio;
}
