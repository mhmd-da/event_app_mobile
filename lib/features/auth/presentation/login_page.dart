import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:event_app/l10n/app_localizations.dart';
import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/widgets/app_text_input.dart';
import 'package:event_app/core/widgets/app_primary_button.dart';

import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/features/auth/presentation/login_state.dart';
import 'package:event_app/features/auth/presentation/forgot_password_page.dart';
import 'package:event_app/features/auth/presentation/registration_page.dart';
import 'package:event_app/core/widgets/app_brand_waves.dart';
import 'package:event_app/features/auth/presentation/code_verification_page.dart';
import 'package:event_app/startup/startup_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submitLogin() {
    ref.read(loginControllerProvider.notifier).login(
          _usernameController.text.trim(),
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = ref.watch(loginControllerProvider);
    final l10n = AppLocalizations.of(context)!;
    // React to login state changes for navigation side-effects
    ref.listen<LoginState>(loginControllerProvider, (prev, next) {
      if (!mounted) return;
      // Navigate to verification if required
      if (next.requiresVerification == true && (prev?.requiresVerification != true)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const CodeVerificationPage()),
          );
        });
        return;
      }
      // Navigate to startup (which routes to main) on successful login
      if (next.isLoggedIn == true && (prev?.isLoggedIn != true)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const StartUpPage()),
            (route) => false,
          );
        });
      }
    });

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
              'LOGIN',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextInput(
                      controller: _usernameController,
                      focusNode: _usernameFocus,
                      label: l10n.emailLabel,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => _passwordFocus.requestFocus(),
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                    const SizedBox(height: AppSpacing.item),
                    AppTextInput(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      label: l10n.password,
                      isPassword: true,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _submitLogin(),
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                    const SizedBox(height: AppSpacing.small),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ForgotPasswordPage(),
                            ),
                          );
                        },
                        child: Text(l10n.forgotPasswordLink),
                      ),
                    ),
                    if (loginState.errorMessage != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        loginState.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.item),
                    loginState.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : AppPrimaryButton(
                            label: l10n.continueButton,
                            onPressed: _submitLogin,
                          ),
                    const SizedBox(height: AppSpacing.small),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegistrationPage(),
                          ),
                        );
                      },
                      child: Text(l10n.dontHaveAccountRegister),
                    ),
                    const SizedBox(height: 140),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Decorative clippers for header/footer waves ---
// Using shared app_brand_waves clippers
