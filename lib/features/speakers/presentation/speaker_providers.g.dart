// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speaker_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$speakerRepositoryHash() => r'ff2d1e63c4890234bc328ff60ef7f85583ca4cfd';

/// See also [speakerRepository].
@ProviderFor(speakerRepository)
final speakerRepositoryProvider =
    AutoDisposeProvider<SpeakerRepository>.internal(
      speakerRepository,
      name: r'speakerRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$speakerRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SpeakerRepositoryRef = AutoDisposeProviderRef<SpeakerRepository>;
String _$speakersListHash() => r'85fa618f31ebb988d53dbc7be5b4b36e010f13a4';

/// See also [speakersList].
@ProviderFor(speakersList)
final speakersListProvider =
    AutoDisposeFutureProvider<List<SpeakerModel>>.internal(
      speakersList,
      name: r'speakersListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$speakersListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SpeakersListRef = AutoDisposeFutureProviderRef<List<SpeakerModel>>;
String _$speakersListBySearchHash() =>
    r'bcac883dba8e8b3f0f5c543276c6db3cf39bfa01';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [speakersListBySearch].
@ProviderFor(speakersListBySearch)
const speakersListBySearchProvider = SpeakersListBySearchFamily();

/// See also [speakersListBySearch].
class SpeakersListBySearchFamily
    extends Family<AsyncValue<List<SpeakerModel>>> {
  /// See also [speakersListBySearch].
  const SpeakersListBySearchFamily();

  /// See also [speakersListBySearch].
  SpeakersListBySearchProvider call(String? search) {
    return SpeakersListBySearchProvider(search);
  }

  @override
  SpeakersListBySearchProvider getProviderOverride(
    covariant SpeakersListBySearchProvider provider,
  ) {
    return call(provider.search);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'speakersListBySearchProvider';
}

/// See also [speakersListBySearch].
class SpeakersListBySearchProvider
    extends AutoDisposeFutureProvider<List<SpeakerModel>> {
  /// See also [speakersListBySearch].
  SpeakersListBySearchProvider(String? search)
    : this._internal(
        (ref) => speakersListBySearch(ref as SpeakersListBySearchRef, search),
        from: speakersListBySearchProvider,
        name: r'speakersListBySearchProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$speakersListBySearchHash,
        dependencies: SpeakersListBySearchFamily._dependencies,
        allTransitiveDependencies:
            SpeakersListBySearchFamily._allTransitiveDependencies,
        search: search,
      );

  SpeakersListBySearchProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.search,
  }) : super.internal();

  final String? search;

  @override
  Override overrideWith(
    FutureOr<List<SpeakerModel>> Function(SpeakersListBySearchRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SpeakersListBySearchProvider._internal(
        (ref) => create(ref as SpeakersListBySearchRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        search: search,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<SpeakerModel>> createElement() {
    return _SpeakersListBySearchProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SpeakersListBySearchProvider && other.search == search;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, search.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SpeakersListBySearchRef
    on AutoDisposeFutureProviderRef<List<SpeakerModel>> {
  /// The parameter `search` of this provider.
  String? get search;
}

class _SpeakersListBySearchProviderElement
    extends AutoDisposeFutureProviderElement<List<SpeakerModel>>
    with SpeakersListBySearchRef {
  _SpeakersListBySearchProviderElement(super.provider);

  @override
  String? get search => (origin as SpeakersListBySearchProvider).search;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
