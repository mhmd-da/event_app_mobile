import 'package:event_app/core/network/api_client.dart';
import 'package:event_app/features/directory/data/directory_repository.dart';
import 'package:event_app/features/directory/domain/person_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client_provider.dart';
import '../../events/presentation/state/selected_event_provider.dart' show selectedEventProvider;

final directoryRepositoryProvider = Provider<DirectoryRepository>((ref) {
  return DirectoryRepository(ref.watch(apiClientProvider));
});

final speakersListProvider = FutureProvider<List<PersonModel>>((ref) async {
  return ref.watch(directoryRepositoryProvider).getSpeakers(ref.watch(selectedEventProvider)!.id, ref.watch(directorySearchProvider));
});

final mentorsListProvider = FutureProvider<List<PersonModel>>((ref) async {
  return ref.watch(directoryRepositoryProvider).getMentors(ref.watch(selectedEventProvider)!.id, ref.watch(directorySearchProvider));
});

/// Holds the current search text
final directorySearchProvider = StateProvider<String>((ref) => '');
