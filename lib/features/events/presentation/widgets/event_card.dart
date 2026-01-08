import 'package:event_app/core/storage/secure_storage_provider.dart';
import 'package:event_app/main_navigation/main_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:event_app/core/widgets/app_buttons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import '../../domain/event_model.dart';
import '../state/selected_event_provider.dart';

class EventCard extends ConsumerWidget {
  final EventModel event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final start = event.startDate;
    final end = event.endDate;

    final dateText = AppTimeFormatting.formatDateRangeYMMMd(
      context,
      start: start,
      end: end,
    );

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              /// BACKGROUND IMAGE WITH FALLBACK
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: event.bannerImageUrl != null
                    ? Image.network(
                        event.bannerImageUrl!,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 180,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFF512F), Color(0xFFF09819)],
                              ),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 180,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFF512F), Color(0xFFF09819)],
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 180,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF512F), Color(0xFFF09819)],
                          ),
                        ),
                      ),
              ),

              /// DARK OVERLAY FOR TEXT READABILITY
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withValues(alpha: 0.75),
                      Colors.black.withValues(alpha: 0.2),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              /// TEXT & BUTTON
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text(
                        dateText,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: AppElevatedButton(
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );

                          // Save event ID to storage - this will trigger selectedEventProvider to refetch
                          final storage = ref.read(secureStorageProvider);
                          await storage.saveEventId(event.id);
                          
                          // Invalidate provider to force refetch
                          ref.invalidate(selectedEventProvider);

                          navigator.pop(); // remove loader

                          // Navigate to main navigation
                          navigator.pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const MainNavigationPage(),
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.selectEvent),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
