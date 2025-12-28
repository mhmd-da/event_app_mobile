import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final networkStatusProvider = StreamProvider<NetworkStatus>((ref) {
  return Connectivity().onConnectivityChanged.map((result) {
    // Debug print to trace connectivity changes
    print('[networkStatusProvider] Connectivity changed: $result');
    if (result is List) {
      if (result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi)) {
        return NetworkStatus.online;
      } else {
        return NetworkStatus.offline;
      }
    } else {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        return NetworkStatus.online;
      } else {
        return NetworkStatus.offline;
      }
    }
  });
});

enum NetworkStatus { online, offline }

// Utility for imperative checks
class NetworkStatusUtils {
  static NetworkStatus lastStatus = NetworkStatus.online;
}
