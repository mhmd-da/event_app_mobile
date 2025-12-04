import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/secure_storage_service.dart';
import '../data/auth_repository.dart';
import 'login_state.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());
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

      state = state.copyWith(isLoading: false, isLoggedIn: true);

    } catch (e) {
      state = state.copyWith(
          isLoading: false, errorMessage: "Login failed. Check credentials.");
    }
  }
}
