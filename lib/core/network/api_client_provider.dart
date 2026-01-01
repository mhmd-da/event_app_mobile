import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/shared/providers/language_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client_provider.g.dart';

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  // Force rebuilding ApiClient (and thus repositories/data providers) when
  // the app language changes, so server-localized responses get re-fetched.
  ref.watch(appLocaleProvider);
  return ApiClient(ref);
}
