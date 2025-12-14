import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/auth/domain/auth_model.dart';
import 'package:event_app/features/auth/domain/unverified_account_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../data/auth_repository.dart';
import 'login_state.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(ref.watch(apiClientProvider)));
final secureStorageProvider = Provider((ref) => SecureStorageService());

final loginControllerProvider =
StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(
    ref.watch(authRepositoryProvider),
    ref.watch(secureStorageProvider),
  );
});

class LoginController extends StateNotifier<LoginState> {
  final AuthRepository _repo;
  final SecureStorageService _storage;

  LoginController(this._repo, this._storage) : super(LoginState());

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final auth = await _repo.login(username, password);
      await _storage.saveAuth(auth);

      state = state.copyWith(isLoading: false, isLoggedIn: true, requiresVerification: false);

    } on UnverifiedAccountException catch (e) {
      if (e.userId != null) {
        await _storage.saveUserId(e.userId!);
      }
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        requiresVerification: true,
        isLoggedIn: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        requiresVerification: false,
      );
    }
  }

  Future<void> loginWithCode(String otp) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {

      final auth = await _repo.verifyCode(await _storage.getUserId(), otp);

      await _storage.saveAuth(auth);

      state = state.copyWith(isLoading: false, isLoggedIn: true);

    } catch (e) {
      state = state.copyWith(
          isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _storage.clear();

      state = state.copyWith(isLoading: false, isLoggedIn: false);

    } catch (e) {
      state = state.copyWith(
          isLoading: false, errorMessage: "Logout failed. Please try again.");
    }
  }
}
