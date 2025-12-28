import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class InfoRowCard extends StatelessWidget {
  final String? imageUrl;
  final double imageWidth;
  final double imageHeight;
  final BorderRadius imageBorderRadius;
  final String title;
  final String? description;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final double? height;

  const InfoRowCard({
    super.key,
    this.imageUrl,
    this.imageWidth = 85,
    this.imageHeight = 85,
    this.imageBorderRadius = const BorderRadius.all(Radius.circular(12)),
    required this.title,
    this.description,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.all(0),
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = AppDecorations.cardContainer(context).copyWith(
      borderRadius: BorderRadius.circular(16),
    );
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final image = ClipRRect(
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          fit: StackFit.expand,
          children: [
            imageUrl == null || imageUrl!.isEmpty
                ? Container(
                    color: isDark ? colorScheme.surfaceVariant : colorScheme.surface,
                  )
                : Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                  ),
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
    );

    final titleText = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
    );

    final descText = description == null || description!.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySmall,
            ),
          );

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 85,
          height: 85,
          child: image,
        ),
        const SizedBox(width: AppSpacing.item),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [titleText, descText],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: AppSpacing.item),
          trailing!,
        ],
      ],
    );

    final container = Container(
      height: height ?? 85,
      padding: padding,
      decoration: decoration,
      child: content,
    );

    if (onTap == null) return container;
    return GestureDetector(onTap: onTap, child: container);
  }
}
