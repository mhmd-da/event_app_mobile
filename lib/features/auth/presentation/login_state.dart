class LoginState {
  final bool isLoading;
  final String? errorMessage;
  final bool isLoggedIn;

  LoginState({
    this.isLoading = false,
    this.errorMessage,
    this.isLoggedIn = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isLoggedIn,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
