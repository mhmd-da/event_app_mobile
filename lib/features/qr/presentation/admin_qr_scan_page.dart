import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// Admin QR scanning has been removed from the mobile app.
class AdminQrScanPage extends StatelessWidget {
  const AdminQrScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      title: l10n.qrTitle,
      body: Center(child: Text(l10n.qrNotAvailableHint)),
    );
  }
}
