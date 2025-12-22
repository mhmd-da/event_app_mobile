import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/utilities/session_category_helper.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({super.key, required this.session, required this.onTapWidgetBuilder});

  final SessionModel session;
  final WidgetBuilder onTapWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.jm();
    final start = timeFormat.format(session.startTime.toLocal());
    final end = timeFormat.format(session.endTime.toLocal());

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
            session.category,
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: onTapWidgetBuilder,
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.item),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // 👈 fixes top alignment
              children: [
                // The colored indicator line, controlled by theme
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
                // SESSION
                Expanded(
                  child: Column(
                    children: [
                      //Category + Track
                      Row(
                        children: [
                          const Icon(Icons.category_outlined, size: 15),
                          const SizedBox(width: AppSpacing.xSmall),
                          Text(session.category,style: AppTextStyles.bodySmall),
                          const Spacer(),
                          const Icon(Icons.lightbulb_outline, size: 15),
                          const SizedBox(width: AppSpacing.xSmall),
                          Text(session.track, style: AppTextStyles.bodySmall),
                        ],
                      ),
                      Divider(),
                      //NAME
                      Text(
                        session.name ?? '',
                        style: AppTextStyles.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xSmall),
                      Divider(),
                      //SPEAKERS
                      Column(
                        children: [
                          ...session.speakers.map(
                            (speaker) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: speaker.profileImageUrl.isNotEmpty
                                    ? NetworkImage(speaker.profileImageUrl)
                                    : null,
                                child: speaker.profileImageUrl.isEmpty
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              title: Text(
                                "${speaker.title} ${speaker.firstName} ${speaker.lastName}",
                                style: AppTextStyles.headlineTine,
                              ),
                              //subtitle: Text("${speaker.companyName} — ${speaker.position}"),
                            ),
                          ),
                          session.speakers.isNotEmpty ? Divider() : SizedBox.shrink(),
                        ],
                      ),
                      //MENTOR
                      if (session.mentor != null) ...[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: session.mentor!.profileImageUrl.isNotEmpty
                                ? NetworkImage(session.mentor!.profileImageUrl)
                                : null,
                            child: session.mentor!.profileImageUrl.isEmpty
                                ? const Icon(Icons.person_outline)
                                : null,
                          ),
                          title: Text(
                            "${session.mentor!.title} ${session.mentor!.firstName} ${session.mentor!.lastName}",
                            style: AppTextStyles.headlineTine,
                          ),
                        ),
                        Divider(),
                      ],
                      // TIME + LOCATION
                      Row(
                        children: [
                          const Icon(Icons.date_range_outlined, size: 15),
                          const SizedBox(width: AppSpacing.xSmall),
                          Text('$start – $end', style: AppTextStyles.bodySmall),
                          const Spacer(),
                          const Icon(Icons.location_on_outlined, size: 15),
                          const SizedBox(width: AppSpacing.xSmall),
                          Text(
                            session.location,
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
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
