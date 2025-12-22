import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';

void logInfo(String message) {
  final ts = DateTime.now().toIso8601String();
  final line = '[INFO] $ts | $message';
  debugPrint(line);
  dev.log(line, name: 'event_app');
}

void logError(String message, Object? error, [StackTrace? stackTrace]) {
  final ts = DateTime.now().toIso8601String();
  final line = '[ERROR] $ts | $message | ${error ?? ''}';
  debugPrint(line);
  dev.log(line, name: 'event_app', error: error, stackTrace: stackTrace);
}
