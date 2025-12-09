import 'package:event_app/features/mentors/data/mentor_repository.dart';
import 'package:event_app/features/mentors/domain/mentor_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client_provider.dart';

final mentorRepositoryProvider = Provider<MentorRepository>((ref) {
  return MentorRepository(ref.watch(apiClientProvider));
});

final mentorsListProvider = FutureProvider<List<MentorModel>>((ref) async {
  return ref.watch(mentorRepositoryProvider).getMentors('');
});