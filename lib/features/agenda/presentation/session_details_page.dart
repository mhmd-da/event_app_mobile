import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/speakers/presentation/speaker_details_page.dart';
import 'package:event_app/features/speakers/presentation/speaker_providers.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_info_card.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_sponsors_partners_sections.dart';
import 'package:event_app/core/widgets/moderator_badge.dart';

class SessionDetailsPage extends ConsumerWidget {
  const SessionDetailsPage({super.key, required this.session});

  final SessionModel session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      title: session.name ?? '',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SessionInfoCard(session: session),
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

  bool _isStaleData(DateTime? sessionTimestamp, DateTime? cachedTimestamp) {
    // If either timestamp is null, consider data stale
    if (sessionTimestamp == null || cachedTimestamp == null) {
      return sessionTimestamp != cachedTimestamp;
    }
    // Compare timestamps - stale if they differ
    return !sessionTimestamp.isAtSameMomentAs(cachedTimestamp);
  }

  Future<void> _openSpeakerDetails(
    BuildContext context,
    WidgetRef ref,
    Person person,
  ) async {
    final l10n = AppLocalizations.of(context)!;

    int? speakerId = person.id;
    bool needsRefresh = false;
    
    try {
      final speakers = await ref.read(speakersListProvider.future);
      
      if (speakerId == null) {
        // Fallback: Try to match by name
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
        
        // Check timestamp for matched speaker
        if (match != null) {
          needsRefresh = _isStaleData(person.lastUpdatedDate, match.lastUpdatedDate);
        } else {
          // Speaker not found in cache - needs refresh
          needsRefresh = true;
        }
      } else {
        // ID is available - find speaker and compare timestamp
        final match = _firstWhereOrNull(speakers, (s) => s.id == speakerId);
        if (match == null) {
          // Speaker not found in cache - needs refresh
          needsRefresh = true;
        } else {
          needsRefresh = _isStaleData(person.lastUpdatedDate, match.lastUpdatedDate);
        }
      }
    } catch (_) {
      // Error fetching speakers - try to refresh
      needsRefresh = true;
    }

    if (speakerId == null) {
      AppNotifier.error(context, l10n.actionFailed);
      return;
    }

    // Invalidate provider if data is stale or missing
    if (needsRefresh) {
      ref.invalidate(speakersListProvider);
    }

    if (!context.mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SpeakerDetailsPage(speakerId: speakerId!),
      ),
    );
  }

  // ---------------- UI Components -------------------

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return AppCard(
      title: title,
      centerTitle: true,
      useGradient: true,
      margin: null,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
      ],
      )
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
                    '${person.title} ${person.firstName} ${person.lastName}',
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
            //subtitle: Text(person.title, style: AppTextStyles.bodySmall),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              await _openSpeakerDetails(context, ref, person);
            },
          ),
        );
      }).toList(),
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
}
