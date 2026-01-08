import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';

class SecureStorageService {
  final FlutterSecureStorage storage;

  SecureStorageService({FlutterSecureStorage? storage})
    : storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(
              // Prevent fatal crashes on some OEM devices when the keystore key
              // becomes invalid or ciphertext is corrupted.
              // This will PERMANENTLY erase stored values on error.
              resetOnError: true,
            ),
          );

  Future<String?> _readKey(String key) async {
    try {
      return await storage.read(key: key);
    } on PlatformException {
      return null;
    } catch (_) {
      return null;
    }
  }

  // Event ID methods (app no longer uses auth, defaults to event 1)
  Future<int> getEventId() async {
    var key = await _readKey("event_id");
    if (key == null) return 1;
    return int.tryParse(key) ?? 1;
  }

  Future<void> saveEventId(int eventId) async {
    await storage.write(key: "event_id", value: eventId.toString());
  }

  // User ID methods (for chat/QR features that may need user identification)
  Future<int> getUserId() async {
    var key = await _readKey("user_id");
    if (key == null) return 0;
    return int.tryParse(key) ?? 0;
  }

  Future<void> saveUserId(int userId) async {
    await storage.write(key: "user_id", value: userId.toString());
  }

  // QR Code GUID
  Future<String?> getQrCodeGuid() async {
    return _readKey("qr_code_guid");
  }

  Future<void> saveQrCodeGuid(String guid) async {
    await storage.write(key: "qr_code_guid", value: guid);
  }

  // Clear all storage
  Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
