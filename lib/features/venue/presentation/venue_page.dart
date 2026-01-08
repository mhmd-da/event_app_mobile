import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/l10n/app_localizations.dart';

class VenuePage extends ConsumerWidget {
  const VenuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(selectedEventProvider);

    return eventAsync.when(
      data: (selectedEvent) {
        if (selectedEvent == null || selectedEvent.venue == null) {
          return Center(child: Text(AppLocalizations.of(context)!.noVenueInfo));
        }
        final venue = selectedEvent.venue!;
        return _buildVenuePage(context, venue, selectedEvent);
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }

  Widget _buildVenuePage(
    BuildContext context,
    dynamic venue,
    dynamic selectedEvent,
  ) {
    return AppScaffold(
      title: venue.name,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () async {
                  final l10n = AppLocalizations.of(context)!;
                  final url = Uri.parse(venue.mapUrl ?? "");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    AppNotifier.error(context, l10n.mapOpenFailed);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.map_outlined,
                                size: 64,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                AppLocalizations.of(context)!.tapToOpenMap,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            AppCard(
              title: AppLocalizations.of(context)!.floorPlans,
              centerTitle: true,
              useGradient: true,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: venue.floorPlans?.length ?? 0,
                itemBuilder: (context, index) {
                  final floorPlan =
                      venue.floorPlans![index]; // Added null check with !
                  return AppCard(
                    title: floorPlan.name,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          floorPlan.imageUrl!, // Ensured imageUrl is non-null
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
