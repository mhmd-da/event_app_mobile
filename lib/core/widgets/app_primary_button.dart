import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../network/network_status_provider.dart';
import 'notifier.dart';

class AppPrimaryButton extends ConsumerWidget {
  final String label;
  final VoidCallback onPressed;
  final bool expanded;

  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus =
        ref.watch(networkStatusProvider).asData?.value ?? NetworkStatus.online;
    final isOffline = networkStatus == NetworkStatus.offline;
    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: isOffline ? null : AppColors.primaryGradient,
        color: isOffline ? Colors.grey : null,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isOffline
                ? Theme.of(context).disabledColor
                : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    return SizedBox(
      width: expanded ? double.infinity : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: isOffline
            ? () {
                AppNotifier.bottomMessage(
                  context,
                  AppLocalizations.of(context)!.offlineActionUnavailable,
                );
              }
            : onPressed,
        child: child,
      ),
    );
  }
}
