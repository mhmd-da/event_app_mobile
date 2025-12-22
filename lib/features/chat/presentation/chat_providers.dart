import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/features/chat/data/chat_realtime_service.dart';
import 'package:event_app/features/chat/data/chat_sqlite_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_providers.g.dart';

@Riverpod(keepAlive: true)
ChatRealtimeService chatRealtimeService(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  Future<String> tokenGetter() async {
    return (await storage.getToken()) ?? '';
  }
  return ChatRealtimeService(hubUrl: AppConfig.baseHubUrl, getAccessToken: tokenGetter);
}

@Riverpod(keepAlive: true)
ChatSqliteRepository chatSqliteRepository(Ref ref) {
  return ChatSqliteRepository();
}
