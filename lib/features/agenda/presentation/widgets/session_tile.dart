import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/utilities/session_category_helper.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/core/widgets/moderator_badge.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/shared/providers/timezone_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionTile extends ConsumerWidget {
  const SessionTile({
    super.key,
    required this.session,
    required this.onTapWidgetBuilder,
  });

  final SessionModel session;
  final WidgetBuilder onTapWidgetBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final timezonePreference = ref.watch(appTimezonePreferenceProvider);
    final color = SessionCategoryHelper.getCategoryColor(
      context,
      session.categoryTag,
    );

    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.small,
        bottom: AppSpacing.item,
        left: AppSpacing.small,
        right: AppSpacing.xSmall,
      ),
      child: IntrinsicHeight(
        child: Row(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: AppDecorations.strongerOf(
                  AppColors.defaultBg(context),
                  context,
                ),
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(12),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: AppDecorations.agendaSessionCard(
                  context,
                  bgColor: color,
                  borderColor: AppColors.defaultBg(context),
                  radius: 14,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: onTapWidgetBuilder));
                  },
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(14),
                    bottomRight: Radius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppSpacing.small,
                          left: AppSpacing.small,
                          right: AppSpacing.small,
                          bottom: AppSpacing.xSmall,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.category_outlined, size: 15),
                            const SizedBox(width: AppSpacing.xSmall),
                            Text(
                              session.category,
                              style: AppTextStyles.bodySmall,
                            ),
                            const Spacer(),
                            const Icon(Icons.lightbulb_outline, size: 15),
                            const SizedBox(width: AppSpacing.xSmall),
                            Text(session.track, style: AppTextStyles.bodySmall),
                          ],
                        ),
                      ),
                      Container(
                        //color: AppColors.defaultBg(context),
                        decoration: AppDecorations.agendaSessionCard(
                          context,
                          bgColor: AppColors.defaultBg(context),
                          borderColor: Colors.transparent,
                          radius: 0,
                          borderWidth: 0.4,
                        ),
                        child: Column(
                          children: [
                            // const Divider(color: Colors.black),
                            Text(
                              session.name ?? '',
                              style: AppTextStyles.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSpacing.xSmall),
                            if (((session.maxCapacity != null &&
                                        session.maxCapacity == 0) ||
                                    (session.currentBookings != null &&
                                        session.maxCapacity != null)) ||
                                session.hasQuickPolls)
                              Row(
                                children: [
                                  if ((session.maxCapacity != null &&
                                          session.maxCapacity == 0) ||
                                      (session.currentBookings != null &&
                                          session.maxCapacity != null))
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.group_outlined,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            (session.maxCapacity == 0)
                                                ? AppLocalizations.of(
                                                    context,
                                                  )!.unlimitedCapacity
                                                : '${session.currentBookings}/${session.maxCapacity}',
                                            style: AppTextStyles.bodySmall
                                                .copyWith(
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (((session.maxCapacity != null &&
                                              session.maxCapacity == 0) ||
                                          (session.currentBookings != null &&
                                              session.maxCapacity != null)) &&
                                      session.hasQuickPolls)
                                    const Spacer(),
                                  if (session.hasQuickPolls)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withValues(alpha: 0.12),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.poll_outlined,
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.quickPolls,
                                              style: AppTextStyles.bodySmall
                                                  .copyWith(
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            const SizedBox(height: AppSpacing.xSmall),
                            if (session.isMaxCapacityReached &&
                                !session.isRegistered)
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
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
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.maxCapacityReached,
                                        style: AppTextStyles.bodySmall.copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.error,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(height: AppSpacing.xSmall),
                            //const Divider(color: Colors.black),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ...session.speakers.map(
                            (speaker) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    speaker.profileImageUrl.isNotEmpty
                                    ? NetworkImage(speaker.profileImageUrl)
                                    : null,
                                child: speaker.profileImageUrl.isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${speaker.title} ${speaker.firstName} ${speaker.lastName}',
                                      style: AppTextStyles.headlineTine,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (speaker.isModerator) ...[
                                    const SizedBox(width: 6),
                                    Semantics(
                                      label: l10n.moderator,
                                      child: const ModeratorBadge(),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          if (session.speakers.isNotEmpty) const Divider(),
                        ],
                      ),
                      if (session.mentor != null) ...[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                session.mentor!.profileImageUrl.isNotEmpty
                                ? NetworkImage(session.mentor!.profileImageUrl)
                                : null,
                            child: session.mentor!.profileImageUrl.isEmpty
                                ? const Icon(Icons.person_outline)
                                : null,
                          ),
                          title: Text(
                            '${session.mentor!.title} ${session.mentor!.firstName} ${session.mentor!.lastName}',
                            style: AppTextStyles.headlineTine,
                          ),
                        ),
                        const Divider(),
                      ],
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppSpacing.small,
                          left: AppSpacing.small,
                          right: AppSpacing.small,
                          bottom: AppSpacing.small,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range_outlined, size: 15),
                            const SizedBox(width: AppSpacing.xSmall),
                            AppTimeFormatting.timeRangeText(
                              context,
                              start: session.startTime,
                              end: session.endTime,
                              style: AppTextStyles.bodySmall,
                              timezonePreference: timezonePreference,
                            ),
                            const Spacer(),
                            const Icon(Icons.location_on_outlined, size: 15),
                            const SizedBox(width: AppSpacing.xSmall),
                            Text(
                              session.location,
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
