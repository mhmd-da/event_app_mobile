import 'package:event_app/core/network/api_client_provider.dart';
import 'package:event_app/features/auth/domain/unverified_account_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../data/auth_repository.dart';
import 'login_state.dart';

part 'login_controller.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    AuthRepository(ref.watch(apiClientProvider));

@Riverpod(keepAlive: true)
SecureStorageService secureStorage(Ref ref) => SecureStorageService();

@Riverpod(keepAlive: true)
class LoginController extends _$LoginController {
  @override
  LoginState build() => LoginState();

  AuthRepository get _repo => ref.watch(authRepositoryProvider);
  SecureStorageService get _storage => ref.watch(secureStorageProvider);

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final auth = await _repo.login(username, password);
      await _storage.saveAuth(auth);
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        isLoggedIn: true,
        requiresVerification: false,
      );
    } on UnverifiedAccountException catch (e) {
      if (e.userId != null) {
        await _storage.saveUserId(e.userId!);
      }
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        requiresVerification: true,
        isLoggedIn: false,
      );
    } catch (e) {
      if (!ref.mounted) return;
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
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, isLoggedIn: true);
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> forgotPasswordRequest(String username) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final response = await _repo.forgetPassword(username);
      await _storage.saveUserId(response.userId);
      if (!ref.mounted) return true;
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      if (!ref.mounted) return false;
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<void> resetPassword(String code, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final userId = await _storage.getUserId();
      final auth = await _repo.resetPassword(userId, password, code);
      await _storage.saveAuth(auth);
      state = state.copyWith(isLoading: false, errorMessage: null);
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, isLoggedIn: true);
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _storage.clear();
      if (!ref.mounted) return;
      state = state.copyWith(isLoading: false, isLoggedIn: false);
    } catch (e) {
      if (!ref.mounted) return;
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Logout failed. Please try again.",
      );
    }
  }
}
