import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrPage extends ConsumerStatefulWidget {
  const MyQrPage({super.key});

  @override
  ConsumerState<MyQrPage> createState() => _MyQrPageState();
}

class _MyQrPageState extends ConsumerState<MyQrPage> {
  String? _qrId;
  Object? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final storage = ref.read(secureStorageProvider);
      final qrId = await storage.getQrCodeGuid();
      if (!mounted) return;
      setState(() {
        _qrId = (qrId ?? '').trim().isEmpty ? null : qrId;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return AppScaffold(
      title: l10n.myQrTitle,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: _loading
                ? const CircularProgressIndicator()
                : (_qrId == null || _error != null)
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.qrNotAvailable,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.qrNotAvailableHint,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: QrImageView(
                            data: _qrId!,
                            version: QrVersions.auto,
                            size: 240,
                            backgroundColor: colorScheme.surface,
                            eyeStyle: QrEyeStyle(
                              eyeShape: QrEyeShape.square,
                              color: colorScheme.onSurface,
                            ),
                            dataModuleStyle: QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.myQrSubtitle,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
