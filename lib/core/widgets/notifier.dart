import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import '../theme/app_spacing.dart';

class AppNotifier {
  static ({Color accent, IconData icon}) _styleFor(
    BuildContext context,
    AnimatedSnackBarType type,
  ) {
    final scheme = Theme.of(context).colorScheme;
    switch (type) {
      case AnimatedSnackBarType.error:
        return (accent: scheme.error, icon: Icons.error_outline);
      case AnimatedSnackBarType.success:
        return (accent: scheme.tertiary, icon: Icons.check_circle_outline);
      case AnimatedSnackBarType.warning:
        return (accent: scheme.secondary, icon: Icons.warning_amber_rounded);
      case AnimatedSnackBarType.info:
        return (accent: scheme.primary, icon: Icons.info_outline);
    }
  }

  static void _show(
    BuildContext context,
    String message,
    AnimatedSnackBarType type, {
    MobileSnackBarPosition position = MobileSnackBarPosition.top,
  }) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = _styleFor(context, type);

    // Subtle tinted surface background derived from the theme.
    final background = Color.alphaBlend(
      style.accent.withValues(alpha: 0.14),
      scheme.surface,
    );

    final snackBar = AnimatedSnackBar(
      duration: const Duration(seconds: 2),
      snackBarStrategy: RemoveSnackBarStrategy(),
      mobileSnackBarPosition: position,
      desktopSnackBarPosition: position == MobileSnackBarPosition.top
          ? DesktopSnackBarPosition.topCenter
          : DesktopSnackBarPosition.bottomCenter,
      mobilePositionSettings: const MobilePositionSettings(
        left: AppSpacing.page,
        right: AppSpacing.page,
        topOnAppearance: 60,
        topOnDissapear: -120,
        bottomOnAppearance: 60,
        bottomOnDissapear: -120,
      ),
      builder: (ctx) {
        final textStyle = theme.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w600,
        );

        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: style.accent.withValues(alpha: 0.30)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: style.accent.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(style.icon, color: style.accent, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    message,
                    style: textStyle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    snackBar.show(context);
  }

  static void success(BuildContext context, String message) {
    _show(context, message, AnimatedSnackBarType.success);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, AnimatedSnackBarType.error);
  }

  static void info(BuildContext context, String message) {
    _show(context, message, AnimatedSnackBarType.info);
  }

  // Bottom snackbar for simple, unobtrusive messages (grey background)
  static void bottomMessage(BuildContext context, String message) {
    _show(
      context,
      message,
      AnimatedSnackBarType.info,
      position: MobileSnackBarPosition.bottom,
    );
  }
}
