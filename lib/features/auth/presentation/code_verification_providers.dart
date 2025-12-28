import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_verification_providers.g.dart';

@riverpod
class OtpResendCooldown extends _$OtpResendCooldown {
  @override
  int build() => 0;
  void set(int value) => state = value;
  void decrement() => state = state - 1;
}
