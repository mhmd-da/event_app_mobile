import 'package:event_app/core/theme/app_decorations.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/agenda/domain/session_model.dart';
import 'package:event_app/features/partners/domain/partner_model.dart';
import 'package:event_app/features/partners/presentation/partner_details_page.dart';
import 'package:event_app/features/partners/presentation/partner_providers.dart';
import 'package:event_app/features/sponsors/domain/sponsor_model.dart';
import 'package:event_app/features/sponsors/presentation/sponsor_details_page.dart';
import 'package:event_app/features/sponsors/presentation/sponsor_providers.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionSponsorsSection extends ConsumerWidget {
  final List<Sponsor> sponsors;

  const SessionSponsorsSection({super.key, required this.sponsors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (sponsors.isEmpty) return const SizedBox.shrink();

    return _Section(
      title: AppLocalizations.of(context)!.poweredBy,
      child: _LogoList(
        items: sponsors,
        onTapItem: (item) async {
          await _openSponsorDetails(context, ref, item as Sponsor);
        },
      ),
    );
  }
}

class SessionPartnersSection extends ConsumerWidget {
  final List<Partner> partners;

  const SessionPartnersSection({super.key, required this.partners});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (partners.isEmpty) return const SizedBox.shrink();

    return _Section(
      title: AppLocalizations.of(context)!.partners,
      child: _LogoList(
        items: partners,
        onTapItem: (item) async {
          await _openPartnerDetails(context, ref, item as Partner);
        },
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;

  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headlineMedium),
        const SizedBox(height: AppSpacing.item),
        child,
      ],
    );
  }
}

class _LogoList extends StatelessWidget {
  final List<dynamic> items;
  final Future<void> Function(dynamic item) onTapItem;

  const _LogoList({required this.items, required this.onTapItem});

  @override
  Widget build(BuildContext context) {
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

Future<void> _openSponsorDetails(
  BuildContext context,
  WidgetRef ref,
  Sponsor sponsor,
) async {
  final l10n = AppLocalizations.of(context)!;
  SponsorModel? match;

  try {
    final sponsors = await ref.read(sponsorsListProvider.future);
    if (sponsor.id != null) {
      match = _firstWhereOrNull(sponsors, (s) => s.id == sponsor.id);
    }
    match ??= _firstWhereOrNull(
      sponsors,
      (s) => _normalizeKey(s.name) == _normalizeKey(sponsor.name),
    );
  } catch (_) {
    match = null;
  }

  if (match == null) {
    AppNotifier.error(context, l10n.actionFailed);
    return;
  }

  if (!context.mounted) return;
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => SponsorDetailsPage(sponsor: match!)),
  );
}

Future<void> _openPartnerDetails(
  BuildContext context,
  WidgetRef ref,
  Partner partner,
) async {
  final l10n = AppLocalizations.of(context)!;
  PartnerModel? match;

  try {
    final partners = await ref.read(partnersListProvider.future);
    if (partner.id != null) {
      match = _firstWhereOrNull(partners, (p) => p.id == partner.id);
    }
    match ??= _firstWhereOrNull(
      partners,
      (p) => _normalizeKey(p.name) == _normalizeKey(partner.name),
    );
  } catch (_) {
    match = null;
  }

  if (match == null) {
    AppNotifier.error(context, l10n.actionFailed);
    return;
  }

  if (!context.mounted) return;
  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => PartnerDetailsPage(partner: match!)),
  );
}
