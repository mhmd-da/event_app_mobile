import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/utilities/session_category_helper.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/agenda/presentation/session_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SessionTile extends StatelessWidget {
  const SessionTile({super.key, required this.session});

  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat.jm();
    final start = timeFormat.format(session.startTime.toLocal());
    final end = timeFormat.format(session.endTime.toLocal());

    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.page,
        right: AppSpacing.page,
        bottom: AppSpacing.item,
      ),
      child: Container(
        decoration: AppDecorations.agendaCard(
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
                builder: (_) => SessionDetailsPage(session: session),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Category
                      Text(
                        session.category ?? '',
                        style: AppTextStyles.bodySmall,
                      ),
                      Divider(),
                      //NAME
                      Text(
                        session.name ?? '',
                        style: AppTextStyles.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xSmall),
                      // DESCRIPTION
                      Row(
                        children: [
                          const Icon(Icons.description_outlined, size: 15),
                          Text(
                            session.description ?? '',
                            style: AppTextStyles.bodyMedium,
                          ),
                        ],
                      ),

                      Divider(),
                      //SPEAKERS
                      Column(
                        children: [
                          ...session.speakers.map(
                                (speaker) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: speaker.profileImageUrl != null
                                    ? NetworkImage(speaker.profileImageUrl!)
                                    : null,
                                child: speaker.profileImageUrl == null
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              title: Text(
                                "${speaker.title} ${speaker.firstName} ${speaker.lastName}",
                                style: AppTextStyles.bodySmall,
                              ),
                              //subtitle: Text("${speaker.companyName} — ${speaker.position}"),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      // TIME + LOCATION
                      Row(
                        children: [
                          const Icon(Icons.date_range_outlined, size: 15),
                          Text('$start – $end', style: AppTextStyles.bodySmall),
                          const Spacer(),
                          const Icon(Icons.location_on_outlined, size: 15),
                          const SizedBox(width: AppSpacing.xSmall),
                          Expanded(
                            child: Text(
                              session.location ?? '',
                              style: AppTextStyles.bodySmall,
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
        ),
      ),
    );
  }
}