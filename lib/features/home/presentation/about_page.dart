import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/core/widgets/app_primary_button.dart';
import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutCard extends ConsumerWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(selectedEventProvider);
    
    return eventAsync.when(
      data: (event) {
        if (event == null) return const SizedBox.shrink();
        return _buildCard(context, event);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
  
  Widget _buildCard(BuildContext context, dynamic event) {
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      title: l10n.aboutEvent,
      centerTitle: true,
      useGradient: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.description ?? l10n.noDescriptionAvailable,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          // const SizedBox(height: 10),
          // AppPrimaryButton(label: l10n.readMore, onPressed: () {}),
        ],
      ),
    );
  }
}
