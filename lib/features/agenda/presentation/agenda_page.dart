import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/config/app_config.dart';
import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/agenda/presentation/agenda_providers.dart';
import 'package:event_app/features/agenda/presentation/session_details_page.dart';
import 'package:event_app/features/agenda/presentation/widgets/agenda_date_tabs.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_tile.dart';
import 'package:event_app/features/mentorship/presentation/mentorship_time_slots_page.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:event_app/shared/providers/timezone_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class AgendaPage extends ConsumerWidget {
  const AgendaPage({super.key, this.category});

  final String? category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionsForAgendaListProvider(category));
    final groupingMethod = ref.watch(groupingMethodProvider);
    final selectedDate = ref.watch(selectedAgendaDateProvider);
    final timezonePreference = ref.watch(appTimezonePreferenceProvider);

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
            (s) => AppTimeFormatting.formatDayLabelEeeD(
              context,
              s.startTime,
              timezonePreference: timezonePreference,
            ),
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
                                // ListTile(
                                //   title: Text(
                                //     AppLocalizations.of(context)!.groupByTrack,
                                //   ),
                                //   onTap: () => Navigator.pop(context, 'track'),
                                // ),
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
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: AppElevatedButton(
                                            icon: const Icon(
                                              Icons.picture_as_pdf_outlined,
                                            ),
                                            label: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.agendaDownloadPdf,
                                            ),
                                            onPressed: () async {
                                              await _downloadAndOpenAgendaPdf(
                                                context,
                                                ref,
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: AppOutlinedButton(
                                            icon: const Icon(Icons.open_in_new),
                                            label: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.agendaRegisterWebsite,
                                            ),
                                            onPressed: () async {
                                              await _openSessionRegistrationWebsite(
                                                context,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(height: 1),
                                  ...sessionsForTab.map(
                                    (s) => SessionTile(
                                      session: s,
                                      onTapWidgetBuilder: (_) =>
                                          _destinationForSession(s),
                                    ),
                                  ),
                                ],
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppElevatedButton(
                                icon: const Icon(Icons.picture_as_pdf_outlined),
                                label: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.agendaDownloadPdf,
                                ),
                                onPressed: () async {
                                  await _downloadAndOpenAgendaPdf(context, ref);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AppOutlinedButton(
                                icon: const Icon(Icons.open_in_new),
                                label: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.agendaRegisterWebsite,
                                ),
                                onPressed: () async {
                                  await _openSessionRegistrationWebsite(
                                    context,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1),
                      ...?groupedSessions[effectiveSelectedDate]?.map(
                        (s) => SessionTile(
                          session: s,
                          onTapWidgetBuilder: (_) => _destinationForSession(s),
                        ),
                      ),
                    ],
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

  Future<void> _openSessionRegistrationWebsite(BuildContext context) async {
    final url = AppConfig.sessionRegistrationUrl.trim();
    if (url.isEmpty) {
      AppNotifier.bottomMessage(
        context,
        AppLocalizations.of(context)!.linkNotConfigured,
      );
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      AppNotifier.error(context, AppLocalizations.of(context)!.actionFailed);
      return;
    }

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      AppNotifier.error(context, AppLocalizations.of(context)!.actionFailed);
    }
  }

  Future<void> _downloadAndOpenAgendaPdf(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final url = AppConfig.agendaPdfUrl.trim();

    if (url.isEmpty) {
      AppNotifier.bottomMessage(context, l10n.linkNotConfigured);
      return;
    }

    try {
      final dio = ref.read(apiClientProvider).client;
      final response = await dio.get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
      );

      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) {
        throw StateError(l10n.downloadedEmptyResponse);
      }

      final fileName = 'agenda.pdf';

      if (Platform.isAndroid || Platform.isIOS) {
        final dir = await getTemporaryDirectory();
        final tempPath = '${dir.path}/$fileName';
        final file = File(tempPath);
        await file.writeAsBytes(bytes, flush: true);
        if (!context.mounted) return;

        try {
          final savedPath = await FlutterFileDialog.saveFile(
            params: SaveFileDialogParams(
              sourceFilePath: file.path,
              fileName: fileName,
            ),
          );
          if (savedPath != null && savedPath.trim().isNotEmpty) {
            await launchUrl(
              Uri.file(savedPath),
              mode: LaunchMode.externalApplication,
            );
          }
        } on MissingPluginException {
          await launchUrl(
            Uri.file(file.path),
            mode: LaunchMode.externalApplication,
          );
        }
        return;
      }

      final Directory dir =
          await getDownloadsDirectory() ??
          await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/$fileName';
      final file = File(savePath);
      await file.writeAsBytes(bytes, flush: true);
      if (!context.mounted) return;

      await launchUrl(
        Uri.file(file.path),
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      if (context.mounted) {
        AppNotifier.error(context, l10n.actionFailed);
      }
    }
  }
}
