import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:url_launcher/url_launcher.dart';

class VenuePage extends ConsumerWidget {
  const VenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);

    if (selectedEvent == null || selectedEvent.venue == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Venue'),
        ),
        body: const Center(
          child: Text('No venue information available.'),
        ),
      );
    }

    final venue = selectedEvent.venue!;

    return Scaffold(
      appBar: AppBar(
        title: Text(venue.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () async {
                  final url = Uri.parse(venue.mapUrl ?? "");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open map.')),
                    );
                  }
                },
                icon: const Icon(Icons.map),
                label: const Text('Open Map'),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Floor Plans',
                style: AppTextStyles.headlineLarge,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: venue.floorPlans?.length ?? 0,
              itemBuilder: (context, index) {
                final floorPlan = venue.floorPlans![index]; // Added null check with !
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        floorPlan.imageUrl!, // Ensured imageUrl is non-null
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          floorPlan.name,
                          style: AppTextStyles.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}