import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final networkStatusProvider = StreamProvider<NetworkStatus>((ref) async* {
  final connectivity = Connectivity();

  NetworkStatus computeStatus(Object? raw) {
    final List<ConnectivityResult> results;
    if (raw is List) {
      results = raw.cast<ConnectivityResult>();
    } else if (raw is ConnectivityResult) {
      results = <ConnectivityResult>[raw];
    } else {
      results = const <ConnectivityResult>[];
    }

    final isOnline =
        results.contains(ConnectivityResult.mobile) ||
        results.contains(ConnectivityResult.wifi) ||
        results.contains(ConnectivityResult.ethernet);

    final status = isOnline ? NetworkStatus.online : NetworkStatus.offline;
    NetworkStatusUtils.lastStatus = status;
    return status;
  }

  final initial = await connectivity.checkConnectivity();
  yield computeStatus(initial);

  await for (final update in connectivity.onConnectivityChanged) {
    yield computeStatus(update);
  }
});

enum NetworkStatus { online, offline }

// Utility for imperative checks
class NetworkStatusUtils {
  static NetworkStatus lastStatus = NetworkStatus.online;
}
