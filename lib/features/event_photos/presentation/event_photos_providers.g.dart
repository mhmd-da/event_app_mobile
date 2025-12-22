// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_photos_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventPhotosRepository)
const eventPhotosRepositoryProvider = EventPhotosRepositoryProvider._();

final class EventPhotosRepositoryProvider
    extends
        $FunctionalProvider<
          EventPhotosRepository,
          EventPhotosRepository,
          EventPhotosRepository
        >
    with $Provider<EventPhotosRepository> {
  const EventPhotosRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventPhotosRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventPhotosRepositoryHash();

  @$internal
  @override
  $ProviderElement<EventPhotosRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EventPhotosRepository create(Ref ref) {
    return eventPhotosRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventPhotosRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventPhotosRepository>(value),
    );
  }
}

String _$eventPhotosRepositoryHash() =>
    r'028866939f7e3ba5e8c75f1ed12ac6624e1ae6c2';

@ProviderFor(EventPhotosPageIndex)
const eventPhotosPageIndexProvider = EventPhotosPageIndexFamily._();

final class EventPhotosPageIndexProvider
    extends $NotifierProvider<EventPhotosPageIndex, int> {
  const EventPhotosPageIndexProvider._({
    required EventPhotosPageIndexFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'eventPhotosPageIndexProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventPhotosPageIndexHash();

  @override
  String toString() {
    return r'eventPhotosPageIndexProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EventPhotosPageIndex create() => EventPhotosPageIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EventPhotosPageIndexProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventPhotosPageIndexHash() =>
    r'c12a16ace6352f5dbe776e8b4f18e40a4679aadf';

final class EventPhotosPageIndexFamily extends $Family
    with $ClassFamilyOverride<EventPhotosPageIndex, int, int, int, int> {
  const EventPhotosPageIndexFamily._()
    : super(
        retry: null,
        name: r'eventPhotosPageIndexProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventPhotosPageIndexProvider call(int eventId) =>
      EventPhotosPageIndexProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventPhotosPageIndexProvider';
}

abstract class _$EventPhotosPageIndex extends $Notifier<int> {
  late final _$args = ref.$arg as int;
  int get eventId => _$args;

  int build(int eventId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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

@ProviderFor(eventPhotos)
const eventPhotosProvider = EventPhotosFamily._();

final class EventPhotosProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventPhotosPage>,
          EventPhotosPage,
          FutureOr<EventPhotosPage>
        >
    with $FutureModifier<EventPhotosPage>, $FutureProvider<EventPhotosPage> {
  const EventPhotosProvider._({
    required EventPhotosFamily super.from,
    required ({int eventId, int pageSize}) super.argument,
  }) : super(
         retry: null,
         name: r'eventPhotosProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventPhotosHash();

  @override
  String toString() {
    return r'eventPhotosProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<EventPhotosPage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventPhotosPage> create(Ref ref) {
    final argument = this.argument as ({int eventId, int pageSize});
    return eventPhotos(
      ref,
      eventId: argument.eventId,
      pageSize: argument.pageSize,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EventPhotosProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventPhotosHash() => r'e54f7b4fd21b6f09b0e79b9903ea0381b0f7b0f1';

final class EventPhotosFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<EventPhotosPage>,
          ({int eventId, int pageSize})
        > {
  const EventPhotosFamily._()
    : super(
        retry: null,
        name: r'eventPhotosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EventPhotosProvider call({required int eventId, int pageSize = 24}) =>
      EventPhotosProvider._(
        argument: (eventId: eventId, pageSize: pageSize),
        from: this,
      );

  @override
  String toString() => r'eventPhotosProvider';
}
