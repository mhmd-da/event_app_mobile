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

          if (showTime || showLocation) ...[
            const SizedBox(height: AppSpacing.small),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (showTime)
                  Chip(
                    avatar: Icon(
                      Icons.access_time,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: AppTimeFormatting.timeRangeText(
                      context,
                      start: session.startTime,
                      end: session.endTime,
                      style: AppTextStyles.bodySmall,
                      timezonePreference: timezonePreference,
                    ),
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                  ),
                if (showLocation && session.location.isNotEmpty)
                  Chip(
                    avatar: Icon(
                      Icons.location_on,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    label: Text(
                      session.location,
                      style: AppTextStyles.bodySmall,
                    ),
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.1),
                  ),
              ],
            ),
          ],

        ],
      ),
    );
  }
}
