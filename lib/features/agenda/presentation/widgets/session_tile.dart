import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/utilities/session_category_helper.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/core/widgets/moderator_badge.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({
    super.key,
    required this.session,
    required this.onTapWidgetBuilder,
  });

  final SessionModel session;
  final WidgetBuilder onTapWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.small,
        bottom: AppSpacing.item,
      ),
      child: Container(
        decoration: AppDecorations.agendaSessionCard(
          context,
          bgColor: SessionCategoryHelper.getCategoryColor(
            context,
            session.categoryTag,
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: onTapWidgetBuilder));
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.item),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: Container(
                    width: 3,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.item),
                Expanded(
                  child: Column(
                    children: [
                      Row(
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
                      const Divider(),
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
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.12),
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
                                      style: AppTextStyles.bodySmall.copyWith(
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
                              Expanded(
                                child: Align(
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
                                      borderRadius: BorderRadius.circular(8),
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
                              ),
                          ],
                        ),
                      const SizedBox(height: AppSpacing.xSmall),
                      if (session.isMaxCapacityReached && !session.isRegistered)
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
                                  color: Theme.of(context).colorScheme.error,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.maxCapacityReached,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: AppSpacing.xSmall),
                      const Divider(),
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
                      Row(
                        children: [
                          const Icon(Icons.date_range_outlined, size: 15),
                          const SizedBox(width: AppSpacing.xSmall),
                          AppTimeFormatting.timeRangeText(
                            context,
                            start: session.startTime,
                            end: session.endTime,
                            style: AppTextStyles.bodySmall,
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
                      const SizedBox(height: AppSpacing.small),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
