import 'package:event_app/features/events/presentation/events_providers.dart';
import 'package:event_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/events/domain/event_details_model.dart';
import '../core/storage/secure_storage_service.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/events/presentation/state/selected_event_provider.dart';
import '../main_navigation/main_navigation_page.dart';
import '../core/utilities/scheduling.dart';

class StartUpPage extends ConsumerStatefulWidget {
  const StartUpPage({super.key});

  @override
  ConsumerState<StartUpPage> createState() => _StartUpPageState();
}

class _StartUpPageState extends ConsumerState<StartUpPage> {
  late Future<void> _bootstrapFuture;

  @override
  void initState() {
    super.initState();
    _bootstrapFuture = _bootstrap();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _bootstrapFuture,
      builder: (context, snap) {
        if (snap.hasError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Startup failed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('${snap.error}', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _bootstrapFuture = _bootstrap();
                        });
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Future<void> _bootstrap() async {
    final auth = SecureStorageService();

    // These prints are useful in `adb logcat` when a device gets stuck.
    // ignore: avoid_print
    print('[Startup] begin');
    String? token;
    bool isValidToken = false;
    try {
      token = await auth.getToken();
      // 1. No token → go to login
      isValidToken = await auth.isValidToken();
    } on PlatformException catch (e) {
      // Most commonly: javax.crypto.BadPaddingException / BAD_DECRYPT
      // when Android Keystore key is invalid or stored ciphertext is corrupted.
      // Recover by wiping secure storage and forcing re-login.
      // ignore: avoid_print
      print('[Startup] secure storage read failed ($e) → wipe + login');
      try {
        await auth.clearAll();
      } catch (_) {}
      _go(LoginPage());
      return;
    }

    if (token == null || !isValidToken) {
      // ignore: avoid_print
      print('[Startup] no/invalid token → login');
      _go(LoginPage());
      return;
    }

    // 2. User has a token → attempt to load event details.
    // Important: do NOT log out when offline. Use cached event details if available.
    final eventId = await auth.getEventId();
    // ignore: avoid_print
    print('[Startup] token ok, eventId=$eventId');

    try {
      final eventDetails = await ref
          .read(eventDetailsProvider(eventId).future)
          .timeout(const Duration(seconds: 8));
      // ignore: avoid_print
      print('[Startup] event details loaded');
      deferAfterBuild(() {
        ref.read(selectedEventProvider.notifier).set(eventDetails);
        _go(const MainNavigationPage());
      });
    } catch (e) {
      // ignore: avoid_print
      print('[Startup] event details failed ($e) → fallback');
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
      final nav = navigatorKey.currentState;
      if (nav == null) {
        // If navigation isn't ready yet, try again next frame.
        _go(page);
        return;
      }
      nav.pushReplacement(MaterialPageRoute(builder: (_) => page));
    });
  }
}
