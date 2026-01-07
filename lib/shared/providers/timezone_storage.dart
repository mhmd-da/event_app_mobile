import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TimezoneStorage {
  static const _key = 'timezone_preference';
  final FlutterSecureStorage _storage;

  const TimezoneStorage({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(resetOnError: true),
          );

  Future<String?> loadTimezonePreference() async {
    return _storage.read(key: _key);
  }

  Future<void> saveTimezonePreference(String value) async {
    await _storage.write(key: _key, value: value);
  }
}
