import 'package:event_app/features/events/presentation/events_providers.dart';
import 'package:event_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/storage/secure_storage_service.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/events/presentation/state/selected_event_provider.dart';
import '../main_navigation/main_navigation_page.dart';

class StartUpPage extends ConsumerWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _bootstrap(ref),
      builder: (context, snap) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Future<void> _bootstrap(WidgetRef ref) async {
    final auth = SecureStorageService();
    final token = await auth.getToken();

    // 1. No token → go to login
    bool isValidToken = await auth.isValidToken();
    if (token == null || !isValidToken) {
      _go(LoginPage());
      return;
    }

    // 2. User has a token → fetch registered events
    //final events = null ;//await auth.getUserRegisteredEvents();

    // find ongoing event
    //final now = DateTime.now();
    //final ongoing = events.firstWhere(
    //      (e) => !e.startDate.isAfter(now) && !e.endDate.isBefore(now),
    //  orElse: () => null,
    //);

    //if (ongoing != null) {
    //  // 3. There is an ongoing event → go inside the event
    //  ref.read(selectedEventProvider.notifier).state = ongoing;
    //  _go(const MainNavigationPage());
    //} else {

      // 4. No ongoing event → show events page
     // _go(const EventsPage());

    //FOR NOW, WE DON'T NEED ANYTHING RELATED TO EVENTS, JUST GO TO THE MAIN NAVIGATION PAGE
    var eventId = await auth.getEventId();
    var eventDetails = await ref.watch(eventDetailsProvider(eventId).future);
    ref.read(selectedEventProvider.notifier).state = eventDetails;
    _go(const MainNavigationPage());

    //}
  }

  void _go(Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (_) => page),
      );
    });
  }
}
