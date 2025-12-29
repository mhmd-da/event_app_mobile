import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/features/auth/presentation/reset_password_page.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/core/widgets/app_brand_waves.dart';
import 'package:event_app/core/widgets/app_text_input.dart';
import 'package:event_app/core/widgets/app_primary_button.dart';
import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/theme/app_spacing.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    final headerHeight = appHeaderWaveHeightForAuth(context);
    final footerHeight = appFooterWaveHeightForAuth(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: AppFooterWave(height: footerHeight),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppHeaderWave(
            height: headerHeight,
            overlay: Builder(
              builder: (context) {
                final topInset = MediaQuery.of(context).padding.top;
                return Positioned(
                  left: 24,
                  right: 18,
                  top: topInset + 8,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'KSU Tamkeen X 2026',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.white.withValues(alpha: 0.9),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            'assets/icons/app_icon.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.section),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              l10n.forgotPasswordTitle,
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
                      AppTextInput(
                        controller: _usernameCtrl,
                        label: l10n.usernameEmailIdLabel,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      const SizedBox(height: AppSpacing.item),
                      if (loginState.errorMessage != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          loginState.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: AppSpacing.item),
                      ],
                      loginState.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : AppPrimaryButton(
                              label: l10n.sendCode,
                              onPressed: () async {
                                if (!_formKey.currentState!.validate()) return;
                                final ok = await ref
                                    .read(loginControllerProvider.notifier)
                                    .forgotPasswordRequest(
                                      _usernameCtrl.text.trim(),
                                    );
                                if (!mounted) return;
                                if (ok) {
                                  AppNotifier.success(
                                    context,
                                    l10n.forgotPasswordSuccess,
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => const ResetPasswordPage(),
                                    ),
                                  );
                                } else {
                                  final err =
                                      ref
                                          .read(loginControllerProvider)
                                          .errorMessage ??
                                      l10n.actionFailed;
                                  AppNotifier.error(context, err);
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
