import 'package:event_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final String? title;
  final bool centerTitle;
  final bool useGradient;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    this.title,
    this.centerTitle = false,
    this.useGradient = false,
    required this.child,
    this.padding,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultPadding = title != null 
        ? EdgeInsets.zero 
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 18);
    
    final card = Card(
      color: theme.brightness == Brightness.dark
          ? theme.colorScheme.surfaceVariant
          : theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: useGradient ? null : theme.colorScheme.primary,
                gradient: useGradient ? AppColors.primaryGradient : null,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Text(
                title!,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
              ),
            ),
            Padding(
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: child,
            ),
          ] else
            Padding(
              padding: padding ?? defaultPadding,
              child: child,
            ),
        ],
      ),
    );

    final wrappedCard = margin != null 
        ? Padding(padding: margin!, child: card)
        : card;

    if (onTap == null) return wrappedCard;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: wrappedCard,
    );
  }
}
