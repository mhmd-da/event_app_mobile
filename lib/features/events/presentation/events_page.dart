import 'package:event_app/features/events/presentation/widgets/event_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'events_providers.dart';
import 'widgets/event_segmented_control.dart';
import '../domain/event_model.dart';

class EventsPage extends ConsumerStatefulWidget {
  const EventsPage({super.key});

  @override
  ConsumerState<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends ConsumerState<EventsPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: ref.read(eventsTabProvider),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // -----------------------------
  // Filtering Logic
  // -----------------------------
  List<EventModel> _filterPast(List<EventModel> events) {
    final now = DateTime.now();
    return events.where((e) => e.endDate.isBefore(now)).toList();
  }

  List<EventModel> _filterOngoing(List<EventModel> events) {
    final now = DateTime.now();
    return events
        .where((e) =>
    !e.startDate.isAfter(now) &&
        !e.endDate.isBefore(now))
        .toList();
  }

  List<EventModel> _filterFuture(List<EventModel> events) {
    final now = DateTime.now();
    return events.where((e) => e.startDate.isAfter(now)).toList();
  }

  // -----------------------------
  // Build
  // -----------------------------
  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsListProvider);
    final currentTab = ref.watch(eventsTabProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.selectEvent),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Segmented Control
            EventSegmentedControl(
              currentTab: currentTab,
              onTabSelected: (index) {
                ref.read(eventsTabProvider.notifier).set(index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                );
              },
            ),

            const SizedBox(height: 16),

            // Main content with pull-to-refresh & swipe navigation
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  final _ = ref.refresh(eventsListProvider);
                },
                child: eventsAsync.when(
                  data: (events) {
                    return PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        ref.read(eventsTabProvider.notifier).set(index);
                      },
                      children: [
                        // Past
                        EventsList(events: _filterPast(events)),

                        // Ongoing
                        EventsList(events: _filterOngoing(events)),

                        // Future
                        EventsList(events: _filterFuture(events)),
                      ],
                    );
                  },
                  loading: () =>
                  const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(
                    child: Text('${AppLocalizations.of(context)!.errorLoadingSchedule}: $err'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
