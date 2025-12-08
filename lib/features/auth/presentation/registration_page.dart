import 'package:event_app/features/auth/presentation/code_verification_page.dart';
import 'package:event_app/features/auth/presentation/login_controller.dart';
import 'package:event_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationFormProvider =
    StateNotifierProvider<RegistrationFormController, RegistrationFormState>((
      ref,
    ) {
      return RegistrationFormController();
    });

final registrationFormControllerProvider =
    StateNotifierProvider<RegistrationFormController, RegistrationFormState>((
      ref,
    ) {
      return RegistrationFormController();
    });

class RegistrationFormState {
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? confirmPassword;
  final String? bio;
  final String? university;
  final String? department;
  final String? major;
  final String? preferredLanguage;
  final String? gender;

  RegistrationFormState({
    this.title,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
    this.confirmPassword,
    this.bio,
    this.university,
    this.department,
    this.major,
    this.preferredLanguage,
    this.gender,
  });

  RegistrationFormState copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? bio,
    String? university,
    String? department,
    String? major,
    String? preferredLanguage,
    String? gender,
  }) {
    return RegistrationFormState(
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      bio: bio ?? this.bio,
      university: university ?? this.university,
      department: department ?? this.department,
      major: major ?? this.major,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      gender: gender ?? this.gender,
    );
  }
}

class RegistrationFormController extends StateNotifier<RegistrationFormState> {
  RegistrationFormController() : super(RegistrationFormState());

  void updateField(String field, String? value) {
    state = state.copyWith(
      title: field == 'title' ? value : state.title,
      firstName: field == 'firstName' ? value : state.firstName,
      lastName: field == 'lastName' ? value : state.lastName,
      email: field == 'email' ? value : state.email,
      phoneNumber: field == 'phoneNumber' ? value : state.phoneNumber,
      password: field == 'password' ? value : state.password,
      confirmPassword: field == 'confirmPassword'
          ? value
          : state.confirmPassword,
      bio: field == 'bio' ? value : state.bio,
      university: field == 'university' ? value : state.university,
      department: field == 'department' ? value : state.department,
      major: field == 'major' ? value : state.major,
      preferredLanguage: field == 'preferredLanguage'
          ? value
          : state.preferredLanguage,
      gender: field == 'gender' ? value : state.gender,
    );
  }
}

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({required this.password, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    double strength = _calculateStrength(password);
    Color strengthColor = _getStrengthColor(strength);

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
          _getStrengthLabel(strength),
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

  String _getStrengthLabel(double strength) {
    if (strength < 0.3) return 'Weak';
    if (strength < 0.7) return 'Moderate';
    return 'Strong';
  }
}

class RegistrationPage extends ConsumerWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  static final _formKey = GlobalKey<FormState>(); // Moved outside build method

  InputDecoration _buildInputDecoration(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(registrationFormControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.registerTitle)),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.title,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: 'Mr.',
                                child: Text('Mr.'),
                              ),
                              DropdownMenuItem(
                                value: 'Ms.',
                                child: Text('Ms.'),
                              ),
                              DropdownMenuItem(
                                value: 'Mrs.',
                                child: Text('Mrs.'),
                              ),
                            ], // Ensure these strings are localized
                            onChanged: (value) {},
                            validator: (value) => value == null
                                ? AppLocalizations.of(context)!.title
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: _buildInputDecoration(
                              AppLocalizations.of(context)!.firstName,
                              AppLocalizations.of(context)!.firstNameHint,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocalizations.of(context)!.firstName
                                : null,
                            onChanged: (value) {
                              ref
                                  .read(
                                    registrationFormControllerProvider.notifier,
                                  )
                                  .updateField('firstName', value);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            decoration: _buildInputDecoration(
                              AppLocalizations.of(context)!.lastName,
                              AppLocalizations.of(context)!.lastNameHint,
                            ),
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocalizations.of(context)!.lastName
                                : null,
                            onChanged: (value) {
                              ref
                                  .read(
                                    registrationFormControllerProvider.notifier,
                                  )
                                  .updateField('lastName', value);
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.gender,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Male', child: Text('Male')),
                        DropdownMenuItem(
                          value: 'Female',
                          child: Text('Female'),
                        ),
                      ],
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('gender', value);
                      },
                      validator: (value) => value == null
                          ? AppLocalizations.of(context)!.gender
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.email,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.phoneNumber,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.isEmpty
                          ? AppLocalizations.of(context)!.phoneNumber
                          : null,
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('phoneNumber', value);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      obscureText: true,
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
                    ),
                    const SizedBox(height: 8),
                    PasswordStrengthIndicator(
                      password: formState.password ?? '',
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(
                          context,
                        )!.confirmPassword,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) => value != null && value != 'password'
                          ? AppLocalizations.of(context)!.confirmPassword
                          : null,
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('confirmPassword', value);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.bio,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      maxLines: 3,
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('bio', value);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.university,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('university', value);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.department,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('department', value);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.major,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        ref
                            .read(registrationFormControllerProvider.notifier)
                            .updateField('major', value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final formData = {
                    'title': ref.read(registrationFormControllerProvider).title,
                    'firstName': ref
                        .read(registrationFormControllerProvider)
                        .firstName,
                    'lastName': ref
                        .read(registrationFormControllerProvider)
                        .lastName,
                    'email': ref.read(registrationFormControllerProvider).email,
                    'phoneNumber': ref
                        .read(registrationFormControllerProvider)
                        .phoneNumber,
                    'password': ref
                        .read(registrationFormControllerProvider)
                        .password,
                    'confirmPassword': ref
                        .read(registrationFormControllerProvider)
                        .confirmPassword,
                    'bio': ref.read(registrationFormControllerProvider).bio,
                    'university': ref
                        .read(registrationFormControllerProvider)
                        .university,
                    'department': ref
                        .read(registrationFormControllerProvider)
                        .department,
                    'major': ref.read(registrationFormControllerProvider).major,
                    'preferredLanguage': ref
                        .read(registrationFormControllerProvider)
                        .preferredLanguage,
                    'gender': ref
                        .read(registrationFormControllerProvider)
                        .gender,
                  };

                  try {
                    final authRepository = ref.read(authRepositoryProvider);
                    var response = await authRepository.register(formData);
                    _formKey.currentState!.reset();
                    ref
                            .read(registrationFormControllerProvider.notifier)
                            .state =
                        RegistrationFormState();

                    final storage = ref.read(secureStorageProvider);
                    await storage.saveUserId(response.userId);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CodeVerificationPage(),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.registrationFailed,
                        ),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.registerButton),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false, // Ensures the button remains visible
    );
  }
}
