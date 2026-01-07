import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../features/auth/domain/auth_model.dart';

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

  Future<void> saveAuth(AuthModel auth) async {
    await storage.write(key: "token", value: auth.token);
    await storage.write(
      key: "expiry",
      value: auth.expiryDate.toIso8601String(),
    );

    // Decode JWT
    Map<String, dynamic> decoded = JwtDecoder.decode(auth.token);
    // Extract event_id claim
    var eventId = decoded["event_id"];
    // Save it if exists
    if (eventId != null) {
      await storage.write(key: "event_id", value: eventId.toString());
    }
    // Extract qr_code_id claim
    var qrCodeId = decoded["qr_code_guid"];
    // Save it if exists
    if (qrCodeId != null) {
      await storage.write(key: "qr_code_guid", value: qrCodeId.toString());
    }
  }

  Future<void> saveUserId(int userId) async {
    await storage.write(key: "user_id", value: userId.toString());
  }

  Future<void> saveFcmToken(String fcmToken) async {
    await storage.write(key: "fcm_token", value: fcmToken);
  }

  Future<String?> getToken() async {
    return _readKey("token");
  }

  Future<int> getEventId() async {
    var key = await _readKey("event_id");
    if (key == null) return 1;
    return int.tryParse(key) ?? 1;
  }

  Future<int> getUserId() async {
    var key = await _readKey("user_id");
    if (key == null) return 0;

    return int.tryParse(key) ?? 0;
  }

  Future<String?> getFcmToken() async {
    return _readKey("fcm_token");
  }

  Future<String?> getExpiry() async {
    return _readKey("expiry");
  }

  Future<String?> getQrCodeGuid() async {
    return _readKey("qr_code_guid");
  }

  Future<bool> isValidToken() async {
    var expiry = await getExpiry();
    if (expiry == null) return false;

    final date = DateTime.tryParse(expiry);
    if (date == null) return false;
    if (DateTime.now().isAfter(date)) return false;

    return true;
  }

  Future<void> clear() async {
    // Clear only authentication-related keys; keep FCM token so we can re-register after login
    await storage.delete(key: "token");
    await storage.delete(key: "expiry");
    await storage.delete(key: "event_id");
    await storage.delete(key: "user_id");
    await storage.delete(key: "qr_code_guid");
  }

  /// Clears everything stored by this app in FlutterSecureStorage.
  /// Useful as a last-resort recovery if reads start throwing decryption errors.
  Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
