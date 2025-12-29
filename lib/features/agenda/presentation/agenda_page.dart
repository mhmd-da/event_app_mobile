import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/agenda/presentation/agenda_providers.dart';
import 'package:event_app/features/agenda/presentation/session_details_page.dart';
import 'package:event_app/features/agenda/presentation/widgets/agenda_date_tabs.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_tile.dart';
import 'package:event_app/features/mentorship/presentation/mentorship_time_slots_page.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';

class AgendaPage extends ConsumerWidget {
  const AgendaPage({super.key, this.category});

  final String? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionsForAgendaListProvider(category));
    final groupingMethod = ref.watch(groupingMethodProvider);
    final selectedDate = ref.watch(selectedAgendaDateProvider);

    String? appTitle;
    if (category != null) {
      switch (category) {
        case 'WORKSHOP':
          appTitle = AppLocalizations.of(context)!.workshops;
          break;
        case 'ROUNDTABLE':
          appTitle = AppLocalizations.of(context)!.roundtables;
          break;
        case 'MENTORSHIP':
          appTitle = AppLocalizations.of(context)!.mentorship;
          break;
        default:
          appTitle = AppLocalizations.of(context)!.agenda;
      }
    }

    return AppScaffold(
      title: appTitle,
      body: sessionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            AppLocalizations.of(context)!.somethingWentWrong,
            style: AppTextStyles.bodyMedium,
          ),
        ),
        data: (sessions) {
          if (sessions.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noSessionsAvailable,
                style: AppTextStyles.bodyMedium,
              ),
            );
          }

          final groupedSessions = groupBy(
            sessions,
            (s) => AppTimeFormatting.formatDayLabelEeeD(context, s.startTime),
          );
          final dateTabs = groupedSessions.keys.toList();

          // Ensure a default selection: first date tab when opening the page
          final effectiveSelectedDate =
              selectedDate ?? (dateTabs.isNotEmpty ? dateTabs.first : null);
          if (selectedDate == null && effectiveSelectedDate != null) {
            // Defer provider update to avoid modifying provider during build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref
                  .read(selectedAgendaDateProvider.notifier)
                  .set(effectiveSelectedDate);
            });
          }

          final groupingTabs =
              groupedSessions[effectiveSelectedDate]
                  ?.map(
                    (s) => groupingMethod == 'track'
                        ? s.track
                        : (groupingMethod == 'category' ? s.category : ''),
                  )
                  .toSet()
                  .toList() ??
              [];

          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DateTabs(
                      dates: dateTabs,
                      selectedDate: effectiveSelectedDate,
                      onSelect: (date) => ref
                          .read(selectedAgendaDateProvider.notifier)
                          .set(date),
                    ),
                  ),
                  AppIconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: () async {
                      final selectedMethod = await showModalBottomSheet<String>(
                        context: context,
                        builder: (context) {
                          return SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!.groupByTime,
                                  ),
                                  onTap: () => Navigator.pop(context, 'time'),
                                ),
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!.groupByTrack,
                                  ),
                                  onTap: () => Navigator.pop(context, 'track'),
                                ),
                                ListTile(
                                  title: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.groupByCategory,
                                  ),
                                  onTap: () =>
                                      Navigator.pop(context, 'category'),
                                ),
                              ],
                            ),
                          );
                        },
                      );

                      if (selectedMethod != null) {
                        ref
                            .read(groupingMethodProvider.notifier)
                            .set(selectedMethod);
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 5),
              Divider(height: 1),
              if (groupingMethod != 'time' && groupingTabs.isNotEmpty)
                Expanded(
                  child: DefaultTabController(
                    length: groupingTabs.length,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          tabs: groupingTabs
                              .map((tab) => Tab(text: tab))
                              .toList(),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: groupingTabs.map((tab) {
                              final sessionsForTab =
                                  groupedSessions[effectiveSelectedDate]
                                      ?.where(
                                        (s) =>
                                            (groupingMethod == 'track' &&
                                                s.track == tab) ||
                                            (groupingMethod == 'category' &&
                                                s.category == tab),
                                      )
                                      .toList() ??
                                  [];

                              return ListView(
                                children: sessionsForTab
                                    .map(
                                      (s) => SessionTile(
                                        session: s,
                                        onTapWidgetBuilder: (_) =>
                                            _destinationForSession(s),
                                      ),
                                    )
                                    .toList(),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (groupingMethod == 'time' || groupingTabs.isEmpty)
                Expanded(
                  child: ListView(
                    children:
                        groupedSessions[effectiveSelectedDate]
                            ?.map(
                              (s) => SessionTile(
                                session: s,
                                onTapWidgetBuilder: (_) =>
                                    _destinationForSession(s),
                              ),
                            )
                            .toList() ??
                        [],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _destinationForSession(SessionModel s) {
    final tag = s.categoryTag.trim().toUpperCase();
    final isMentorship = tag == 'MENTORSHIP';
    if (isMentorship) {
      return MentorshipTimeSlotsPage(session: s);
    }
    return SessionDetailsPage(session: s);
  }
}
