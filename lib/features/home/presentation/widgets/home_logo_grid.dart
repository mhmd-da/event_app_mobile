import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class HomeLogoItem {
  final String title;
  final String? imageUrl;
  final VoidCallback onTap;

  const HomeLogoItem({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });
}

class HomeLogoGrid extends StatelessWidget {
  final List<HomeLogoItem> items;

  const HomeLogoGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final crossAxisCount = w >= 700
            ? 5
            : w >= 520
            ? 4
            : w >= 360
            ? 3
            : 2;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.page),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: AppSpacing.item,
              mainAxisSpacing: AppSpacing.item,
              childAspectRatio: 1.6,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _LogoTile(item: item);
            },
          ),
        );
      },
    );
  }
}

class _LogoTile extends StatelessWidget {
  final HomeLogoItem item;

  const _LogoTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final decoration = AppDecorations.cardContainer(
      context,
    ).copyWith(borderRadius: BorderRadius.circular(16));

    Widget image;
    final url = item.imageUrl;
    if (url == null || url.trim().isEmpty) {
      image = Image.asset(
        'assets/images/default_avatar.png',
        fit: BoxFit.contain,
      );
    } else {
      image = Image.network(
        url,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/images/default_avatar.png',
            fit: BoxFit.contain,
          );
        },
      );
    }

    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        decoration: decoration,
        padding: const EdgeInsets.all(AppSpacing.item),
        child: Center(child: image),
      ),
    );
  }
}
