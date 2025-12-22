import 'dart:async';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/features/auth/presentation/login_page.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/auth/presentation/widgets/otp_input.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:event_app/core/widgets/app_brand_waves.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/core/widgets/app_primary_button.dart';
import 'package:event_app/core/theme/app_spacing.dart';

part 'code_verification_page.g.dart';

@riverpod
class OtpResendCooldown extends _$OtpResendCooldown {
  @override
  int build() => 0;
  void set(int value) => state = value;
  void decrement() => state = state - 1;
}

class CodeVerificationPage extends ConsumerStatefulWidget {
  const CodeVerificationPage({super.key});

  @override
  ConsumerState<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends ConsumerState<CodeVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _otp;
  Timer? _cooldownTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    ref.read(otpResendCooldownProvider.notifier).set(60);
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final cooldown = ref.read(otpResendCooldownProvider);
      if (cooldown > 0) {
        ref.read(otpResendCooldownProvider.notifier).decrement();
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _trySubmit() async {
    if ((_otp?.length ?? 0) == 6 && _formKey.currentState?.validate() == true) {
      final l10n = AppLocalizations.of(context)!;
      final navigator = Navigator.of(context);
      try {
        await ref.read(loginControllerProvider.notifier).loginWithCode(_otp!);
        final state = ref.read(loginControllerProvider);
        if (!mounted) return;
        if (state.isLoggedIn == true) {
          await navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => LoginPage()),
            (route) => false,
          );
        } else {
          AppNotifier.error(
            context,
            '${l10n.actionFailed}: ${state.errorMessage ?? ''}',
          );
        }
      } catch (e) {
        if (!mounted) return;
        AppNotifier.error(context, '${l10n.actionFailed}: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cooldown = ref.watch(otpResendCooldownProvider);
    final loginState = ref.watch(loginControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const AppFooterWave(height: 120),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppHeaderWave(
            height: 200,
            overlay: Builder(
              builder: (context) {
                final topInset = MediaQuery.of(context).padding.top;
                return Positioned(
                  right: 18,
                  top: topInset + 8,
                  child: CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.white.withValues(alpha: 0.9),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/icons/app_icon.png'),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              l10n.verifyCodeTitle,
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.item),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      OtpInput(
                        length: 6,
                        onChanged: (v) {
                          _otp = v;
                        },
                        onCompleted: (_) => _trySubmit(),
                        validator: (code) {
                          if (code.length != 6 || code.contains(RegExp('\\D'))) {
                            return l10n.otpError;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.item),
                      loginState.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : AppPrimaryButton(
                              label: l10n.verifyButton,
                              onPressed: () async {
                                if (_formKey.currentState?.validate() == true && (_otp?.length ?? 0) == 6) {
                                  final navigator = Navigator.of(context);
                                  try {
                                    await ref.read(loginControllerProvider.notifier).loginWithCode(_otp!);
                                    final state = ref.read(loginControllerProvider);
                                    if (!mounted) return;
                                    if (state.isLoggedIn == true) {
                                      await navigator.pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (_) => LoginPage()),
                                        (route) => false,
                                      );
                                    } else {
                                      AppNotifier.error(
                                        context,
                                        '${l10n.actionFailed}: ${state.errorMessage ?? ''}',
                                      );
                                    }
                                  } catch (e) {
                                    if (!mounted) return;
                                    AppNotifier.error(context, '${l10n.actionFailed}: $e');
                                  }
                                }
                              },
                            ),
                      const SizedBox(height: 16),
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
                                    if (!mounted) return;
                                    AppNotifier.success(context, l10n.verificationCodeResent);
                                  } catch (e) {
                                    if (!mounted) return;
                                    AppNotifier.error(context, l10n.failedToResendCode(e.toString()));
                                  }
                                }
                              : null,
                          child: Text(
                            cooldown == 0
                                ? l10n.resendOtp
                                : '${l10n.resendOtpIn} $cooldown ${l10n.seconds}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 140),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
