import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'global_loading.g.dart';

@Riverpod(keepAlive: true)
class GlobalLoading extends _$GlobalLoading {
  @override
  int build() => 0;
  void begin() => state = state + 1;
  void end() => state = state > 0 ? state - 1 : 0;
  bool get isLoading => state > 0;
}
