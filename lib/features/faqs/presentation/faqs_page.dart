import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'faqs_providers.dart';

class FaqsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final faqsAsync = ref.watch(faqsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: faqsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
        data: (faqs) {
          if (faqs.isEmpty) {
            return Center(
              child: Text('No FAQs available'),
            );
          }

          return ListView.builder(
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              final faq = faqs[index];
              return ExpansionTile(
                title: Text(faq.question),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(faq.answer),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}