import 'package:event_app/features/mentors/data/mentor_repository.dart';
import 'package:event_app/features/mentors/domain/mentor_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/api_client_provider.dart';

part 'mentor_providers.g.dart';

@Riverpod(keepAlive: true)
MentorRepository mentorRepository(Ref ref) => MentorRepository(ref.watch(apiClientProvider));

@riverpod
Future<List<MentorModel>> mentorsList(Ref ref) async => ref.watch(mentorRepositoryProvider).getMentors('');