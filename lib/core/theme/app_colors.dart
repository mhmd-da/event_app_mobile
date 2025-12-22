import 'package:flutter/material.dart';

/// Global color constants shared by light & dark themes.
class AppColors {
  // Brand
  // static const Color primary = Color(0xFFFF512F); // red
  // static const Color primaryAlt = Color(0xFFF09819); // orange
  static const Color primary = Color(0xFF2596be); // light blue
  static const Color primaryAlt = Color(0xff0f326d); // dark blue

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryAlt],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Light theme neutrals
  static const Color lightBackground = Color(0xFFF7F7F7);
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF111111);
  static const Color lightTextSecondary = Color(0xFF555555);
  static const Color lightBorder = Color(0xFFE0E0E0);

  // Dark theme neutrals
  static const Color darkBackground = Color(0xFF101014);
  static const Color darkSurface = Color(0xFF1C1C22);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFB0B0C0);
  static const Color darkBorder = Color(0xFF303040);

  // Semantic
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFE53935);


  static Color panelBg(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
      ? const Color(0xFF66BB6A).withValues(alpha: 0.18)
      : const Color(0xFF4CAF50).withValues(alpha: 0.14);

  static Color workshopBg(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
      ? const Color(0xFFFFB74D).withValues(alpha: 0.18)
      : const Color(0xFFFF9800).withValues(alpha: 0.13);

  static Color roundtableBg(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
      ? const Color(0xFF9575CD).withValues(alpha: 0.22)
      : const Color(0xFF673AB7).withValues(alpha: 0.15);

  static Color mentorshipBg(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
      ? const Color(0xFFF48FB1).withValues(alpha: 0.22)
      : const Color(0xFFE91E63).withValues(alpha: 0.15);

  static Color othersBg(BuildContext ctx) => Theme.of(ctx).brightness == Brightness.dark
      ? const Color(0xD3D3D3D3).withValues(alpha: 0.22)
      : const Color(0xA9A9A9A9).withValues(alpha: 0.15);
}
