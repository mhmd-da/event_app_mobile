// import 'dart:typed_data';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';

// class AndroidDownloadsSaver {
//   static const MethodChannel _channel = MethodChannel(
//     'com.arabnet.tamkeenx/downloads',
//   );

//   static Future<String?> saveToDownloads({
//     required Uint8List bytes,
//     required String fileName,
//     required String mimeType,
//   }) async {
//     if (!defaultTargetPlatform.isAndroid) {
//       return null;
//     }

//     final result = await _channel.invokeMethod<String>('saveToDownloads', {
//       'bytes': bytes,
//       'fileName': fileName,
//       'mimeType': mimeType,
//     });
//     return result;
//   }
// }
