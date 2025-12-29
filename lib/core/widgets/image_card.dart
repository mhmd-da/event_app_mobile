import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final String? imageUrl;
  final String? cardTitle;

  const ImageCard({
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.imageUrl,
    this.cardTitle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget buildImage() {
      final url = imageUrl;
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
      onTap: () => onTap?.call(),
      child: Container(
        decoration: AppDecorations.cardContainer(
          context,
        ).copyWith(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // IMAGE — SAME STYLE AS MUSCLE IMAGES
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
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
            ),

            // NAME UNDER IMAGE
            Padding(
              padding: const EdgeInsets.all(AppSpacing.item),
              child: Text(
                cardTitle ?? "",
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
