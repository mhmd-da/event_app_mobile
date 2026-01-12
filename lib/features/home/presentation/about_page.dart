import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AboutCard extends ConsumerWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventAsync = ref.watch(selectedEventProvider);
    
    return eventAsync.when(
      data: (event) {
        if (event == null) return const SizedBox.shrink();
        return _buildCard(context, event);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
  
  Widget _buildCard(BuildContext context, dynamic event) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(AppSpacing.section),
      child: Column(
        children: [
          Text(
            l10n.aboutEvent,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2D9CDB),
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Text(
            event.description ?? l10n.noDescriptionAvailable,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 16,
              height: 2.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              'assets/images/about_illustration.png',
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 240,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFB794F6),
                        Color(0xFF60A5FA),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.trending_up,
                      size: 80,
                      color: Colors.white54,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
