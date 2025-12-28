// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RegistrationFormController)
const registrationFormControllerProvider =
    RegistrationFormControllerProvider._();

final class RegistrationFormControllerProvider
    extends
        $NotifierProvider<RegistrationFormController, RegistrationFormState> {
  const RegistrationFormControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registrationFormControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registrationFormControllerHash();

  @$internal
  @override
  RegistrationFormController create() => RegistrationFormController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegistrationFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegistrationFormState>(value),
    );
  }
}

String _$registrationFormControllerHash() =>
    r'fdc84da4202a8f0a77492ff3737343fb128f1332';

abstract class _$RegistrationFormController
    extends $Notifier<RegistrationFormState> {
  RegistrationFormState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RegistrationFormState, RegistrationFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RegistrationFormState, RegistrationFormState>,
              RegistrationFormState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
