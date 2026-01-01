import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/agenda/presentation/agenda_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionFeedbackButton extends ConsumerWidget {
  final int sessionId;

  const SessionFeedbackButton({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppOutlinedButton(
      icon: const Icon(Icons.feedback_outlined),
      label: Text(AppLocalizations.of(context)!.giveFeedback),
      onPressed: () => _showFeedbackSheet(context),
    );
  }

  void _showFeedbackSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SessionFeedbackSheet(sessionId: sessionId),
    );
  }
}

class SessionFeedbackSheet extends ConsumerStatefulWidget {
  final int sessionId;

  const SessionFeedbackSheet({super.key, required this.sessionId});

  @override
  ConsumerState<SessionFeedbackSheet> createState() =>
      _SessionFeedbackSheetState();
}

class _SessionFeedbackSheetState extends ConsumerState<SessionFeedbackSheet> {
  int rating = 0;
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

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
              return AppIconButton(
                icon: Icon(
                  filled ? Icons.star : Icons.star_border,
                  color: filled ? colors.primary : colors.onSurfaceVariant,
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
            child: AppElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
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
                  await ref
                      .read(sessionRepositoryProvider)
                      .submitFeedback(
                        widget.sessionId,
                        rating,
                        commentController.text,
                      );
                  if (!mounted) return;
                  navigator.pop();
                  AppNotifier.success(context, l10n.feedbackSubmittedThankYou);
                } catch (_) {
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
