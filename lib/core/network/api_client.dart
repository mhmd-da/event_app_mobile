import 'package:dio/dio.dart';
import '../config/app_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/global_loading.dart';
import 'package:event_app/shared/providers/language_provider.dart';

class ApiClient {
  final Ref? _ref;
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseApiUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      validateStatus: (status) => true,
    ),
  );

  ApiClient(Ref? ref) : _ref = ref {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final suppress = options.extra['suppressLoading'] == true;
          if (_ref != null && !suppress) {
            _ref.read(globalLoadingProvider.notifier).begin();
          }

          // Add default event ID header (no auth required)
          options.headers["Event-Id"] = 1;

          // Add language header from current app locale
          if (_ref != null) {
            final locale = _ref.read(appLocaleProvider);
            options.headers["Language-Code"] =
                locale.languageCode; // 'en' or 'ar'
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          final suppress =
              response.requestOptions.extra['suppressLoading'] == true;
          if (_ref != null && !suppress) {
            _ref.read(globalLoadingProvider.notifier).end();
          }
          return handler.next(response);
        },
        onError: (error, handler) {
          final suppress =
              error.requestOptions.extra['suppressLoading'] == true;
          if (_ref != null && !suppress) {
            _ref.read(globalLoadingProvider.notifier).end();
          }
          // (Optional) Handle refresh token or auto-logout later
          return handler.next(error);
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
      ),
    );

    // ignore: avoid_print
    //print("ApiClient Log => calling ${client.options.baseUrl}");
  }

  Dio get client => _dio;
}
