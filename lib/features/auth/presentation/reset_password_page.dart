import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/features/auth/presentation/login_page.dart';
import 'package:event_app/features/auth/presentation/widgets/otp_input.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/core/widgets/app_brand_waves.dart';
import 'package:event_app/core/widgets/app_text_input.dart';
import 'package:event_app/core/widgets/app_primary_button.dart';
import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/theme/app_spacing.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String? _otp;
  final _passwordCtr = TextEditingController();
  final ValueNotifier<bool> _showPassword = ValueNotifier(false);

  @override
  void dispose() {
    _passwordCtr.dispose();
    _showPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              l10n.resetPasswordTitle,
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
                        onChanged: (v) => _otp = v,
                        validator: (code) {
                          if (code.length != 6 || code.contains(RegExp(r'\\D'))) return l10n.enter6Digits;
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.item),
                      AppTextInput(
                        controller: _passwordCtr,
                        label: l10n.newPassword,
                        isPassword: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        validator: (v) => (v == null || v.trim().length < 6) ? l10n.min6Chars : null,
                      ),
                      const SizedBox(height: AppSpacing.item),
                      loginState.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : AppPrimaryButton(
                              label: l10n.resetPasswordButton,
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) return;
                                try {
                                  await ref
                                      .read(loginControllerProvider.notifier)
                                      .resetPassword((_otp ?? '').trim(), _passwordCtr.text.trim());
                                  if (!mounted) return;
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(builder: (_) => LoginPage()),
                                    (route) => false,
                                  );
                                } catch (e) {
                                  if (!mounted) return;
                                  AppNotifier.error(context, e.toString());
                                }
                              },
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
