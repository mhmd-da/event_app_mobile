import 'package:event_app/core/widgets/app_primary_button.dart';
import 'package:event_app/features/auth/presentation/code_verification_page.dart';
import 'package:event_app/core/widgets/notifier.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:event_app/core/widgets/app_text_input.dart';
import 'package:event_app/core/widgets/app_dropdown.dart';
import 'package:event_app/core/widgets/app_brand_waves.dart';
import 'package:event_app/core/theme/app_text_styles.dart';
import 'package:event_app/core/theme/app_colors.dart';
import 'package:event_app/core/theme/app_spacing.dart';
import 'registration_providers.dart';

// Providers moved to registration_providers.dart

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final strength = _calculateStrength(password);
    final strengthColor = _getStrengthColor(strength);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: strength,
          color: strengthColor,
          backgroundColor: Colors.grey[300],
        ),
        const SizedBox(height: 4),
        Text(
          _getStrengthLabel(context, strength),
          style: TextStyle(color: strengthColor),
        ),
      ],
    );
  }

  double _calculateStrength(String password) {
    if (password.isEmpty) return 0.0;
    double strength = 0.0;
    if (password.length >= 8) strength += 0.3;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.2;
    if (RegExp(r'[!@#\$&*~]').hasMatch(password)) strength += 0.3;
    return strength.clamp(0.0, 1.0);
  }

  Color _getStrengthColor(double strength) {
    if (strength < 0.3) return Colors.red;
    if (strength < 0.7) return Colors.orange;
    return Colors.green;
  }

  String _getStrengthLabel(BuildContext context, double strength) {
    final l10n = AppLocalizations.of(context)!;
    if (strength < 0.3) return l10n.passwordStrengthWeak;
    if (strength < 0.7) return l10n.passwordStrengthModerate;
    return l10n.passwordStrengthStrong;
  }
}

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _identifierFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  @override
  void dispose() {
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _identifierFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(registrationFormControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: const AppFooterWave(height: 120),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed header wave with icon bubble overlay
          AppHeaderWave(
            height: 200,
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
              AppLocalizations.of(context)!.registerHeading,
              style: AppTextStyles.headlineLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.item),

          // Scrollable inputs only
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppTextInput(
                            label: AppLocalizations.of(context)!.firstName,
                            prefixIcon: const Icon(Icons.person_outline),
                            dense: false,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.small,
                              vertical: 16,
                            ),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                ? AppLocalizations.of(context)!.fieldRequired
                                : null,
                            onChanged: (value) {
                              ref
                                  .read(
                                    registrationFormControllerProvider.notifier,
                                  )
                                  .updateField('firstName', value);
                            },
                            focusNode: _firstNameFocus,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => _lastNameFocus.requestFocus(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppTextInput(
                            label: AppLocalizations.of(context)!.lastName,
                            prefixIcon: const Icon(Icons.person_outline),
                            dense: false,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.small,
                              vertical: 16,
                            ),
                            validator: (value) =>
                                (value == null || value.isEmpty)
                                ? AppLocalizations.of(context)!.fieldRequired
                                : null,
                            onChanged: (value) {
                              ref
                                  .read(
                                    registrationFormControllerProvider.notifier,
                                  )
                                  .updateField('lastName', value);
                            },
                            focusNode: _lastNameFocus,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) => _emailFocus.requestFocus(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppDropdown<String>(
                      value: formState.gender,
                      items: const ['Male', 'Female'],
                      itemLabel: (v) =>
                          v == 'Male' ? l10n.genderMale : l10n.genderFemale,
                      label: l10n.gender,
                      prefixIcon: const Icon(Icons.wc),
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('gender', value);
                      },
                      validator: (value) =>
                          value == null ? l10n.fieldRequired : null,
                    ),
                    const SizedBox(height: 16),
                    AppTextInput(
                      label: AppLocalizations.of(context)!.userIdentifier,
                      prefixIcon: const Icon(Icons.badge_outlined),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        // Optional; only validate length if provided
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length < 3) {
                          return AppLocalizations.of(context)!.fieldRequired;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('userIdentifier', value);
                      },
                      focusNode: _identifierFocus,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => _emailFocus.requestFocus(),
                    ),
                    const SizedBox(height: 16),
                    AppTextInput(
                      label: AppLocalizations.of(context)!.email,
                      prefixIcon: const Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.fieldRequired;
                        }
                        if (!value.contains('@')) {
                          return AppLocalizations.of(context)!.invalidEmail;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('email', value);
                      },
                      focusNode: _emailFocus,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => _phoneFocus.requestFocus(),
                    ),
                    const SizedBox(height: 16),
                    AppTextInput(
                      label: AppLocalizations.of(context)!.phoneNumber,
                      prefixIcon: const Icon(Icons.phone_outlined),
                      keyboardType: TextInputType.phone,
                      validator: (value) => (value == null || value.isEmpty)
                          ? AppLocalizations.of(context)!.fieldRequired
                          : null,
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('phoneNumber', value);
                      },
                      focusNode: _phoneFocus,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => _passwordFocus.requestFocus(),
                    ),
                    const SizedBox(height: 16),
                    AppTextInput(
                      label: AppLocalizations.of(context)!.password,
                      isPassword: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.fieldRequired;
                        }
                        if (value.length < 6) {
                          return AppLocalizations.of(context)!.weakPassword;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('password', value);
                      },
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (_) => _confirmFocus.requestFocus(),
                    ),
                    const SizedBox(height: 8),
                    PasswordStrengthIndicator(
                      password: formState.password ?? '',
                    ),
                    const SizedBox(height: 16),
                    AppTextInput(
                      label: AppLocalizations.of(context)!.confirmPassword,
                      isPassword: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalizations.of(context)!.fieldRequired;
                        }
                        final pwd =
                            ref
                                .read(registrationFormControllerProvider)
                                .password ??
                            '';
                        if (value != pwd) {
                          return AppLocalizations.of(
                            context,
                          )!.passwordsDontMatch;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('confirmPassword', value);
                      },
                      focusNode: _confirmFocus,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => FocusScope.of(context).unfocus(),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // Bottom CTA fixed above footer wave
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.darkSurface
                    : AppColors.lightSurface,
                border: Border(
                  top: BorderSide(color: Theme.of(context).dividerColor),
                ),
              ),
              child: IgnorePointer(
                ignoring: _submitting,
                child: AppPrimaryButton(
                  label: AppLocalizations.of(context)!.registerButton,
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final l10n = AppLocalizations.of(context)!;
                    final navigator = Navigator.of(context);

                    final form = ref.read(registrationFormControllerProvider);
                    final formData = {
                      'title': form.title,
                      'firstName': form.firstName,
                      'lastName': form.lastName,
                      'UserIdentifier': form.userIdentifier,
                      'email': form.email,
                      'phoneNumber': form.phoneNumber,
                      'password': form.password,
                      'confirmPassword': form.confirmPassword,
                      'gender': form.gender,
                    };

                    setState(() => _submitting = true);
                    try {
                      final authRepository = ref.read(authRepositoryProvider);
                      final response = await authRepository.register(formData);

                      if (!mounted) return;

                      _formKey.currentState!.reset();
                      ref
                          .read(registrationFormControllerProvider.notifier)
                          .reset();

                      final storage = ref.read(secureStorageProvider);
                      await storage.saveUserId(response.userId);

                      if (!mounted) return;
                      await navigator.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const CodeVerificationPage(),
                        ),
                      );
                    } catch (e) {
                      if (!mounted) return;
                      AppNotifier.error(
                        context,
                        '${l10n.registrationFailed}: $e',
                      );
                    } finally {
                      if (mounted) setState(() => _submitting = false);
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
