import 'dart:async';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/features/auth/presentation/login_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  late final List<TextEditingController> _otpCtrls;
  late final List<FocusNode> _otpFocus;

  @override
  void initState() {
    super.initState();
    _otpCtrls = List.generate(6, (_) => TextEditingController());
    _otpFocus = List.generate(6, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _otpCtrls) c.dispose();
    for (final f in _otpFocus) f.dispose();
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

  Future<void> _trySubmit() async {
    // Auto-submit when 6-digit code is ready and form validates
    if ((_otp?.length ?? 0) == 6) {
      // Temporarily run validation on any field to ensure digits-only
      if (_formKey.currentState?.validate() == true) {
        try {
          await ref.read(loginControllerProvider.notifier).loginWithCode(_otp!);
          final loginState = ref.read(loginControllerProvider);
          if (loginState.isLoggedIn == true) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${AppLocalizations.of(context)!.actionFailed}: ${loginState.errorMessage ?? ''}')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${AppLocalizations.of(context)!.actionFailed}: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cooldown = ref.watch(otpResendCooldownProvider);
    final loginState = ref.watch(loginControllerProvider);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              const SizedBox(height: 24),
              // Top icon in circular container
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: colors.primary.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.mark_email_read_outlined, color: colors.primary, size: 40),
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Verification',
                  style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              Align(
                alignment: Alignment.center,
                child: Text(
                  'We will send you a One Time Password\nvia email to verify your account',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withOpacity(0.7)),
                ),
              ),
              const SizedBox(height: 24),

              // OTP input (6-digit segmented)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (i) {
                  return SizedBox(
                    width: 48,
                    child: TextFormField(
                      controller: _otpCtrls[i],
                      focusNode: _otpFocus[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: colors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (val) {
                        // Paste handling only in the first box (index 0)
                        if (i == 0 && val.length > 1) {
                          final chars = val.replaceAll(RegExp(r"\s"), '').split('');
                          int idx = 0;
                          for (final ch in chars) {
                            if (idx > 5) break;
                            _otpCtrls[idx].text = ch;
                            idx++;
                          }
                          if (idx <= 5) {
                            _otpFocus[idx].requestFocus();
                          } else {
                            _otpFocus[5].unfocus();
                          }
                        } else {
                          // Normal single char flow
                          if (val.isNotEmpty) {
                            if (i < 5) {
                              _otpFocus[i + 1].requestFocus();
                            } else {
                              _otpFocus[i].unfocus();
                            }
                          }
                        }
                        _otp = _otpCtrls.map((c) => c.text).join();
                        _trySubmit();
                      },
                      validator: (_) {
                        final code = _otpCtrls.map((c) => c.text).join();
                        if (code.length != 6 || code.contains(RegExp(r'\D'))) {
                          return AppLocalizations.of(context)!.otpError;
                        }
                        return null;
                      },
                    ),
                  );
                }),
              ),

              const SizedBox(height: 24),

              // Verify button
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: colors.onPrimary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await ref.read(loginControllerProvider.notifier).loginWithCode(_otp!);
                        final loginState = ref.read(loginControllerProvider);
                        if (loginState.isLoggedIn == true) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${AppLocalizations.of(context)!.actionFailed}: ${loginState.errorMessage}')),
                          );
                        }     
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${AppLocalizations.of(context)!.actionFailed}: ${e.toString()}')),
                        );
                      }
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.verifyButton.toUpperCase()),
                ),
              ),

              const SizedBox(height: 16),

              // Resend link
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: cooldown == 0
                      ? () async {
                          try {
                            final authRepository = ref.read(authRepositoryProvider);
                            final storage = ref.read(secureStorageProvider);
                            await authRepository.resendVerificationCode(await storage.getUserId());
                            _startCooldown();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Verification code resent')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to resend code: $e')),
                            );
                          }
                        }
                      : null,
                  child: Text(
                    cooldown == 0
                        ? AppLocalizations.of(context)!.resendOtp
                        : '${AppLocalizations.of(context)!.resendOtpIn} $cooldown ${AppLocalizations.of(context)!.seconds}',
                    style: textTheme.bodyMedium?.copyWith(color: colors.primary),
                  ),
                ),
              ),
                ],
              ),
            ),
          ),
          if (loginState.isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
