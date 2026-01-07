import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'timezone_storage.dart';

part 'timezone_provider.g.dart';

/// Stored as:
/// - 'system' to follow device timezone
/// - otherwise a stringified integer representing offset minutes from UTC
///   (e.g. '180' for UTC+03:00)
const String kTimezoneSystem = 'system';

@Riverpod(keepAlive: true)
TimezoneStorage timezoneStorage(Ref ref) => const TimezoneStorage();

@Riverpod(keepAlive: true)
class AppTimezonePreference extends _$AppTimezonePreference {
  @override
  String build() => kTimezoneSystem;

  void set(String value) => state = value;
}

String formatUtcOffsetMinutes(int minutes) {
  final isNegative = minutes < 0;
  final abs = minutes.abs();
  final h = abs ~/ 60;
  final m = abs % 60;
  final sign = isNegative ? '-' : '+';
  final hh = h.toString().padLeft(2, '0');
  final mm = m.toString().padLeft(2, '0');
  return 'UTC$sign$hh:$mm';
}

List<String> buildTimezoneOptions() {
  // 15-minute steps cover all real-world offsets (-12:00 .. +14:00).
  const int minMinutes = -12 * 60;
  const int maxMinutes = 14 * 60;
  const int stepMinutes = 15;

  final options = <String>[kTimezoneSystem];
  for (
    int minutes = minMinutes;
    minutes <= maxMinutes;
    minutes += stepMinutes
  ) {
    options.add(minutes.toString());
  }
  return options;
}
