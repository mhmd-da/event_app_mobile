import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'network_status_provider.dart';

extension NetworkStatusX on WidgetRef {
  bool get isOnline => watch(networkStatusProvider).asData?.value == NetworkStatus.online;
  bool get isOffline => !isOnline;
}
