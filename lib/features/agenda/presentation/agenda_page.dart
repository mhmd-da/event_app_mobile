import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/agenda/presentation/agenda_providers.dart';
import 'package:event_app/features/agenda/presentation/widgets/session_tile.dart';
import 'package:flutter/material.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';

class AgendaPage extends ConsumerWidget {
  const AgendaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(sessionsForAgendaListProvider);

    return Scaffold(
      body: sessionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(AppLocalizations.of(context)!.somethingWentWrong, style: AppTextStyles.bodyMedium),
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
            (SessionModel s) =>
                DateFormat('EEE d').format(s.startTime.toLocal()),
          );

          final dates = groupedSessions.keys.toList()..sort();

          Future.microtask(() {
            if (ref.read(selectedAgendaDateProvider) == null ||
                ref.read(selectedAgendaDateProvider)!.isEmpty) {
              ref.read(selectedAgendaDateProvider.notifier).state = dates.first;
            }
          });

          final selectedDate =
              ref.watch(selectedAgendaDateProvider) ?? dates.first;

          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true, // ✅ makes it sticky
                delegate: _StickyHeaderDelegate(
                  child: buildDateTabs(context, ref, dates, selectedDate),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  groupedSessions[selectedDate]!
                      .map((s) => SessionTile(session: s))
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class AgendaDaySection extends StatelessWidget {
  const AgendaDaySection({
    super.key,
    required this.day,
    required this.sessions,
  });

  final String day;
  final List<SessionModel> sessions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppSpacing.item),
        Text(day, style: AppTextStyles.headlineLarge),
        const SizedBox(height: AppSpacing.section),
        ...sessions.map((s) => SessionTile(session: s)),
      ],
    );
  }
}



class AgendaBanner extends StatelessWidget {
  const AgendaBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.cardContainer(context).copyWith(
        borderRadius: BorderRadius.circular(0), // full‐width banner
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.section,
        vertical: AppSpacing.section,
      ),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.browseAllSessionsBanner,
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

Widget buildDateTabs(
  BuildContext ctx,
  WidgetRef ref,
  List<String> dates,
  String? selected,
) {
  return Container(
    height: 48,
    alignment: Alignment.center, // ✅ centers the whole list container
    decoration: BoxDecoration(color: Theme.of(ctx).scaffoldBackgroundColor),
    child: Center(
      // ✅ Forces centering in all screen sizes
      child: ListView.separated(
        shrinkWrap: true, // important to allow centering
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          final date = dates[i];
          final isActive = selected == date;

          return InkWell(
            onTap: () =>
                ref.read(selectedAgendaDateProvider.notifier).state = date,
            borderRadius: BorderRadius.circular(12),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 1),
              scale: isActive ? 1.01 : 1.0, // ✅ subtle UX scale feedback
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: AppDecorations.agendaCard(
                  ctx,
                  bgColor: isActive
                      ? Theme.of(ctx).colorScheme.primary.withOpacity(0.5)
                      : Theme.of(ctx).colorScheme.primary.withOpacity(0.07),
                ),
                child: Text(
                  date,
                  style:
                      Theme.of(ctx).textTheme.bodyMedium ??
                      AppTextStyles.bodySmall,
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  _StickyHeaderDelegate({required this.child});

  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Center(child: child);
  }

  @override
  double get maxExtent => 48;
  @override
  double get minExtent => 48;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
