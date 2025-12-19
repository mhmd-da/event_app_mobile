import 'package:event_app/core/storage/secure_storage_service.dart';
import 'package:event_app/features/auth/presentation/registration_page.dart';
import 'package:event_app/features/auth/presentation/code_verification_page.dart';
import 'package:event_app/features/events/presentation/events_providers.dart';
import 'package:event_app/features/events/presentation/state/selected_event_provider.dart';
import 'package:event_app/features/profile/presentation/profile_providers.dart';
import 'package:event_app/main_navigation/main_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_controller.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ValueNotifier<bool> _showPassword = ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginControllerProvider);

    if (loginState.isLoggedIn) {
      Future.microtask(() async {
        final storage = SecureStorageService();
        final eventId = await storage.getEventId();
        final event = await ref.read(eventDetailsProvider(eventId).future);

        ref.read(selectedEventProvider.notifier).state = event;

        var fcmToken = await storage.getFcmToken();
        if (fcmToken == null) {
          // Fetch a fresh token if not in storage (e.g., after logout)
          fcmToken = await FirebaseMessaging.instance.getToken();
          if (fcmToken != null) {
            await storage.saveFcmToken(fcmToken);
          }
        }
        if (fcmToken != null) {
          ref.read(profileRepositoryProvider).registerDevice(fcmToken);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainNavigationPage()),
        );
      });
    } else if (loginState.requiresVerification) {
      Future.microtask(() async {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CodeVerificationPage(),
          ),
        );
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                AppLocalizations.of(context)!.welcomeBack,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.loginToContinue,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),

              // Email field
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.emailLabel,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Password field
              ValueListenableBuilder<bool>(
                valueListenable: _showPassword,
                builder: (context, value, child) {
                  return TextField(
                    controller: _passwordController,
                    obscureText: !value,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.password,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          value ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () => _showPassword.value = !value,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // Error message
              if (loginState.errorMessage != null)
                Text(
                  loginState.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              const SizedBox(height: 16),

              // Login button
              ElevatedButton(
                onPressed: loginState.isLoading
                    ? null
                    : () async {
                        ref
                            .read(loginControllerProvider.notifier)
                            .login(
                              _usernameController.text,
                              _passwordController.text,
                            );
                      },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: loginState.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(AppLocalizations.of(context)!.continueButton),
              ),

              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const RegistrationPage(),
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.dontHaveAccountRegister,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
