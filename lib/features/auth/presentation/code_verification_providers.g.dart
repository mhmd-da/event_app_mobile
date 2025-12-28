// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_verification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OtpResendCooldown)
const otpResendCooldownProvider = OtpResendCooldownProvider._();

final class OtpResendCooldownProvider
    extends $NotifierProvider<OtpResendCooldown, int> {
  const OtpResendCooldownProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'otpResendCooldownProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$otpResendCooldownHash();

  @$internal
  @override
  OtpResendCooldown create() => OtpResendCooldown();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$otpResendCooldownHash() => r'dac5f0002cecd70109727528828ebf7003722b0a';

abstract class _$OtpResendCooldown extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
