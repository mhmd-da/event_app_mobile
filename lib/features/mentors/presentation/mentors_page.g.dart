// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentors_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MentorSearchText)
const mentorSearchTextProvider = MentorSearchTextProvider._();

final class MentorSearchTextProvider
    extends $NotifierProvider<MentorSearchText, String> {
  const MentorSearchTextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorSearchTextProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorSearchTextHash();

  @$internal
  @override
  MentorSearchText create() => MentorSearchText();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$mentorSearchTextHash() => r'13dfd23be158da8a171f793a7057a2df83d8282f';

abstract class _$MentorSearchText extends $Notifier<String> {
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
