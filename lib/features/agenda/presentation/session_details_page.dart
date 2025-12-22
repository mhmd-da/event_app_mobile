import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/utilities/logger.dart';
import 'package:event_app/core/widgets/app_scaffold.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/agenda/presentation/agenda_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:event_app/features/chat/presentation/chat_providers.dart';
import 'package:event_app/core/utilities/scheduling.dart';
import 'package:event_app/features/chat/presentation/chat_page.dart';
import 'package:event_app/core/widgets/notifier.dart';

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
            _buildSessionCard(context),
            const SizedBox(height: AppSpacing.section),
            _buildRegistrationButton(context, ref, isRegisteredNow),
            const SizedBox(height: AppSpacing.section),
            _buildReminderChip(context, ref),
            const SizedBox(height: AppSpacing.section),
            _buildChatActions(context, ref, isRegisteredNow),
            const SizedBox(height: AppSpacing.section),
            if (session.speakers.isNotEmpty)
              _buildSection(
                context,
                title: AppLocalizations.of(context)!.sessionSpeakers,
                child: _buildPersonList(context, session.speakers),
              ),
            const SizedBox(height: AppSpacing.section),
            if (session.sponsors.isNotEmpty)
              _buildSection(
                context,
                title: AppLocalizations.of(context)!.poweredBy,
                child: _buildLogoList(context, session.sponsors),
              ),
            const SizedBox(height: AppSpacing.section),
            if (session.partners.isNotEmpty)
              _buildSection(
                context,
                title: AppLocalizations.of(context)!.partners,
                child: _buildLogoList(context, session.partners),
              ),
            const SizedBox(height: AppSpacing.section),
            if (session.materials.isNotEmpty)
              _buildSection(
                context,
                title: AppLocalizations.of(context)!.materials,
                child: _buildMaterialsList(context, session.materials),
              ),
          ],
        ),
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
        child: ElevatedButton.icon(
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
        child: ElevatedButton.icon(
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
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              label: Text(
                isRegisteredNow
                    ? AppLocalizations.of(context)!.unregister
                    : AppLocalizations.of(context)!.addToAgenda,
              ),
              icon: Icon(
                isRegisteredNow
                    ? Icons.remove_circle_outline
                    : Icons.check_circle_outline,
              ),
              onPressed: () async {
                final addedText = AppLocalizations.of(context)!.addedSuccess;
                final removedText = AppLocalizations.of(
                  context,
                )!.removedSuccess;
                final failedText = AppLocalizations.of(context)!.actionFailed;
                try {
                  if (isRegisteredNow) {
                    await ref
                        .read(sessionRepositoryProvider)
                        .cancelSessionRegistration(session.id);
                    // Ensure chat membership resets when unregistering
                    ref
                        .read(
                          sessionChatMembershipProvider(session.id).notifier,
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
                          sessionRegistrationStateProvider(session).notifier,
                        )
                        .set(!isRegisteredNow);
                  });
                  if (!context.mounted) return;
                  AppNotifier.success(
                    context,
                    isRegisteredNow ? removedText : addedText,
                  );
                } catch (e) {
                  AppNotifier.error(context, failedText);
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
                  : AppDecorations.primaryButton(context),
            ),
          ),
          const SizedBox(width: AppSpacing.item),
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.feedback_outlined),
              label: Text(AppLocalizations.of(context)!.giveFeedback),
              onPressed: () {
                _showFeedbackSheet(context, ref);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- UI Components -------------------

  Widget _buildSessionCard(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: AppDecorations.cardContainer(context),
      padding: const EdgeInsets.all(AppSpacing.section),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(session.name ?? '', style: AppTextStyles.headlineLarge),

          const SizedBox(height: AppSpacing.small),

          // Description
          Text(session.description, style: AppTextStyles.bodyMedium),

          const SizedBox(height: AppSpacing.small),

          // Time
          Text(
            '${DateFormat.jm().format(session.startTime.toLocal())} - ${DateFormat.jm().format(session.endTime.toLocal())}',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: AppSpacing.small),

          // Location
          if (session.location.isNotEmpty)
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.small),
                Expanded(
                  child: Text(session.location, style: AppTextStyles.bodySmall),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildReminderChip(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(sessionReminderEnabledProvider(session.id));
    final lead = ref.watch(sessionReminderLeadMinutesProvider(session.id));
    final saving = ref.watch(sessionReminderSavingProvider(session.id));

    String label;
    if (enabled && lead != null) {
      label = _labelForLeadMinutes(context, lead);
    } else {
      label = AppLocalizations.of(context)!.noReminderSet;
    }
    return Container(
      width: double.infinity,
      decoration: AppDecorations.chipContainer(context),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.item,
        vertical: AppSpacing.small,
      ),
      child: Row(
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.item),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: saving ? null : () => _showReminderPicker(context, ref),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '${AppLocalizations.of(context)!.reminder}: $label',
                      style: AppTextStyles.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  saving
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(
                          Icons.arrow_drop_down,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showReminderPicker(BuildContext context, WidgetRef ref) async {
    final options = const [5, 10, 15, 30, 60, 1440];

    final l10n = AppLocalizations.of(context)!;

    final selected = await showModalBottomSheet<int>(
      context: context,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSpacing.item),
              Text(
                AppLocalizations.of(context)!.alertMeBefore,
                style: AppTextStyles.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.item),
              for (final m in options)
                ListTile(
                  title: Text(_optionLabel(context, m)),
                  onTap: () => Navigator.pop(ctx, m),
                ),
              const SizedBox(height: AppSpacing.item),
              ListTile(
                leading: const Icon(Icons.notifications_off_outlined),
                title: Text(AppLocalizations.of(context)!.disableReminder),
                onTap: () => Navigator.pop(ctx, -1),
              ),
            ],
          ),
        );
      },
    );

    if (selected == null) return;

    ref.read(sessionReminderSavingProvider(session.id).notifier).set(true);
    try {
      if (selected == -1) {
        final ok = await ref
            .read(sessionRepositoryProvider)
            .deleteReminder(session.id);
        if (ok) {
          ref
              .read(sessionReminderEnabledProvider(session.id).notifier)
              .set(false);
          ref
              .read(sessionReminderLeadMinutesProvider(session.id).notifier)
              .set(null);
          if (!context.mounted) return;
          AppNotifier.info(context, l10n.disableReminder);
        }
      } else {
        final ok = await ref
            .read(sessionRepositoryProvider)
            .setReminder(session.id, selected, true);
        if (ok) {
          ref
              .read(sessionReminderEnabledProvider(session.id).notifier)
              .set(true);
          ref
              .read(sessionReminderLeadMinutesProvider(session.id).notifier)
              .set(selected);
          final selectedLabel = _labelForLeadMinutesL10n(l10n, selected);
          if (!context.mounted) return;
          AppNotifier.info(context, '${l10n.reminder}: $selectedLabel');
        }
      }
    } catch (_) {
      AppNotifier.error(context, 'Failed to update reminder');
    } finally {
      ref.read(sessionReminderSavingProvider(session.id).notifier).set(false);
    }
  }

  String _labelForLeadMinutes(BuildContext context, int lead) {
    switch (lead) {
      case 5:
        return AppLocalizations.of(context)!.minutesBefore(5);
      case 10:
        return AppLocalizations.of(context)!.minutesBefore(10);
      case 15:
        return AppLocalizations.of(context)!.minutesBefore(15);
      case 30:
        return AppLocalizations.of(context)!.minutesBefore(30);
      case 60:
        return AppLocalizations.of(context)!.minutesBefore(60);
      case 1440:
        return AppLocalizations.of(context)!.minutesBefore(1440);
      default:
        return AppLocalizations.of(context)!.minutesBefore(lead);
    }
  }

  String _labelForLeadMinutesL10n(AppLocalizations l10n, int lead) {
    switch (lead) {
      case 5:
        return l10n.minutesBefore(5);
      case 10:
        return l10n.minutesBefore(10);
      case 15:
        return l10n.minutesBefore(15);
      case 30:
        return l10n.minutesBefore(30);
      case 60:
        return l10n.minutesBefore(60);
      case 1440:
        return l10n.minutesBefore(1440);
      default:
        return l10n.minutesBefore(lead);
    }
  }

  String _optionLabel(BuildContext context, int lead) {
    final reminderPrefix = '${AppLocalizations.of(context)!.reminder}: ';
    return _labelForLeadMinutes(context, lead).replaceAll(reminderPrefix, '');
  }

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

  Widget _buildPersonList(BuildContext context, List<Person> people) {
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
            title: Text(
              '${person.firstName} ${person.lastName}',
              style: AppTextStyles.bodyMedium,
            ),
            subtitle: Text(person.title, style: AppTextStyles.bodySmall),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SpeakerDetailsPage(person),
              //   ),
              // );
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLogoList(BuildContext context, List<dynamic> items) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.section),
        itemBuilder: (_, index) {
          final item = items[index];
          return Container(
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
          );
        },
      ),
    );
  }

  Widget _buildMaterialsList(
    BuildContext context,
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
            subtitle: Text(
              m.url,
              style: AppTextStyles.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.download_outlined),
              onPressed: () async {
                await _downloadMaterial(context, m);
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
    SessionMaterial material,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName = _safeFileName(material.name, material.url);
      final savePath = '${dir.path}/$fileName';

      final dio = Dio();
      final response = await dio.get<List<int>>(
        material.url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
      );

      final file = File(savePath);
      await file.writeAsBytes(response.data ?? [], flush: true);
      if (!context.mounted) return;
      AppNotifier.success(context, 'Saved to $fileName');
    } catch (e) {
      AppNotifier.error(context, l10n.actionFailed);
    }
  }

  String _safeFileName(String name, String url) {
    final uri = Uri.parse(url);
    final urlName = uri.pathSegments.isNotEmpty
        ? uri.pathSegments.last
        : 'file';
    final base = (name.isNotEmpty ? name : urlName).replaceAll(
      RegExp(r'[^A-Za-z0-9._-]'),
      '_',
    );
    return base.isEmpty ? 'file' : base;
  }

  void _showFeedbackSheet(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return _FeedbackSheet(sessionId: session.id, ref: ref, colors: colors);
      },
    );
  }
}

