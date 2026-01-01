import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../theme/app_colors.dart';
import '../network/network_status_provider.dart';
import 'notifier.dart';

class AppElevatedButton extends ConsumerWidget {
  final Widget? child;
  final Widget? icon;
  final Widget? label;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  const AppElevatedButton({
    super.key,
    this.child,
    this.icon,
    this.label,
    required this.onPressed,
    this.style,
  }) : assert(
         (icon != null && label != null && child == null) ||
             (child != null && icon == null && label == null),
         'Provide either icon+label or child, not both.',
       );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus =
        ref.watch(networkStatusProvider).asData?.value ?? NetworkStatus.online;
    final isOffline = networkStatus == NetworkStatus.offline;
    final effectiveOnPressed = isOffline
        ? () {
            AppNotifier.bottomMessage(
              context,
              AppLocalizations.of(context)!.offlineActionUnavailable,
            );
          }
        : onPressed;

    // If caller provides a style, respect it (legacy behavior).
    if (style != null) {
      if (icon != null && label != null) {
        return ElevatedButton.icon(
          icon: icon!,
          label: label!,
          style: style,
          onPressed: effectiveOnPressed,
        );
      }
      return ElevatedButton(
        style: style,
        onPressed: effectiveOnPressed,
        child: child!,
      );
    }

    final contentTextStyle = TextStyle(
      color: isOffline
          ? Theme.of(context).disabledColor
          : Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

    final Widget content = (icon != null && label != null)
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconTheme.merge(
                data: IconThemeData(color: contentTextStyle.color),
                child: icon!,
              ),
              const SizedBox(width: 8),
              DefaultTextStyle.merge(style: contentTextStyle, child: label!),
            ],
          )
        : DefaultTextStyle.merge(style: contentTextStyle, child: child!);

    final decoratedChild = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        gradient: isOffline ? null : AppColors.primaryGradient,
        color: isOffline ? Colors.grey : null,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(child: content),
    );

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: effectiveOnPressed,
      child: decoratedChild,
    );
  }
}

class AppOutlinedButton extends ConsumerWidget {
  final Widget? child;
  final Widget? icon;
  final Widget? label;
  final VoidCallback? onPressed;
  final ButtonStyle? style;

  const AppOutlinedButton({
    super.key,
    this.child,
    this.icon,
    this.label,
    required this.onPressed,
    this.style,
  }) : assert(
         (icon != null && label != null && child == null) ||
             (child != null && icon == null && label == null),
         'Provide either icon+label or child, not both.',
       );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus =
        ref.watch(networkStatusProvider).asData?.value ?? NetworkStatus.online;
    final isOffline = networkStatus == NetworkStatus.offline;
    final effectiveOnPressed = isOffline
        ? () {
            AppNotifier.bottomMessage(
              context,
              AppLocalizations.of(context)!.offlineActionUnavailable,
            );
          }
        : onPressed;

    final effectiveStyle =
        style ??
        OutlinedButton.styleFrom(
          foregroundColor: isOffline ? Colors.grey : AppColors.primary,
          side: BorderSide(color: isOffline ? Colors.grey : AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        );

    if (icon != null && label != null) {
      return OutlinedButton.icon(
        icon: icon!,
        label: label!,
        style: effectiveStyle,
        onPressed: effectiveOnPressed,
      );
    }
    return OutlinedButton(
      style: effectiveStyle,
      onPressed: effectiveOnPressed,
      child: child!,
    );
  }
}

class AppIconButton extends ConsumerWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final Color? color;
  final String? tooltip;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkStatus =
        ref.watch(networkStatusProvider).asData?.value ?? NetworkStatus.online;
    final isOffline = networkStatus == NetworkStatus.offline;
    return IconButton(
      icon: icon,
      color: color,
      tooltip: tooltip,
      onPressed: isOffline
          ? () {
              AppNotifier.bottomMessage(
                context,
                AppLocalizations.of(context)!.offlineActionUnavailable,
              );
            }
          : onPressed,
    );
  }
}
