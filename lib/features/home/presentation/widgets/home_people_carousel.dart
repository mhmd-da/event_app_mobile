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
  late final ScrollController _controller;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    // Updated inside LayoutBuilder where itemExtent is known.
    // Intentionally no-op here.
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    if (items.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = (constraints.maxWidth - (AppSpacing.page * 2)).clamp(
          0.0,
          double.infinity,
        );

        // Target: show 3–5 cards at the same time (smaller cards).
        const minItemWidth = 95.0;
        final spacing = AppSpacing.item;
        final candidate = ((available + spacing) / (minItemWidth + spacing))
            .floor();
        final visibleCount = candidate.clamp(3, 5);

        final itemWidth = visibleCount <= 0
            ? minItemWidth
            : (available - (spacing * (visibleCount - 1))) / visibleCount;
        final itemExtent = itemWidth + spacing;

        void updateActiveIndexFromOffset() {
          if (!_controller.hasClients) return;

          // Determine the index of the item closest to the center of the viewport
          // (so the active dot corresponds to the “middle person”).
          final viewport = _controller.position.viewportDimension;
          final center = _controller.offset + (viewport / 2);
          final contentStartPadding = AppSpacing.page;
          final raw = ((center - contentStartPadding) / itemExtent).round();
          final next = raw.clamp(
            0,
            (items.length - 1).clamp(0, items.length - 1),
          );
          if (next != _activeIndex) {
            setState(() => _activeIndex = next);
          }
        }

        // Attach/update the listener using the current computed extent.
        _controller
          ..removeListener(_onScroll)
          ..addListener(updateActiveIndexFromOffset);

        // Ensure the initial dot state matches the initial scroll offset.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          updateActiveIndexFromOffset();
        });

        return Column(
          children: [
            SizedBox(
              height: 240,
              child: ListView.separated(
                controller: _controller,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.page,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(width: AppSpacing.item),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return SizedBox(
                    width: itemWidth,
                    child: _PersonCarouselCard(item: item),
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            SizedBox(
              height: 16,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(items.length, (i) {
                      final isActive = i == _activeIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isActive
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant.withValues(
                                  alpha: 0.35,
                                ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      );
                    }),
                  ),
                ),
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
