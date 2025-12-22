// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speakers_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SpeakerSearchText)
const speakerSearchTextProvider = SpeakerSearchTextProvider._();

final class SpeakerSearchTextProvider
    extends $NotifierProvider<SpeakerSearchText, String> {
  const SpeakerSearchTextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'speakerSearchTextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$speakerSearchTextHash();

  @$internal
  @override
  SpeakerSearchText create() => SpeakerSearchText();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$speakerSearchTextHash() => r'd301611b1cdb2f93c6f6c753152ff0d189fd857f';

abstract class _$SpeakerSearchText extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
