import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/utilities/logger.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/agenda/presentation/agenda_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:event_app/features/chat/presentation/chat_providers.dart';
import 'package:event_app/core/utilities/scheduling.dart';
import 'package:event_app/features/chat/presentation/chat_page.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/quick_polls/presentation/quick_polls_panel.dart';
import 'package:event_app/features/speakers/presentation/speaker_details_page.dart';
import 'package:event_app/features/speakers/presentation/speaker_providers.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_feedback.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_info_card.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_reminder_chip.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_sponsors_partners_sections.dart';
import 'package:event_app/core/widgets/moderator_badge.dart';

class SessionDetailsPage extends ConsumerWidget {
  const SessionDetailsPage({super.key, required this.session});

  final SessionModel session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRegisteredNow = ref.watch(
      sessionRegistrationStateProvider(session),
    );

    deferAfterBuild(() {
      ref
          .read(sessionChatMembershipProvider(session.id).notifier)
          .initialize(session.isChatMember);
    });

    return AppScaffold(
      title: session.name ?? '',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SessionInfoCard(session: session),
            const SizedBox(height: AppSpacing.section),
            _buildRegistrationButton(context, ref, isRegisteredNow),
            _quickPollsCTA(context, isRegisteredNow),
            const SizedBox(height: AppSpacing.section),
            SessionReminderChip(sessionId: session.id),
            const SizedBox(height: AppSpacing.section),
            _buildChatActions(context, ref, isRegisteredNow),
            const SizedBox(height: AppSpacing.section),
            const SizedBox(height: AppSpacing.section),
            if (session.speakers.isNotEmpty)
              _buildSection(
                context,
                title: AppLocalizations.of(context)!.sessionSpeakers,
                child: _buildPersonList(context, ref, session.speakers),
              ),
            const SizedBox(height: AppSpacing.section),
            if (session.sponsors.isNotEmpty)
              SessionSponsorsSection(sponsors: session.sponsors),
            const SizedBox(height: AppSpacing.section),
            if (session.partners.isNotEmpty)
              SessionPartnersSection(partners: session.partners),
            const SizedBox(height: AppSpacing.section),
            if (session.materials.isNotEmpty)
              _buildSection(
                context,
                title: AppLocalizations.of(context)!.materials,
                child: _buildMaterialsList(context, ref, session.materials),
              ),
          ],
        ),
      ),
    );
  }

  String _normalizeKey(String input) {
    return input.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  T? _firstWhereOrNull<T>(Iterable<T> items, bool Function(T item) test) {
    for (final item in items) {
      if (test(item)) return item;
    }
    return null;
  }

  Future<void> _openSpeakerDetails(
    BuildContext context,
    WidgetRef ref,
    Person person,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    int? speakerId = person.id;
    if (speakerId == null) {
      try {
        final speakers = await ref.read(speakersListProvider.future);
        final targetName = _normalizeKey(
          '${person.firstName} ${person.lastName}',
        );
        final match =
            _firstWhereOrNull(
              speakers,
              (s) =>
                  _normalizeKey('${s.firstName} ${s.lastName}') == targetName,
            ) ??
            _firstWhereOrNull(
              speakers,
              (s) =>
                  _normalizeKey(s.firstName) == _normalizeKey(person.firstName),
            );
        speakerId = match?.id;
      } catch (_) {
        speakerId = null;
      }
    }

    if (speakerId == null) {
      AppNotifier.error(context, l10n.actionFailed);
      return;
    }

    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SpeakerDetailsPage(speakerId: speakerId!),
      ),
    );
  }

  Widget _buildChatActions(
    BuildContext context,
    WidgetRef ref,
    bool isRegisteredNow,
  ) {
    if (!isRegisteredNow) return const SizedBox.shrink();
    final joined = ref.watch(sessionChatMembershipProvider(session.id));
    final l10n = AppLocalizations.of(context)!;

    if (joined) {
      return SizedBox(
        width: double.infinity,
        child: AppElevatedButton(
          icon: const Icon(Icons.chat_bubble_outline),
          label: Text(l10n.openChat),
          onPressed: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatPage(sessionId: session.id),
              ),
            );
          },
          style: AppDecorations.primaryButton(context),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: AppElevatedButton(
          icon: const Icon(Icons.group_add_outlined),
          label: Text(l10n.joinChat),
          onPressed: () async {
            final navigator = Navigator.of(context);
            try {
              final svc = ref.read(chatRealtimeServiceProvider);
              await svc.start();
              await svc.joinSession(session.id);
              ref
                  .read(sessionChatMembershipProvider(session.id).notifier)
                  .set(true);
              if (!context.mounted) return;
              AppNotifier.success(context, l10n.chatJoined);
              // Auto-open chat after successful join to give immediate feedback
              navigator.push(
                MaterialPageRoute(
                  builder: (_) => ChatPage(sessionId: session.id),
                ),
              );
            } catch (e, st) {
              logError('Join chat failed', e, st);
              AppNotifier.error(context, l10n.actionFailed);
            }
          },
          style: AppDecorations.primaryButton(context),
        ),
      );
    }
  }

  Widget _buildRegistrationButton(
    BuildContext context,
    WidgetRef ref,
    bool isRegisteredNow,
  ) {
    final capacityReached = session.isMaxCapacityReached;
    final shouldDisableRegister = capacityReached && !isRegisteredNow;
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: AppElevatedButton(
              label: Text(
                isRegisteredNow
                    ? AppLocalizations.of(context)!.unregister
                    : shouldDisableRegister
                    ? AppLocalizations.of(context)!.maxCapacityReached
                    : AppLocalizations.of(context)!.addToAgenda,
              ),
              icon: Icon(
                isRegisteredNow
                    ? Icons.remove_circle_outline
                    : shouldDisableRegister
                    ? Icons.block
                    : Icons.check_circle_outline,
              ),
              onPressed: shouldDisableRegister
                  ? null
                  : () async {
                      final l10n = AppLocalizations.of(context)!;
                      final addedText = l10n.addedSuccess;
                      final removedText = l10n.removedSuccess;
                      final failedText = l10n.actionFailed;
                      try {
                        if (isRegisteredNow) {
                          await ref
                              .read(sessionRepositoryProvider)
                              .cancelSessionRegistration(session.id);
                          // Ensure chat membership resets when unregistering
                          ref
                              .read(
                                sessionChatMembershipProvider(
                                  session.id,
                                ).notifier,
                              )
                              .set(false);
                        } else {
                          await ref
                              .read(sessionRepositoryProvider)
                              .registerSession(session.id);
                        }
                        Future.microtask(() {
                          ref
                              .read(
                                sessionRegistrationStateProvider(
                                  session,
                                ).notifier,
                              )
                              .set(!isRegisteredNow);
                        });
                        if (!context.mounted) return;
                        AppNotifier.success(
                          context,
                          isRegisteredNow ? removedText : addedText,
                        );
                      } catch (e) {
                        final raw = e is String ? e : e.toString();
                        final cleaned = raw.replaceFirst(
                          RegExp(r'^Exception:\s*'),
                          '',
                        );
                        final message = cleaned.trim();
                        AppNotifier.error(
                          context,
                          message.isNotEmpty ? message : failedText,
                        );
                      }
                    },
              style: isRegisteredNow
                  ? ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    )
                  : shouldDisableRegister
                  ? ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).disabledColor,
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    )
                  : AppDecorations.primaryButton(context),
            ),
          ),
          const SizedBox(width: AppSpacing.item),
          Expanded(child: SessionFeedbackButton(sessionId: session.id)),
        ],
      ),
    );
  }

  // ---------------- UI Components -------------------

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headlineMedium),
        const SizedBox(height: AppSpacing.item),
        child,
      ],
    );
  }

  Widget _buildPersonList(
    BuildContext context,
    WidgetRef ref,
    List<Person> people,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: people.map((person) {
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.item),
          decoration: AppDecorations.cardContainer(context),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: person.profileImageUrl.isNotEmpty
                  ? NetworkImage(person.profileImageUrl)
                  : null,
              child: person.profileImageUrl.isEmpty
                  ? const Icon(Icons.person_outline)
                  : null,
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    '${person.firstName} ${person.lastName}',
                    style: AppTextStyles.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (person.isModerator) ...[
                  const SizedBox(width: 6),
                  Semantics(
                    label: l10n.moderator,
                    child: const ModeratorBadge(),
                  ),
                ],
              ],
            ),
            subtitle: Text(person.title, style: AppTextStyles.bodySmall),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              await _openSpeakerDetails(context, ref, person);
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLogoList(
    BuildContext context,
    List<dynamic> items, {
    required Future<void> Function(dynamic item) onTapItem,
  }) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.section),
        itemBuilder: (_, index) {
          final item = items[index];
          return InkWell(
            onTap: () async => onTapItem(item),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 85,
              padding: const EdgeInsets.all(AppSpacing.small),
              decoration: AppDecorations.cardContainer(context),
              child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      item.logoUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.business_outlined, size: 32),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.small),
                  Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMaterialsList(
    BuildContext context,
    WidgetRef ref,
    List<SessionMaterial> materials,
  ) {
    return Column(
      children: materials.map((m) {
        final icon = _iconForUrl(m.url);
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.item),
          decoration: AppDecorations.cardContainer(context),
          child: ListTile(
            leading: Icon(icon),
            title: Text(m.name, style: AppTextStyles.bodyMedium),

            trailing: AppIconButton(
              icon: const Icon(Icons.download_outlined),
              onPressed: () async {
                await _downloadMaterial(context, ref, m);
              },
            ),
            onTap: () async {
              final uri = Uri.parse(m.url);
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
          ),
        );
      }).toList(),
    );
  }

  IconData _iconForUrl(String url) {
    final lower = url.toLowerCase();
    if (lower.endsWith('.pdf')) return Icons.picture_as_pdf_outlined;
    if (lower.endsWith('.zip') || lower.endsWith('.rar'))
      return Icons.archive_outlined;
    if (lower.endsWith('.ppt') || lower.endsWith('.pptx'))
      return Icons.slideshow_outlined;
    if (lower.endsWith('.doc') || lower.endsWith('.docx'))
      return Icons.description_outlined;
    if (lower.endsWith('.xls') || lower.endsWith('.xlsx'))
      return Icons.table_chart_outlined;
    return Icons.link_outlined;
  }

  Future<void> _downloadMaterial(
    BuildContext context,
    WidgetRef ref,
    SessionMaterial material,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final dio = ref.read(apiClientProvider).client;
      final response = await dio.get<List<int>>(
        material.url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
      );

      final fileName = _safeFileName(
        material.name,
        material.url,
        typeHint: material.type,
        contentType: response.headers.value('content-type'),
      );

      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) {
        throw StateError(l10n.downloadedEmptyResponse);
      }

      // iOS/Android: stay permissionless by writing to a temp file and letting the
      // OS "Save As" dialog handle saving (Files/Downloads/etc.).
      if (Platform.isAndroid || Platform.isIOS) {
        final dir = await getTemporaryDirectory();
        final savePath = '${dir.path}/$fileName';
        final file = File(savePath);
        await file.writeAsBytes(bytes, flush: true);
        if (!context.mounted) return;

        final params = SaveFileDialogParams(
          sourceFilePath: file.path,
          fileName: fileName,
        );
        try {
          final savedPath = await FlutterFileDialog.saveFile(params: params);
          if (savedPath != null && savedPath.trim().isNotEmpty) {
            if (!context.mounted) return;
            AppNotifier.success(context, l10n.savedToFile(fileName));
          }
        } on MissingPluginException {
          if (!context.mounted) return;
          AppNotifier.error(context, l10n.saveDialogUnavailableRestart);
        }
        return;
      }

      // Desktop: save directly to Downloads when available.
      final Directory dir =
          await getDownloadsDirectory() ??
          await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/$fileName';
      final file = File(savePath);
      await file.writeAsBytes(bytes, flush: true);
      if (!context.mounted) return;
      AppNotifier.success(context, l10n.savedToFile(fileName));
    } catch (e) {
      AppNotifier.error(context, l10n.actionFailed);
    }
  }

  String _safeFileName(
    String name,
    String url, {
    String? typeHint,
    String? contentType,
  }) {
    final uri = Uri.parse(url);
    final urlName = uri.pathSegments.isNotEmpty
        ? uri.pathSegments.last
        : 'file';

    final raw = (name.isNotEmpty ? name : urlName);
    final safeBase = raw.replaceAll(RegExp(r'[^A-Za-z0-9._-]'), '_');

    String fileName = safeBase.isEmpty ? 'file' : safeBase;
    if (_hasFileExtension(fileName)) return fileName;

    final ext = _inferExtension(
      urlName: urlName,
      typeHint: typeHint,
      contentType: contentType,
    );
    if (ext == null) return fileName;
    return '$fileName.$ext';
  }

  bool _hasFileExtension(String fileName) {
    final dot = fileName.lastIndexOf('.');
    if (dot <= 0 || dot == fileName.length - 1) return false;
    final ext = fileName.substring(dot + 1);
    // Avoid treating trailing dots or very long "extensions" as valid.
    return ext.length >= 2 && ext.length <= 8;
  }

  String? _inferExtension({
    required String urlName,
    String? typeHint,
    String? contentType,
  }) {
    // 1) From URL path segment
    final dot = urlName.lastIndexOf('.');
    if (dot > 0 && dot < urlName.length - 1) {
      final ext = urlName.substring(dot + 1).toLowerCase();
      if (ext.length >= 2 && ext.length <= 8) return ext;
    }

    // 2) From backend material.type (often "pdf", "pptx"...) if present
    final t = typeHint?.trim().toLowerCase();
    if (t != null && t.isNotEmpty) {
      final normalized = t.startsWith('.') ? t.substring(1) : t;
      if (RegExp(r'^[a-z0-9]{2,8}$').hasMatch(normalized)) return normalized;
    }

    // 3) From HTTP content-type
    final ct = contentType?.toLowerCase();
    if (ct == null || ct.isEmpty) return null;
    if (ct.contains('pdf')) return 'pdf';
    if (ct.contains('zip')) return 'zip';
    if (ct.contains('msword')) return 'doc';
    if (ct.contains('wordprocessingml')) return 'docx';
    if (ct.contains('spreadsheetml')) return 'xlsx';
    if (ct.contains('presentationml')) return 'pptx';
    if (ct.contains('text/plain')) return 'txt';
    if (ct.contains('text/html')) return 'html';
    if (ct.contains('image/png')) return 'png';
    if (ct.contains('image/jpeg')) return 'jpg';
    return null;
  }

  void _showQuickPollsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.page),
            child: QuickPollsPanel(sessionId: session.id),
          ),
        );
      },
    );
  }

  // Full-width Quick Polls CTA below the row for better tap target
  Widget _quickPollsCTA(BuildContext context, bool isRegisteredNow) {
    if (!(isRegisteredNow && session.hasQuickPolls))
      return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.item),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          icon: const Icon(Icons.poll_outlined),
          label: Text(AppLocalizations.of(context)!.quickPolls),
          onPressed: () {
            _showQuickPollsModal(context);
          },
        ),
      ),
    );
  }
}
