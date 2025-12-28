import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'registration_providers.g.dart';

class RegistrationFormState {
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? userIdentifier;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? confirmPassword;
  final String? gender;

  const RegistrationFormState({
    this.title,
    this.firstName,
    this.lastName,
    this.userIdentifier,
    this.email,
    this.phoneNumber,
    this.password,
    this.confirmPassword,
    this.gender,
  });

  RegistrationFormState copyWith({
    String? title,
    String? firstName,
    String? lastName,
    String? userIdentifier,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? gender,
  }) {
    return RegistrationFormState(
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userIdentifier: userIdentifier ?? this.userIdentifier,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender,
    );
  }
}

@Riverpod(keepAlive: true)
class RegistrationFormController extends _$RegistrationFormController {
  @override
  RegistrationFormState build() => const RegistrationFormState();

  void updateField(String field, String? value) {
    state = state.copyWith(
      title: field == 'title' ? value : state.title,
      firstName: field == 'firstName' ? value : state.firstName,
      lastName: field == 'lastName' ? value : state.lastName,
      userIdentifier: field == 'userIdentifier' ? value : state.userIdentifier,
      email: field == 'email' ? value : state.email,
      phoneNumber: field == 'phoneNumber' ? value : state.phoneNumber,
      password: field == 'password' ? value : state.password,
      confirmPassword: field == 'confirmPassword' ? value : state.confirmPassword,
      gender: field == 'gender' ? value : state.gender,
    );
  }

  void reset() {
    state = const RegistrationFormState();
  }
}
