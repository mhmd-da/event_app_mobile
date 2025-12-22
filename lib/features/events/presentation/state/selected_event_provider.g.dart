// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_event_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedEvent)
const selectedEventProvider = SelectedEventProvider._();

final class SelectedEventProvider
    extends $NotifierProvider<SelectedEvent, EventDetailsModel?> {
  const SelectedEventProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedEventProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedEventHash();

  @$internal
  @override
  SelectedEvent create() => SelectedEvent();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventDetailsModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventDetailsModel?>(value),
    );
  }
}

String _$selectedEventHash() => r'63ef723c26dd0fd03848d5cb3aa7ef8e6443674a';

abstract class _$SelectedEvent extends $Notifier<EventDetailsModel?> {
  EventDetailsModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EventDetailsModel?, EventDetailsModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EventDetailsModel?, EventDetailsModel?>,
              EventDetailsModel?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
