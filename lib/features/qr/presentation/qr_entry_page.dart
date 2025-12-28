import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/qr/presentation/my_qr_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QrEntryPage extends ConsumerStatefulWidget {
  const QrEntryPage({super.key});

  @override
  ConsumerState<QrEntryPage> createState() => _QrEntryPageState();
}

class _QrEntryPageState extends ConsumerState<QrEntryPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(title: l10n.myQrTitle, body: const MyQrPage());
  }
}
