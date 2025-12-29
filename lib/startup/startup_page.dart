import 'package:event_app/features/events/presentation/events_providers.dart';
import 'package:event_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/events/domain/event_details_model.dart';
import '../core/storage/secure_storage_service.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/events/presentation/state/selected_event_provider.dart';
import '../main_navigation/main_navigation_page.dart';
import '../core/utilities/scheduling.dart';

class StartUpPage extends ConsumerWidget {
  const StartUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: _bootstrap(ref),
      builder: (context, snap) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
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

    // 2. User has a token → attempt to load event details.
    // Important: do NOT log out when offline. Use cached event details if available.
    final eventId = await auth.getEventId();

    try {
      final eventDetails = await ref
          .read(eventDetailsProvider(eventId).future)
          .timeout(const Duration(seconds: 8));
      deferAfterBuild(() {
        ref.read(selectedEventProvider.notifier).set(eventDetails);
        _go(const MainNavigationPage());
      });
    } catch (_) {
      // Offline (or timeout) fallback:
      // - If event details were cached locally, the provider should succeed even offline.
      // - If not cached, proceed into the app with a minimal placeholder event.
      deferAfterBuild(() {
        ref
            .read(selectedEventProvider.notifier)
            .set(
              EventDetailsModel(
                id: eventId,
                name: '',
                description: null,
                venue: null,
                startDate: DateTime.now(),
                endDate: DateTime.now(),
                bannerImageUrl: null,
              ),
            );
        _go(const MainNavigationPage());
      });
    }
  }

  void _go(Widget page) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (_) => page),
      );
    });
  }
}
