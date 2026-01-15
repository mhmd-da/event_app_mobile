import 'dart:async';

import 'package:event_app/core/theme/app_spacing.dart';
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

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            const Color(0xFFFFFFFF),
            const Color(0xFFFFFFFF),
            const Color(0xFFD6E4F0),
          ],
        ),
      ),
      padding: const EdgeInsets.all(AppSpacing.section),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.largeSection),
          Text(
            l10n.countdownTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: const Color(0xFF2D9CDB),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.page),
          Text(
            l10n.countdownEventDateLine,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: const Color(0xFF1F2937),
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
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
          const SizedBox(height: AppSpacing.largeSection),
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
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  m.value.toString(),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    m.label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF6B7280),
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
