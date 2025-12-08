import 'dart:async';

import 'package:event_app/features/auth/data/auth_repository.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/features/auth/presentation/login_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/main_navigation/main_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final otpResendCooldownProvider = StateProvider<int>((ref) => 0);

class CodeVerificationPage extends ConsumerStatefulWidget {
  const CodeVerificationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CodeVerificationPage> createState() =>
      _CodeVerificationPageState();
}

class _CodeVerificationPageState extends ConsumerState<CodeVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _otp;
  Timer? _cooldownTimer;

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    ref.read(otpResendCooldownProvider.notifier).state = 60;
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final cooldown = ref.read(otpResendCooldownProvider);
      if (cooldown > 0) {
        ref.read(otpResendCooldownProvider.notifier).state--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cooldown = ref.watch(otpResendCooldownProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.verifyCodeTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.otpLabel,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => _otp = value,
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.otpError
                    : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await ref.read(loginControllerProvider.notifier).loginWithCode(_otp!);

                      // Navigate to the main app page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Verification failed: ${e.toString()}')),
                      );
                    }
                  }
                },
                child: Text(AppLocalizations.of(context)!.verifyButton),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: cooldown == 0
                    ? () async {
                        try {
                          final authRepository = ref.read(
                            authRepositoryProvider,
                          );
                          final storage = ref.read(secureStorageProvider);

                          await authRepository.resendVerificationCode(
                            await storage.getUserId(),
                          );
                          _startCooldown();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Verification code resent')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to resend code: ${e}'),
                            ),
                          );
                        }
                      }
                    : null,
                child: Text(
                  cooldown == 0
                      ? AppLocalizations.of(context)!.resendOtp
                      : '${AppLocalizations.of(context)!.resendOtpIn} $cooldown ${AppLocalizations.of(context)!.seconds}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
