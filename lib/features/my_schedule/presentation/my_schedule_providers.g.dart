// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_schedule_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myScheduleRepository)
const myScheduleRepositoryProvider = MyScheduleRepositoryProvider._();

final class MyScheduleRepositoryProvider
    extends
        $FunctionalProvider<
          MyScheduleRepository,
          MyScheduleRepository,
          MyScheduleRepository
        >
    with $Provider<MyScheduleRepository> {
  const MyScheduleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myScheduleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myScheduleRepositoryHash();

  @$internal
  @override
  $ProviderElement<MyScheduleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MyScheduleRepository create(Ref ref) {
    return myScheduleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MyScheduleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MyScheduleRepository>(value),
    );
  }
}

String _$myScheduleRepositoryHash() =>
    r'1ed00123f699b41d42a99d697959f14b623ab085';

@ProviderFor(mySchedule)
const myScheduleProvider = MyScheduleProvider._();

final class MyScheduleProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SessionModel>>,
          List<SessionModel>,
          FutureOr<List<SessionModel>>
        >
    with
        $FutureModifier<List<SessionModel>>,
        $FutureProvider<List<SessionModel>> {
  const MyScheduleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myScheduleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myScheduleHash();

  @$internal
  @override
  $FutureProviderElement<List<SessionModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SessionModel>> create(Ref ref) {
    return mySchedule(ref);
  }
}

String _$myScheduleHash() => r'06f090351c7460baf07fa5957e215531f16b32b7';

@ProviderFor(ScheduleViewMode)
const scheduleViewModeProvider = ScheduleViewModeProvider._();

final class ScheduleViewModeProvider
    extends $NotifierProvider<ScheduleViewMode, MyScheduleViewMode> {
  const ScheduleViewModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleViewModeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleViewModeHash();

  @$internal
  @override
  ScheduleViewMode create() => ScheduleViewMode();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MyScheduleViewMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MyScheduleViewMode>(value),
    );
  }
}

String _$scheduleViewModeHash() => r'fd98463c1308ebb499e37ff0fbc39775d6e0532a';

abstract class _$ScheduleViewMode extends $Notifier<MyScheduleViewMode> {
  MyScheduleViewMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MyScheduleViewMode, MyScheduleViewMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MyScheduleViewMode, MyScheduleViewMode>,
              MyScheduleViewMode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
