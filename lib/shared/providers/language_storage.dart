import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  static const _key = "app_locale";

  Future<void> saveLocale(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, langCode);
  }

  Future<String?> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key);
  }
}
