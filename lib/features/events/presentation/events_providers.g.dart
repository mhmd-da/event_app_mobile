// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventsRepository)
const eventsRepositoryProvider = EventsRepositoryProvider._();

final class EventsRepositoryProvider
    extends
        $FunctionalProvider<
          EventsRepository,
          EventsRepository,
          EventsRepository
        >
    with $Provider<EventsRepository> {
  const EventsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventsRepository create(Ref ref) {
    return eventsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventsRepository>(value),
    );
  }
}

String _$eventsRepositoryHash() => r'dc7670612ac2b6143c118677d5d6c4b8a81bdaa0';

@ProviderFor(eventsList)
const eventsListProvider = EventsListProvider._();

final class EventsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EventModel>>,
          List<EventModel>,
          FutureOr<List<EventModel>>
        >
    with $FutureModifier<List<EventModel>>, $FutureProvider<List<EventModel>> {
  const EventsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsListHash();

  @$internal
  @override
  $FutureProviderElement<List<EventModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EventModel>> create(Ref ref) {
    return eventsList(ref);
  }
}

String _$eventsListHash() => r'bd9b9d434c3ac9109e40b5fdd9113cfb0bc29a5a';

@ProviderFor(eventDetails)
const eventDetailsProvider = EventDetailsFamily._();

final class EventDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventDetailsModel>,
          EventDetailsModel,
          FutureOr<EventDetailsModel>
        >
    with
        $FutureModifier<EventDetailsModel>,
        $FutureProvider<EventDetailsModel> {
  const EventDetailsProvider._({
    required EventDetailsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailsHash();

  @override
  String toString() {
    return r'eventDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EventDetailsModel> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventDetailsModel> create(Ref ref) {
    final argument = this.argument as int;
    return eventDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailsHash() => r'fdbc0b15b3038e6fbc99d2d636331d2335fa0179';

final class EventDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EventDetailsModel>, int> {
  const EventDetailsFamily._()
    : super(
        retry: null,
        name: r'eventDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  EventDetailsProvider call(int eventId) =>
      EventDetailsProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventDetailsProvider';
}

@ProviderFor(EventsTab)
const eventsTabProvider = EventsTabProvider._();

final class EventsTabProvider extends $NotifierProvider<EventsTab, int> {
  const EventsTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsTabHash();

  @$internal
  @override
  EventsTab create() => EventsTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$eventsTabHash() => r'dfb98f5d2d1d49aaa4fe226308f8cff6e4813b05';

abstract class _$EventsTab extends $Notifier<int> {
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
