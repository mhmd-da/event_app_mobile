import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:event_app/features/quick_polls/presentation/quick_polls_providers.dart';
import 'package:event_app/features/quick_polls/domain/quick_poll_models.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/core/widgets/app_brand_waves.dart';

class QuickPollsPanel extends ConsumerStatefulWidget {
  const QuickPollsPanel({super.key, required this.sessionId});
  final int sessionId;

  @override
  ConsumerState<QuickPollsPanel> createState() => _QuickPollsPanelState();
}

class _QuickPollsPanelState extends ConsumerState<QuickPollsPanel> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pollsAsync = ref.watch(
      quickPollsForSessionProvider(widget.sessionId),
    );
    final state = ref.watch(quickPollControllerProvider(widget.sessionId));
    final controller = ref.read(
      quickPollControllerProvider(widget.sessionId).notifier,
    );

    return pollsAsync.when(
      loading: () =>
          _withHeader(context, const SizedBox.shrink(), l10n.quickPolls),
      error: (err, _) =>
          _withHeader(context, const SizedBox.shrink(), l10n.quickPolls),
      data: (polls) {
        if (polls.isEmpty) {
          return _withHeader(
            context,
            _section(
              context,
              title: '',
              child: Container(
                width: double.infinity,
                decoration: AppDecorations.cardContainer(context),
                padding: const EdgeInsets.all(AppSpacing.section),
                child: Text(l10n.noQuickPolls, style: AppTextStyles.bodyMedium),
              ),
            ),
            l10n.quickPolls,
          );
        }

        final idx = state.currentIndex.clamp(0, polls.length - 1);
        final poll = polls[idx];
        final now = DateTime.now();
        final startsAt = poll.startsAt;
        final endsAt = poll.endsAt;
        final isOpen =
            (startsAt == null || now.isAfter(startsAt)) &&
            (endsAt == null || now.isBefore(endsAt));
        final hasInlineResults = poll.options.any((o) => o.votes != null);
        final results =
            state.resultsByPollId[poll.id] ??
            (poll.userVoted || hasInlineResults
                ? _resultsFromPoll(poll)
                : null);

        return _withHeader(
          context,
          _section(
            context,
            title: '',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: AppDecorations.cardContainer(context),
                  padding: const EdgeInsets.all(AppSpacing.section),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              poll.question,
                              style: AppTextStyles.headlineSmall,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isOpen
                                      ? Theme.of(context).colorScheme.primary
                                            .withValues(alpha: 0.12)
                                      : Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant
                                            .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  isOpen
                                      ? l10n.vote
                                      : _pollOpenStatusText(
                                          context,
                                          poll,
                                          l10n,
                                        ),
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: isOpen
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (poll.endsAt != null)
                                Text(
                                  l10n.openUntilTime(
                                    AppTimeFormatting.ltrIsolate(
                                      AppTimeFormatting.formatTimeHm(
                                        context,
                                        poll.endsAt!,
                                      ),
                                    ),
                                  ),
                                  style: AppTextStyles.bodySmall,
                                ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.pollIndexOfTotal(idx + 1, polls.length),
                                style: AppTextStyles.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.item),
                      if (results == null)
                        _buildOptions(
                          context,
                          poll,
                          state,
                          controller,
                          l10n,
                          isOpen,
                        )
                      else
                        _buildResults(context, results, l10n, poll),
                      const SizedBox(height: AppSpacing.item),
                      Row(
                        children: [
                          Expanded(
                            child: AppOutlinedButton(
                              icon: const Icon(Icons.chevron_left),
                              label: Text(l10n.previous),
                              onPressed: idx > 0
                                  ? () => controller.setIndex(idx - 1)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.item),
                          Expanded(
                            child: AppOutlinedButton(
                              icon: const Icon(Icons.chevron_right),
                              label: Text(l10n.next),
                              onPressed: idx < polls.length - 1
                                  ? () => controller.setIndex(idx + 1)
                                  : null,
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
          l10n.quickPolls,
        );
      },
    );
  }

  Widget _section(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Text(title, style: AppTextStyles.headlineMedium),
          const SizedBox(height: AppSpacing.item),
        ],
        child,
      ],
    );
  }

  Widget _buildOptions(
    BuildContext context,
    QuickPollModel poll,
    QuickPollState state,
    QuickPollController controller,
    AppLocalizations l10n,
    bool isOpen,
  ) {
    final selected = state.selectedOptionByPollId[poll.id];
    return Column(
      children: [
        for (final opt in poll.options)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: AppDecorations.cardContainer(context),
            child: RadioListTile<int>(
              value: opt.id,
              groupValue: selected,
              onChanged: isOpen
                  ? (v) => controller.selectOption(poll.id, v!)
                  : null,
              title: Text(opt.text, style: AppTextStyles.bodyMedium),
            ),
          ),
        if (!isOpen)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _pollOpenStatusText(context, poll, l10n),
                style: AppTextStyles.bodySmall,
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.item),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: AppElevatedButton(
            onPressed: (!isOpen || selected == null)
                ? null
                : () async {
                    await controller.submitVote(poll.id);
                  },
            child: Text(l10n.vote),
          ),
        ),
      ],
    );
  }

  Widget _buildResults(
    BuildContext context,
    QuickPollResultsModel results,
    AppLocalizations l10n,
    QuickPollModel poll,
  ) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.results,
              style: AppTextStyles.bodyMedium.copyWith(color: colors.primary),
            ),
            if (poll.userVoted)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: colors.primary, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      l10n.youVoted,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colors.primary,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.item),
        for (final opt in results.options)
          _resultBar(context, poll, opt, results.totalVotes),
        const SizedBox(height: AppSpacing.small),
        Text(
          l10n.totalVotes(results.totalVotes),
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }

  Widget _resultBar(
    BuildContext context,
    QuickPollModel poll,
    QuickPollResultOption opt,
    int totalVotes,
  ) {
    final percent = totalVotes == 0 ? 0.0 : (opt.votes / totalVotes);
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: AppDecorations.cardContainer(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(opt.text, style: AppTextStyles.bodyMedium)),
              Text(
                '${(percent * 100).toStringAsFixed(0)}%',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              color: colors.primary,
              backgroundColor: colors.primary.withValues(alpha: 0.15),
            ),
          ),
        ],
      ),
    );
  }

  QuickPollResultsModel _resultsFromPoll(QuickPollModel poll) {
    final opts = poll.options
        .map(
          (o) => QuickPollResultOption(
            id: o.id,
            text: o.text,
            votes: o.votes ?? 0,
          ),
        )
        .toList();
    final total = opts.fold<int>(0, (sum, o) => sum + o.votes);
    return QuickPollResultsModel(
      pollId: poll.id,
      options: opts,
      totalVotes: total,
    );
  }

  Widget _withHeader(BuildContext context, Widget body, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppHeaderWave(
          height: 160,
          overlay: Builder(
            builder: (context) {
              final topInset = MediaQuery.of(context).padding.top;
              return Padding(
                padding: EdgeInsets.only(top: topInset + 12),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    title,
                    style: AppTextStyles.headlineLarge.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.section),
        body,
      ],
    );
  }
}

String _pollOpenStatusText(
  BuildContext context,
  QuickPollModel poll,
  AppLocalizations l10n,
) {
  final now = DateTime.now();
  if (poll.startsAt != null && now.isBefore(poll.startsAt!)) {
    return l10n.pollNotOpenYet;
  }
  if (poll.endsAt != null && now.isAfter(poll.endsAt!)) {
    return l10n.pollClosed;
  }
  return '';
}
