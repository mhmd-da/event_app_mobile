import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:event_app/core/utilities/date_time_parsing.dart';
import 'package:event_app/core/widgets/tappable_circle_image.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonSessionsCard<T> extends StatelessWidget {
  final String title;
  final String emptyText;
  final List<T> sessions;
  final String Function(T) getTitle;
  final String Function(T) getStartTime;
  final String Function(T) getEndTime;
  final String? Function(T) getLocation;

  const PersonSessionsCard({
    super.key,
    required this.title,
    required this.emptyText,
    required this.sessions,
    required this.getTitle,
    required this.getStartTime,
    required this.getEndTime,
    required this.getLocation,
  });

  DateTime? _tryParseDateTime(String raw) {
    return AppDateTimeParsing.tryParseServerToLocal(raw);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppCard(
      title: title,
      centerTitle: true,
      useGradient: true,
      child: sessions.isEmpty
          ? Text(emptyText, style: theme.textTheme.bodyMedium)
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sessions.length,
              separatorBuilder: (_, __) => const Divider(height: 16),
              itemBuilder: (context, index) {
                final session = sessions[index];
                final location = (getLocation(session) ?? '').trim();

                final start = _tryParseDateTime(getStartTime(session));
                final end = _tryParseDateTime(getEndTime(session));

                final String? dateText;
                if (start != null && end != null) {
                  final sameDay =
                      start.year == end.year &&
                      start.month == end.month &&
                      start.day == end.day;
                  dateText = sameDay
                      ? AppTimeFormatting.formatDateYMMMd(context, start)
                      : AppTimeFormatting.formatDateRangeYMMMd(
                          context,
                          start: start,
                          end: end,
                        );
                } else if (start != null) {
                  dateText = AppTimeFormatting.formatDateYMMMd(context, start);
                } else {
                  dateText = null;
                }

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.event_note_outlined),
                  title: Text(getTitle(session)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (dateText != null && dateText.trim().isNotEmpty)
                        Text(dateText),
                      if (start != null && end != null)
                        AppTimeFormatting.timeRangeText(
                          context,
                          start: start,
                          end: end,
                        )
                      else
                        Text(
                          [
                            getStartTime(session).trim(),
                            getEndTime(session).trim(),
                          ].where((s) => s.isNotEmpty).join(' – '),
                        ),
                      if (location.isNotEmpty) Text(location),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class PersonSocialLinksCard<T> extends StatelessWidget {
  final String title;
  final String emptyText;
  final List<T> links;
  final String? Function(T) getName;
  final String Function(T) getUrl;
  final String? Function(T) getThumbnailUrl;

  const PersonSocialLinksCard({
    super.key,
    required this.title,
    required this.emptyText,
    required this.links,
    required this.getName,
    required this.getUrl,
    required this.getThumbnailUrl,
  });

  Future<void> _openUrl(BuildContext context, String url) async {
    final parsed = Uri.tryParse(url);
    if (parsed == null) return;
    await launchUrl(parsed, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      title: title,
      centerTitle: true,
      useGradient: true,
      child: links.isEmpty
          ? Text(emptyText, style: theme.textTheme.bodyMedium)
          : ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: links.length,
              separatorBuilder: (_, __) => const Divider(height: 16),
              itemBuilder: (context, index) {
                final link = links[index];
                final name = (getName(link) ?? '').trim();
                final url = getUrl(link).trim();
                final thumbnail = (getThumbnailUrl(link) ?? '').trim();

                final displayTitle = name.isNotEmpty ? name : url;

                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: SizedBox(
                    width: 40,
                    height: 40,
                    child: thumbnail.isEmpty
                        ? const CircleAvatar(child: Icon(Icons.link))
                        : TappableCircleImage(
                            imageUrl: thumbnail,
                            radius: 20,
                            placeholderIcon: Icons.link,
                          ),
                  ),
                  title: Text(displayTitle),
                  subtitle: name.isNotEmpty ? Text(url) : null,
                  trailing: const Icon(Icons.open_in_new),
                  onTap: url.isEmpty ? null : () => _openUrl(context, url),
                );
              },
            ),
    );
  }
}
