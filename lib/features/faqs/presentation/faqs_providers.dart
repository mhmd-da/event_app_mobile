import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/faqs_repository.dart';
import '../domain/faqs_model.dart';
import '../../../core/network/api_client_provider.dart';

final faqsRepositoryProvider = Provider<FaqsRepository>((ref) {
  return FaqsRepository(ref.watch(apiClientProvider));
});

final faqsListProvider = FutureProvider<List<Faq>>((ref) async {
  return ref.watch(faqsRepositoryProvider).getFaqs();
});