import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/agenda/presentation/agenda_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:event_app/l10n/app_localizations.dart';

class SessionDetailsPage extends ConsumerWidget {
  const SessionDetailsPage({super.key, required this.session});

  final SessionModel session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRegisteredNow = ref.watch(
      sessionRegistrationStateProvider(session),
    );

    return Scaffold(
      appBar: AppBar(title: Text(session.name ?? '')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.page),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSessionCard(context),
            const SizedBox(height: AppSpacing.section),
            _buildRegistrationButton(context, ref, isRegisteredNow),
            const SizedBox(height: AppSpacing.section),
            if (session.startTime != null) _buildReminderChip(context),
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
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationButton(
    BuildContext context,
    WidgetRef ref,
    bool isRegisteredNow,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        label: Text(
          isRegisteredNow
              ? AppLocalizations.of(context)!.removeFromAgenda
              : AppLocalizations.of(context)!.addToAgenda,
        ),
        icon: Icon(
          isRegisteredNow
              ? Icons.remove_circle_outline
              : Icons.check_circle_outline,
        ),
        onPressed: () async {
          try {
            var response = false;
            if (isRegisteredNow) {
              response = await ref
                  .watch(sessionRepositoryProvider)
                  .cancelSessionRegistration(session.id);
            } else {
              response = await ref
                  .watch(sessionRepositoryProvider)
                  .registerSession(session.id);
            }
            Future.microtask(() {
              ref
                      .read(sessionRegistrationStateProvider(session).notifier)
                      .state =
                  !isRegisteredNow;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isRegisteredNow
                      ? AppLocalizations.of(context)!.removedSuccess
                      : AppLocalizations.of(context)!.addedSuccess,
                ),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.actionFailed),
              ),
            );
          }
        },
        style: AppDecorations.primaryButton(context),
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

  Widget _buildReminderChip(BuildContext context) {
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
            child: Text(
              'Reminder: 1 hour before the session',
              style: AppTextStyles.bodySmall,
            ),
          ),
        ],
      ),
    );
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
              backgroundImage: person.profileImageUrl != null
                  ? NetworkImage(person.profileImageUrl!)
                  : null,
              child: person.profileImageUrl == null
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
}
