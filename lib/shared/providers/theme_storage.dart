import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  static const _key = 'app_theme_mode';

  Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode);
  }

  Future<String?> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}
