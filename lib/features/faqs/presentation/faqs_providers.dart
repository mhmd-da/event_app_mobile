import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repository/faqs_repository.dart';
import '../domain/faqs_model.dart';
import '../../../core/network/api_client_provider.dart';

part 'faqs_providers.g.dart';

@Riverpod(keepAlive: true)
FaqsRepository faqsRepository(Ref ref) => FaqsRepository(ref.watch(apiClientProvider));

@riverpod
Future<List<Faq>> faqsList(Ref ref) async => ref.watch(faqsRepositoryProvider).getFaqs();