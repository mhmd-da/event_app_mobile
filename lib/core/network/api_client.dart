import 'package:dio/dio.dart';
import '../config/app_config.dart';
import '../storage/secure_storage_service.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      validateStatus: (status) => true
    ),
  );

  ApiClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
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

          return handler.next(options);
        },
        onError: (error, handler) {
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
