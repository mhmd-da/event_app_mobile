// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chatRealtimeService)
const chatRealtimeServiceProvider = ChatRealtimeServiceProvider._();

final class ChatRealtimeServiceProvider
    extends
        $FunctionalProvider<
          ChatRealtimeService,
          ChatRealtimeService,
          ChatRealtimeService
        >
    with $Provider<ChatRealtimeService> {
  const ChatRealtimeServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatRealtimeServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatRealtimeServiceHash();

  @$internal
  @override
  $ProviderElement<ChatRealtimeService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChatRealtimeService create(Ref ref) {
    return chatRealtimeService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatRealtimeService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatRealtimeService>(value),
    );
  }
}

String _$chatRealtimeServiceHash() =>
    r'3584262b95df1219e0f45cb44ea3030af372fa80';

@ProviderFor(chatSqliteRepository)
const chatSqliteRepositoryProvider = ChatSqliteRepositoryProvider._();

final class ChatSqliteRepositoryProvider
    extends
        $FunctionalProvider<
          ChatSqliteRepository,
          ChatSqliteRepository,
          ChatSqliteRepository
        >
    with $Provider<ChatSqliteRepository> {
  const ChatSqliteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatSqliteRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatSqliteRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChatSqliteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChatSqliteRepository create(Ref ref) {
    return chatSqliteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatSqliteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatSqliteRepository>(value),
    );
  }
}

String _$chatSqliteRepositoryHash() =>
    r'58c48053a34a90d13b3c9c1ba7a0e859757d12c9';
