// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_event_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(selectedEvent)
const selectedEventProvider = SelectedEventProvider._();

final class SelectedEventProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventDetailsModel?>,
          EventDetailsModel?,
          FutureOr<EventDetailsModel?>
        >
    with
        $FutureModifier<EventDetailsModel?>,
        $FutureProvider<EventDetailsModel?> {
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
  $FutureProviderElement<EventDetailsModel?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventDetailsModel?> create(Ref ref) {
    return selectedEvent(ref);
  }
}

String _$selectedEventHash() => r'69c5cbd87d43dc19d2e6dadba80173168713851d';
