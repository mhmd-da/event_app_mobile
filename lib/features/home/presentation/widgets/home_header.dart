import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/core/utilities/time_formatting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerStatefulWidget {
  const HomeHeader({super.key});

  @override
  ConsumerState<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends ConsumerState<HomeHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);

    _scaleAnim = Tween<double>(begin: 1.03, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final eventAsync = ref.watch(selectedEventProvider);
    
    return eventAsync.when(
      data: (event) {
        if (event == null) return const SizedBox.shrink();
        return _buildHeader(context, event);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => const SizedBox.shrink(),
    );
  }
  
  Widget _buildHeader(BuildContext context, dynamic event) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    final dateText = AppTimeFormatting.formatDateRangeYMMMd(
      context,
      start: event.startDate,
      end: event.endDate,
    );

    return FadeTransition(
      opacity: _fadeAnim,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // --------- TEXT ABOVE IMAGE ---------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                Text(
                  event.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    dateText,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: onSurface),
                  ),
                ),
                if ((event.venue?.name ?? '').trim().isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    event.venue?.name.trim() ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(color: onSurface),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 10),

          // --------- PARALLAX + SCALE IMAGE ---------
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnim.value,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          // MAIN IMAGE
                          event.bannerImageUrl != null
                              ? Image.network(
                                  event.bannerImageUrl!,
                                  width: double.infinity,
                                  height: 190,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 190,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFF512F),
                                        Color(0xFFF09819),
                                      ],
                                    ),
                                  ),
                                ),

                          // GRADIENT OVERLAY
                          Container(
                            height: 190,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withValues(alpha: 0.15),
                                  Colors.black.withValues(alpha: 0.05),
                                  Colors.black.withValues(alpha: 0.20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }}