class _FeedbackSheet extends StatefulWidget {
  const _FeedbackSheet({
    required this.sessionId,
    required this.ref,
    required this.colors,
  });
  final int sessionId;
  final WidgetRef ref;
  final ColorScheme colors;

  @override
  State<_FeedbackSheet> createState() => _FeedbackSheetState();
}

class _FeedbackSheetState extends State<_FeedbackSheet> {
  int rating = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.sessionFeedbackTitle,
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.item),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final filled = i < rating;
              return IconButton(
                icon: Icon(
                  filled ? Icons.star : Icons.star_border,
                  color: filled
                      ? widget.colors.primary
                      : widget.colors.onSurfaceVariant,
                ),
                onPressed: () => setState(() => rating = i + 1),
              );
            }),
          ),
          TextField(
            controller: commentController,
            minLines: 3,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.feedbackHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: AppSpacing.item),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.colors.primary,
                foregroundColor: widget.colors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                final navigator = Navigator.of(context);
                final l10n = AppLocalizations.of(context)!;
                if (rating == 0) {
                  AppNotifier.info(context, l10n.pleaseSelectRating);
                  return;
                }
                try {
                  await widget.ref
                      .read(sessionRepositoryProvider)
                      .submitFeedback(
                        widget.sessionId,
                        rating,
                        commentController.text,
                      );
                  if (!mounted) return;
                  navigator.pop();
                  AppNotifier.success(
                    context,
                    'Feedback submitted. Thank you!',
                  );
                } catch (e) {
                  AppNotifier.error(context, l10n.actionFailed);
                }
              },
              child: Text(AppLocalizations.of(context)!.submit),
            ),
          ),
        ],
      ),
    );
  }
}
