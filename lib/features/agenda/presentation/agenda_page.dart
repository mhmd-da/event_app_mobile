import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/agenda/presentation/agenda_providers.dart';
import 'package:event_app/features/agenda/presentation/session_details_page.dart';
import 'package:event_app/features/agenda/presentation/widgets/agenda_date_tabs.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_tile.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import '../../../core/theme/app_text_styles.dart';

class AgendaPage extends ConsumerWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionsForAgendaListProvider);
    final groupingMethod = ref.watch(groupingMethodProvider);
    final selectedDate = ref.watch(selectedAgendaDateProvider);

    return AppScaffold(
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
            (s) => DateFormat('EEE d').format(s.startTime.toLocal()),
          );
          final dateTabs = groupedSessions.keys.toList();
          final groupingTabs =
              groupedSessions[selectedDate]
                  ?.map(
                    (s) => groupingMethod == 'track'
                        ? s.track
                        : (groupingMethod == 'category'
                              ? s.category ?? ''
                              : ''),
                  )
                  .toSet()
                  .toList() ??
              [];


          return Column(
            children: [
              Row(
                children: [
                  DateTabs(dates: dateTabs, selectedDateProvider: selectedAgendaDateProvider),
                  const SizedBox(height: 10),
                  IconButton(
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
                        ref.read(groupingMethodProvider.notifier).state =
                            selectedMethod;
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
                                  groupedSessions[selectedDate]
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
                                    .map((s) => SessionTile(session: s, onTapWidgetBuilder: (_) => SessionDetailsPage(session: s)))
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
                        groupedSessions[selectedDate]
                            ?.map((s) => SessionTile(session: s, onTapWidgetBuilder: (_) => SessionDetailsPage(session: s)))
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
}
