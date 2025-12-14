class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;
  final bool requiresVerification;

  LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.isLoggedIn = false,
    this.requiresVerification = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
    bool? requiresVerification,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      requiresVerification: requiresVerification ?? this.requiresVerification,
    );
  }
}
