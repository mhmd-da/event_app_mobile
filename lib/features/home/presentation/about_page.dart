import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/core/widgets/app_primary_button.dart';
import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutCard extends ConsumerWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(selectedEventProvider)!;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.description ?? "No description available.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          AppPrimaryButton(
            label: "Read More",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
