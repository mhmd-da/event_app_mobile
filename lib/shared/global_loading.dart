import 'package:flutter_riverpod/flutter_riverpod.dart';

final globalLoadingProvider = StateNotifierProvider<LoadingController, int>((ref) {
  return LoadingController();
});

class LoadingController extends StateNotifier<int> {
  LoadingController() : super(0);
  void begin() => state = state + 1;
  void end() => state = state > 0 ? state - 1 : 0;
  bool get isLoading => state > 0;
}
