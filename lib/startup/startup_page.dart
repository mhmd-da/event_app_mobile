import 'package:event_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // ignore: avoid_print
    print('[Startup] begin - no auth required');
    
    // Just navigate to main page - selectedEventProvider will handle fetching
    deferAfterBuild(() {
      _go(const MainNavigationPage());
    });
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
