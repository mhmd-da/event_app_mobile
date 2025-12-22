import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class AppNotifier {
  static void success(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    showTopSnackBar(overlay, CustomSnackBar.success(message: message));
  }

  static void error(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    showTopSnackBar(overlay, CustomSnackBar.error(message: message));
  }

  static void info(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    showTopSnackBar(overlay, CustomSnackBar.info(message: message));
  }

  // Bottom snackbar for simple, unobtrusive messages (grey background)
  static void bottomMessage(BuildContext context, String message) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) return;
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey.shade800,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
