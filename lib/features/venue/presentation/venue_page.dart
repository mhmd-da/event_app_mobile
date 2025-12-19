import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import 'package:url_launcher/url_launcher.dart';

class VenuePage extends ConsumerWidget {
  const VenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEvent = ref.watch(selectedEventProvider);

    if (selectedEvent == null || selectedEvent.venue == null) {
      return const Center(
        child: Text('No venue information available.'),
      );
    }
    final venue = selectedEvent.venue!;

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
                  final url = Uri.parse(venue.mapUrl ?? "");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Could not open map.')),
                    );
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: Builder(
                      builder: (context) {
                        final rawUrl = venue.mapUrl ?? '';
                        final coords = _extractLatLng(rawUrl);
                        String? staticUrl;
                        if (coords != null) {
                          staticUrl = _buildStaticMapUrl(coords[0], coords[1]);
                          return _MapThumb(staticUrl: staticUrl);
                        }
                        // Try resolving short Google Maps URLs to a full link with coords
                        if (rawUrl.contains('maps.app.goo.gl')) {
                          return FutureBuilder<List<double>?>(
                            future: _resolveLatLngFromShortUrl(rawUrl),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return _MapThumb.placeholder();
                              }
                              final resolved = snapshot.data;
                              if (resolved != null) {
                                staticUrl = _buildStaticMapUrl(resolved[0], resolved[1]);
                                return _MapThumb(staticUrl: staticUrl);
                              }
                              return _MapThumb.placeholder();
                            },
                          );
                        }
                        // Fallback
                        return _MapThumb.placeholder();
                      },
                    ),
                  ),
                ),
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

// Attempts to extract latitude/longitude from common map URL patterns
List<double>? _extractLatLng(String url) {
  final patterns = <RegExp>[
    RegExp(r'[?&]q=([-0-9.]+),([-0-9.]+)'),
    RegExp(r'@([-0-9.]+),([-0-9.]+)'),
    RegExp(r'[?&]ll=([-0-9.]+),([-0-9.]+)'),
    RegExp(r'!3d([-0-9.]+)!4d([-0-9.]+)'),
  ];
  for (final p in patterns) {
    final m = p.firstMatch(url);
    if (m != null && m.groupCount >= 2) {
      final lat = double.tryParse(m.group(1)!);
      final lng = double.tryParse(m.group(2)!);
      if (lat != null && lng != null) return [lat, lng];
    }
  }
  // Handle Google embed variant: !2d<lng>!3d<lat>
  final mAlt = RegExp(r'!2d([-0-9.]+)!3d([-0-9.]+)').firstMatch(url);
  if (mAlt != null && mAlt.groupCount >= 2) {
    final lng = double.tryParse(mAlt.group(1)!);
    final lat = double.tryParse(mAlt.group(2)!);
    if (lat != null && lng != null) return [lat, lng];
  }
  return null;
}

String _buildStaticMapUrl(double lat, double lng) {
  if (AppConfig.googleStaticMapsKey.isNotEmpty) {
    return AppConfig.googleStaticMapImageUrl(lat, lng, width: 800, height: 400, zoom: 15);
  }
  return AppConfig.openStreetMapStaticImageUrl(lat, lng, width: 800, height: 400, zoom: 15);
}

Future<List<double>?> _resolveLatLngFromShortUrl(String url) async {
  try {
    final dio = Dio(BaseOptions(followRedirects: false, validateStatus: (s) => s != null && s < 400 || s == 302 || s == 301));
    final resp = await dio.head(url);
    final loc = resp.headers.value('location');
    if (loc != null && loc.isNotEmpty) {
      final coords = _extractLatLng(loc);
      if (coords != null) return coords;
    }
    // Fallback: try GET with redirects to capture final URL
    final respGet = await dio.get(url, options: Options(followRedirects: true));
    final finalUrl = respGet.realUri.toString();
    return _extractLatLng(finalUrl);
  } catch (_) {
    return null;
  }
}

class _MapThumb extends StatelessWidget {
  final String? staticUrl;
  const _MapThumb({this.staticUrl});

  static Widget placeholder() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.grey.shade300,
          child: const Center(child: Icon(Icons.map, size: 48)),
        ),
        const _OpenMapLabel(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        if (staticUrl != null)
          Image.network(staticUrl!, fit: BoxFit.cover)
        else
          Container(
            color: Colors.grey.shade300,
            child: const Center(child: Icon(Icons.map, size: 48)),
          ),
        const _OpenMapLabel(),
      ],
    );
  }
}

class _OpenMapLabel extends StatelessWidget {
  const _OpenMapLabel();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Open Map',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}