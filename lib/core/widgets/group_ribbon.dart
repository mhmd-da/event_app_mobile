import 'package:event_app/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

class GroupRibbon extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? textColor;
  final EdgeInsetsGeometry padding;
  final double tailWidth;
  final double borderRadius;
  final Color Function(String label, ThemeData theme)? colorResolver;

  const GroupRibbon({
    super.key,
    required this.label,
    this.color,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.small, vertical: AppSpacing.xSmall),
    this.tailWidth = 16,
    this.borderRadius = 8,
    this.colorResolver,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final upper = label.toUpperCase();
    final bg = color ?? (colorResolver != null ? colorResolver!(upper, theme) : _colorFor(upper, theme));
    final fg = textColor ?? _textColorFor(upper, bg);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: padding,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0.5,
                offset: const Offset(0, 1),
                color: bg.withOpacity(0.25),
              ),
            ],
          ),
          child: Text(
            upper,
            style: theme.textTheme.labelLarge?.copyWith(color: fg, fontWeight: FontWeight.w600),
          ),
        ),
        _RibbonTail(color: bg, width: tailWidth, height: 18),
      ],
    );
  }

  Color _colorFor(String upper, ThemeData theme) {
    switch (upper) {
      case 'PLATINUM':
        return Colors.grey.shade600;
      case 'GOLD':
        return Colors.amber.shade600;
      case 'SILVER':
        return Colors.blueGrey.shade400;
      case 'BRONZE':
        return Colors.brown.shade400;
      default:
        return theme.chipTheme.backgroundColor ?? theme.colorScheme.surfaceVariant;
    }
  }

  Color _textColorFor(String upper, Color bg) {
    // Ensure good contrast: use white for dark shades, black for bright (like GOLD)
    final luminance = bg.computeLuminance();
    return luminance < 0.5 ? Colors.white : Colors.black;
  }
}

class _RibbonTail extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  const _RibbonTail({required this.color, this.width = 16, this.height = 18});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _TriangleClipper(),
      child: Container(width: width, height: height, color: color),
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
