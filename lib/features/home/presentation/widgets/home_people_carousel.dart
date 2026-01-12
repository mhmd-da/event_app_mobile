import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class HomeCarouselItem {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final VoidCallback onTap;

  const HomeCarouselItem({
    required this.title,
    this.subtitle,
    required this.imageUrl,
    required this.onTap,
  });
}

class HomePeopleCarousel extends StatefulWidget {
  final List<HomeCarouselItem> items;

  const HomePeopleCarousel({super.key, required this.items});

  @override
  State<HomePeopleCarousel> createState() => _HomePeopleCarouselState();
}

class _HomePeopleCarouselState extends State<HomePeopleCarousel> {
  late final PageController _controller;
  static const int _infiniteMultiplier = 10000; // Large number for pseudo-infinite scroll

  @override
  void initState() {
    super.initState();
    final items = widget.items;
    // Start at middle of "infinite" list to allow scrolling both directions
    final initialPage = items.isEmpty ? 0 : (_infiniteMultiplier ~/ 2) * items.length;
    _controller = PageController(
      viewportFraction: 0.85, // Shows peek of adjacent items
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    if (items.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        // Show one main item with slight peek of adjacent items
        return Column(
          children: [
            SizedBox(
              height: 480,
              child: PageView.builder(
                controller: _controller,
                itemCount: items.length * _infiniteMultiplier, // Pseudo-infinite
                itemBuilder: (context, index) {
                  final actualIndex = index % items.length;
                  final item = items[actualIndex];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
                    child: _PersonCarouselCard(item: item),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PersonCarouselCard extends StatelessWidget {
  final HomeCarouselItem item;

  const _PersonCarouselCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;

    Widget buildImage() {
      final url = item.imageUrl;
      if (url == null || url.trim().isEmpty) {
        return Image.asset(
          'assets/images/default_avatar.png',
          fit: BoxFit.cover,
        );
      }

      return Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/default_avatar.png',
            fit: BoxFit.cover,
          );
        },
      );
    }

    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        decoration: AppDecorations.cardContainer(
          context,
        ).copyWith(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  buildImage(),
                  if (isDark)
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: AppDecorations.darkImageOverlayGradient(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.item),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: isDark ? 0.18 : 0.10),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            item.title,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if ((item.subtitle ?? '').trim().isNotEmpty)
                    Text(
                      item.subtitle!,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.25,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
