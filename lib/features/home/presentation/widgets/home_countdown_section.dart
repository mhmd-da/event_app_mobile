import 'dart:async';

import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/widgets/app_card.dart';
import 'package:event_app/core/widgets/app_primary_button.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class HomeCountdownSection extends StatefulWidget {
  const HomeCountdownSection({super.key});

  @override
  State<HomeCountdownSection> createState() => _HomeCountdownSectionState();
}

class _HomeCountdownSectionState extends State<HomeCountdownSection> {
  static final DateTime _target = DateTime(2026, 1, 19, 10, 0); // 10:00 AM
  late Timer _timer;
  Duration _remaining = const Duration();

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final now = DateTime.now();
    setState(() {
      _remaining = _target.difference(now).isNegative
          ? Duration.zero
          : _target.difference(now);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return AppCard(
      title: l10n.countdownTitle,
      centerTitle: true,
      useGradient: true,
      child: Column(
        children: [
          Text(
            l10n.countdownEventDateLine,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.item),
          _MetricsRow(
            metrics: [
              _Metric(value: days, label: l10n.countdownDays),
              _Metric(value: hours, label: l10n.countdownHours),
              _Metric(value: minutes, label: l10n.countdownMinutes),
              _Metric(value: seconds, label: l10n.countdownSeconds),
            ],
          ),
          const SizedBox(height: AppSpacing.item),
          AppPrimaryButton(
            label: l10n.register,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _Metric {
  final int value;
  final String label;
  _Metric({required this.value, required this.label});
}

class _MetricsRow extends StatelessWidget {
  final List<_Metric> metrics;
  const _MetricsRow({required this.metrics});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: metrics.map((m) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: theme.brightness == Brightness.dark ? 0.2 : 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  m.value.toString(),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  m.label,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
