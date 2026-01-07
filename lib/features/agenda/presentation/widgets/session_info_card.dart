import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:event_app/shared/providers/timezone_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionInfoCard extends ConsumerWidget {
  final SessionModel session;
  final bool showDescription;
  final bool showTime;
  final bool showLocation;
  final bool showCapacity;

  const SessionInfoCard({
    super.key,
    required this.session,
    this.showDescription = true,
    this.showTime = true,
    this.showLocation = true,
    this.showCapacity = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timezonePreference = ref.watch(appTimezonePreferenceProvider);
    return Container(
      width: double.infinity,
      decoration: AppDecorations.cardContainer(context),
      padding: const EdgeInsets.all(AppSpacing.section),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(session.name ?? '', style: AppTextStyles.headlineLarge),

          if (showDescription) ...[
            const SizedBox(height: AppSpacing.small),
            Text(session.description, style: AppTextStyles.bodyMedium),
          ],

          if (showTime) ...[
            const SizedBox(height: AppSpacing.small),
            AppTimeFormatting.timeRangeText(
              context,
              start: session.startTime,
              end: session.endTime,
              style: AppTextStyles.bodySmall,
              timezonePreference: timezonePreference,
            ),
          ],

          if (showLocation) ...[
            const SizedBox(height: AppSpacing.small),
            if (session.location.isNotEmpty)
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: AppSpacing.small),
                  Expanded(
                    child: Text(
                      session.location,
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ],
              ),
          ],

          if (showCapacity) ...[
            const SizedBox(height: AppSpacing.small),
            if (session.maxCapacity != null)
              Row(
                children: [
                  const Icon(Icons.group_outlined, size: 18),
                  const SizedBox(width: AppSpacing.xSmall),
                  Text(
                    '${session.maxCapacity}',
                    style: AppTextStyles.bodySmall,
                  ),
                  const Spacer(),
                  if (session.isMaxCapacityReached && !session.isRegistered)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.error.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.warning_amber_outlined,
                            color: Theme.of(context).colorScheme.error,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            AppLocalizations.of(context)!.maxCapacityReached,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
          ],
        ],
      ),
    );
  }
}
