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

    const barWidth = 4.0;

    bool isFemaleGender(String? gender) {
      final g = (gender ?? '').trim().toLowerCase();
      return g == 'female' || g == 'f' || g.contains('female');
    }

    Widget buildPersonRow({
      required String name,
      required String? imageUrl,
      required String? gender,
      required bool isModerator,
    }) {
      final trimmedImageUrl = (imageUrl ?? '').trim();
      final ImageProvider avatarProvider = trimmedImageUrl.isNotEmpty
          ? NetworkImage(trimmedImageUrl)
          : AssetImage(
              isFemaleGender(gender)
                  ? 'assets/images/default_avatar_female.png'
                  : 'assets/images/default_avatar.png',
            );

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: avatarProvider,
              child: null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: AppTextStyles.headlineTine,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isModerator) ...[
                    const SizedBox(width: 6),
                    Semantics(
                      label: l10n.moderator,
                      child: const ModeratorBadge(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget buildContent() {
      return Container(
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSpacing.small,
                  left: AppSpacing.small,
                  right: AppSpacing.small,
                  bottom: AppSpacing.xSmall,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.category_outlined, size: 15),
                    const SizedBox(width: AppSpacing.xSmall),
                    Text(session.category, style: AppTextStyles.bodySmall),
                    const Spacer(),
                    const Icon(Icons.date_range_outlined, size: 15),
                    const SizedBox(width: AppSpacing.xSmall),
                    AppTimeFormatting.timeRangeText(
                      context,
                      start: session.startTime,
                      end: session.endTime,
                      style: AppTextStyles.bodySmall,
                      timezonePreference: timezonePreference,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.small),
                decoration: AppDecorations.agendaSessionCard(
                  context,
                  bgColor: AppColors.defaultBg(context),
                  borderColor: Colors.transparent,
                  radius: 0,
                  borderWidth: 0.4,
                ),
                child: Text(
                  session.name ?? '',
                  style: AppTextStyles.headlineMedium,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (session.speakers.isNotEmpty) ...[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...session.speakers.map(
                      (speaker) => buildPersonRow(
                        name:
                            '${speaker.title} ${speaker.firstName} ${speaker.lastName}',
                        imageUrl: speaker.profileImageUrl,
                        gender: speaker.gender,
                        isModerator: speaker.isModerator,
                      ),
                    ),
                  ],
                ),
                const Divider(height: 1),
              ],
              if (session.mentor != null) ...[
                buildPersonRow(
                  name:
                      '${session.mentor!.title} ${session.mentor!.firstName} ${session.mentor!.lastName}',
                  imageUrl: session.mentor!.profileImageUrl,
                  gender: session.mentor!.gender,
                  isModerator: false,
                ),
                const Divider(height: 1),
              ],
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSpacing.small,
                  left: AppSpacing.small,
                  right: AppSpacing.small,
                  bottom: AppSpacing.small,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 15),
                        const SizedBox(width: AppSpacing.xSmall),
                        Expanded(
                          child: Text(
                            session.location,
                            style: AppTextStyles.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.small,
        bottom: AppSpacing.item,
        left: AppSpacing.small,
        right: AppSpacing.xSmall,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.hasBoundedWidth
              ? (constraints.maxWidth - barWidth)
              : null;

          return IntrinsicHeight(
            child: Row(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: barWidth,
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
                if (availableWidth != null && availableWidth > 0)
                  SizedBox(width: availableWidth, child: buildContent())
                else
                  Expanded(child: buildContent()),
              ],
            ),
          );
        },
      ),
    );
  }
}
