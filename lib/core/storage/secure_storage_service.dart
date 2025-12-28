import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../features/auth/domain/auth_model.dart';

class SecureStorageService {
  final storage = const FlutterSecureStorage();

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
    return await storage.read(key: "token");
  }

  Future<int> getEventId() async {
    var key = await storage.read(key: "event_id");
    if (key == null) return 1;

    return int.parse(key);
  }

  Future<int> getUserId() async {
    var key = await storage.read(key: "user_id");
    if (key == null) return 0;

    return int.parse(key);
  }

  Future<String?> getFcmToken() async {
    return await storage.read(key: "fcm_token");
  }

  Future<String?> getExpiry() async {
    return await storage.read(key: "expiry");
  }

  Future<String?> getQrCodeGuid() async {
    return await storage.read(key: "qr_code_guid");
  }

  Future<bool> isValidToken() async {
    var expiry = await getExpiry();
    if (expiry == null) return false;

    var date = DateTime.parse(expiry);
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
}
