import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/storage/secure_storage_service.dart';
import 'event_photos_providers.dart';
import 'package:event_app/core/config/app_config.dart';

class EventPhotosPage extends ConsumerWidget {
  const EventPhotosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const pageSize = 24;
    return AppScaffold(
      title: AppLocalizations.of(context)!.eventPhotos,
      body: FutureBuilder<int?>(
        future: SecureStorageService().getEventId(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final eventId = snapshot.data ?? 0;
          final pageIndex = ref.watch(eventPhotosPageIndexProvider(eventId));
          final photosAsync = ref.watch(eventPhotosProvider(eventId: eventId, pageSize: pageSize));
          return photosAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, st) => Center(child: Text(AppLocalizations.of(context)!.somethingWentWrong, style: AppTextStyles.bodyMedium)),
            data: (page) {
              final photos = page.items;
              if (photos.isEmpty) {
                return Center(child: Text(AppLocalizations.of(context)!.noSessionsAvailable, style: AppTextStyles.bodyMedium));
              }
              final totalPages = (page.totalRows / pageSize).ceil().clamp(1, 1000000);
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.page),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: photos.length,
                        itemBuilder: (context, index) {
                          final p = photos[index];
                          String resolveUrl(String url) {
                            if (url.startsWith('http')) return url;
                            final baseHost = AppConfig.baseApiUrl.replaceFirst('/api', '');
                            return '$baseHost$url';
                          }
                          final thumb = p.thumbnailUrl.isNotEmpty ? resolveUrl(p.thumbnailUrl) : resolveUrl(p.imageUrl);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => _PhotoViewerPage(imageUrl: resolveUrl(p.imageUrl), caption: p.caption)));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(thumb, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const ColoredBox(color: Colors.black12)),
                                  if (p.caption.isNotEmpty)
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                        color: Colors.black45,
                                        child: Text(p.caption, style: const TextStyle(color: Colors.white), maxLines: 1, overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.section),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${AppLocalizations.of(context)!.photosPage(pageIndex)} / $totalPages', style: AppTextStyles.bodySmall),
                        Row(
                          children: [
                            AppOutlinedButton(
                              onPressed: pageIndex > 1
                                  ? () => ref.read(eventPhotosPageIndexProvider(eventId).notifier).set(pageIndex - 1)
                                  : null,
                              icon: const Icon(Icons.chevron_left),
                              label: Text(AppLocalizations.of(context)!.photosPrevious),
                            ),
                            const SizedBox(width: AppSpacing.item),
                            AppOutlinedButton(
                              onPressed: pageIndex < totalPages
                                  ? () => ref.read(eventPhotosPageIndexProvider(eventId).notifier).set(pageIndex + 1)
                                  : null,
                              icon: const Icon(Icons.chevron_right),
                              label: Text(AppLocalizations.of(context)!.photosNext),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PhotoViewerPage extends StatelessWidget {
  final String imageUrl;
  final String caption;
  const _PhotoViewerPage({required this.imageUrl, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(caption.isNotEmpty ? caption : AppLocalizations.of(context)!.eventPhotos)),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(imageUrl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
