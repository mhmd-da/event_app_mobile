import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/agenda/presentation/agenda_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionReminderChip extends ConsumerWidget {
  final int sessionId;

  const SessionReminderChip({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(sessionReminderEnabledProvider(sessionId));
    final lead = ref.watch(sessionReminderLeadMinutesProvider(sessionId));
    final saving = ref.watch(sessionReminderSavingProvider(sessionId));

    String label;
    if (enabled && lead != null) {
      label = _labelForLeadMinutes(context, lead);
    } else {
      label = AppLocalizations.of(context)!.noReminderSet;
    }

    return Container(
      width: double.infinity,
      decoration: AppDecorations.chipContainer(context),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.item,
        vertical: AppSpacing.small,
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.item),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: saving ? null : () => _showReminderPicker(context, ref),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${AppLocalizations.of(context)!.reminder}: $label',
                      style: AppTextStyles.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showReminderPicker(BuildContext context, WidgetRef ref) async {
    const options = [5, 10, 15, 30, 60, 1440];

    final l10n = AppLocalizations.of(context)!;

    final selected = await showModalBottomSheet<int>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSpacing.item),
              Text(l10n.alertMeBefore, style: AppTextStyles.headlineSmall),
              const SizedBox(height: AppSpacing.item),
              for (final m in options)
                ListTile(
                  title: Text(_optionLabel(context, m)),
                  onTap: () => Navigator.pop(ctx, m),
                ),
              const SizedBox(height: AppSpacing.item),
              ListTile(
                leading: const Icon(Icons.notifications_off_outlined),
                title: Text(l10n.disableReminder),
                onTap: () => Navigator.pop(ctx, -1),
              ),
            ],
          ),
        );
      },
    );

    if (selected == null) return;

    ref.read(sessionReminderSavingProvider(sessionId).notifier).set(true);
    try {
      if (selected == -1) {
        final ok = await ref
            .read(sessionRepositoryProvider)
            .deleteReminder(sessionId);
        if (ok) {
          ref
              .read(sessionReminderEnabledProvider(sessionId).notifier)
              .set(false);
          ref
              .read(sessionReminderLeadMinutesProvider(sessionId).notifier)
              .set(null);
          if (!context.mounted) return;
          AppNotifier.info(context, l10n.disableReminder);
        }
      } else {
        final ok = await ref
            .read(sessionRepositoryProvider)
            .setReminder(sessionId, selected, true);
        if (ok) {
          ref
              .read(sessionReminderEnabledProvider(sessionId).notifier)
              .set(true);
          ref
              .read(sessionReminderLeadMinutesProvider(sessionId).notifier)
              .set(selected);
          final selectedLabel = _labelForLeadMinutesL10n(l10n, selected);
          if (!context.mounted) return;
          AppNotifier.info(context, '${l10n.reminder}: $selectedLabel');
        }
      }
    } catch (_) {
      AppNotifier.error(context, l10n.failedToUpdateReminder);
    } finally {
      ref.read(sessionReminderSavingProvider(sessionId).notifier).set(false);
    }
  }

  String _labelForLeadMinutes(BuildContext context, int lead) {
    final l10n = AppLocalizations.of(context)!;
    return _labelForLeadMinutesL10n(l10n, lead);
  }

  String _labelForLeadMinutesL10n(AppLocalizations l10n, int lead) {
    switch (lead) {
      case 5:
        return l10n.minutesBefore(5);
      case 10:
        return l10n.minutesBefore(10);
      case 15:
        return l10n.minutesBefore(15);
      case 30:
        return l10n.minutesBefore(30);
      case 60:
        return l10n.minutesBefore(60);
      case 1440:
        return l10n.minutesBefore(1440);
      default:
        return l10n.minutesBefore(lead);
    }
  }

  String _optionLabel(BuildContext context, int lead) {
    final reminderPrefix = '${AppLocalizations.of(context)!.reminder}: ';
    return _labelForLeadMinutes(context, lead).replaceAll(reminderPrefix, '');
  }
}
