import 'package:flutter/material.dart';

class TappableCircleImage extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final IconData placeholderIcon;

  const TappableCircleImage({
    super.key,
    required this.imageUrl,
    required this.radius,
    required this.placeholderIcon,
  });

  bool get _hasImage => imageUrl != null && imageUrl!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(radius + 8),
      onTap: _hasImage
          ? () => _showImagePreview(context, imageUrl!.trim())
          : null,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: theme.colorScheme.surfaceVariant,
        backgroundImage: _hasImage ? NetworkImage(imageUrl!.trim()) : null,
        child: !_hasImage
            ? Icon(
                placeholderIcon,
                color: theme.colorScheme.onSurfaceVariant,
                size: radius,
              )
            : null,
      ),
    );
  }

  static Future<void> _showImagePreview(
    BuildContext context,
    String imageUrl,
  ) async {
    final theme = Theme.of(context);

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Center(
                child: Material(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 700,
                      maxHeight: 700,
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => SizedBox(
                        width: 320,
                        height: 320,
                        child: Center(
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                top: 8,
                end: 8,
                child: Material(
                  color: theme.colorScheme.surface.withValues(alpha: 0.85),
                  shape: const CircleBorder(),
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
