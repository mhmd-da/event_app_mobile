import 'package:event_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDecorations {
  static BoxDecoration agendaSessionCard(
    BuildContext ctx, {
    Color? bgColor,
    Color? borderColor,
    double? radius,
    double? borderWidth,
  }) {
   return BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(radius ?? 14),
        bottomRight: Radius.circular(radius ?? 14),
      ),
    // border: Border.all(
    //   color: accent.withValues(alpha: 0.3),
    //   width: 1.5,
    // ),
    border: Border(
      // left: BorderSide(color: bgColor ?? Theme.of(ctx).primaryColor, width: 5),
      right: BorderSide(color: borderColor ?? bgColor ?? AppColors.defaultBg(ctx).withValues(alpha: 0.8) , width: borderWidth ?? 1),
      top: BorderSide(color: borderColor ?? bgColor ?? AppColors.defaultBg(ctx).withValues(alpha: 0.8), width: borderWidth ?? 1),
      bottom: BorderSide(color: borderColor ?? bgColor ?? AppColors.defaultBg(ctx).withValues(alpha: 0.8), width: borderWidth ?? 1),
    ),
    color: (bgColor ?? Theme.of(ctx).primaryColor).withValues(alpha: 0.08),
    // boxShadow: [
    //   BoxShadow(
    //     blurRadius: 6,
    //     spreadRadius: 1,
    //     offset: const Offset(0, 2),
    //     color: bgColor ?? Theme.of(ctx).primaryColor.withValues(alpha: 0.01),
    //   ),
    // ],
  );
  }

static Color strongerOf(Color base, BuildContext context) {
  // Nudge towards theme primary for better contrast if too pale
  if (base.a < 0.8) {
    final primary = Theme.of(context).colorScheme.primary;
    return Color.alphaBlend(base.withValues(alpha: 0.6), primary);
  }
  return base;
}


  static BoxDecoration cardContainer(BuildContext ctx) {
    final theme = Theme.of(ctx);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark
        ? theme.colorScheme.surfaceVariant
        : theme.cardTheme.color!;
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: cardColor,
      boxShadow: [
        BoxShadow(
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 3),
          color: cardColor.withOpacity(0.08),
        ),
      ],
    );
  }

  static BoxDecoration listTileContainer(BuildContext ctx) => BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Theme.of(ctx).colorScheme.surface,
    boxShadow: [
      BoxShadow(
        blurRadius: 5,
        spreadRadius: 1,
        offset: const Offset(0, 2),
        color: Theme.of(ctx).shadowColor.withValues(alpha: 0.05),
      ),
    ],
  );

  static ButtonStyle primaryButton(BuildContext ctx) =>
      ElevatedButton.styleFrom(
        backgroundColor: Theme.of(ctx).colorScheme.primary,
        foregroundColor: Theme.of(ctx).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      );

  static BoxDecoration chipContainer(BuildContext ctx) => BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Theme.of(ctx).chipTheme.backgroundColor,
    boxShadow: [
      BoxShadow(
        blurRadius: 3,
        spreadRadius: 1,
        offset: const Offset(0, 1),
        color: Theme.of(ctx).shadowColor.withValues(alpha: 0.04),
      ),
    ],
  );

  static BoxDecoration logoCardContainer(BuildContext ctx) => BoxDecoration(
    borderRadius: BorderRadius.circular(14),
    color: Theme.of(ctx).cardColor,
    boxShadow: [
      BoxShadow(
        blurRadius: 5,
        spreadRadius: 1,
        offset: const Offset(0, 2),
        color: Theme.of(ctx).shadowColor.withValues(alpha: 0.06),
      ),
    ],
  );

  static BoxDecoration tabButton(BuildContext ctx, {Color? bgColor}) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: bgColor ?? Theme.of(ctx).cardColor.withValues(alpha: 0.06),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
            color: Theme.of(ctx).shadowColor.withValues(alpha: 0.04),
          ),
        ],
      );

  // Dark-mode image overlay to reduce glare on bright images.
  // Centralizing this allows easy tuning of opacity and coverage.
  static LinearGradient darkImageOverlayGradient({
    double opacityBottom = 0.26,
    double topStop = 0.0,
    double bottomStop = 1.0,
  }) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black.withOpacity(opacityBottom)],
    stops: [topStop, bottomStop],
  );
}
