class AppDateTimeParsing {
  static final RegExp _hasTimezoneSuffix = RegExp(r'(Z|[+-]\d{2}:?\d{2})$');

  static String _normalize(String s) {
    var out = s.trim();
    if (out.isEmpty) return out;

    // Normalize "YYYY-MM-DD HH:mm:ss" -> "YYYY-MM-DDTHH:mm:ss"
    if (!out.contains('T') && out.contains(' ')) {
      out = out.replaceFirst(' ', 'T');
    }

    return out;
  }

  static DateTime? _tryParseInternal(
    dynamic raw, {
    required bool assumeUtcIfNoOffset,
  }) {
    final s0 = raw?.toString() ?? '';
    final s = _normalize(s0);
    if (s.isEmpty) return null;

    final hasZone = _hasTimezoneSuffix.hasMatch(s);
    final normalized = (!hasZone && assumeUtcIfNoOffset) ? '${s}Z' : s;

    // Prefer normalized form, but fall back to original raw string if needed.
    return DateTime.tryParse(normalized) ?? DateTime.tryParse(s0);
  }

  /// Parses a server date/time value and returns it in the device's local time.
  ///
  /// If the incoming string has no timezone info, it will be treated as UTC by
  /// default (because several backend endpoints emit UTC timestamps without a
  /// trailing 'Z').
  static DateTime? tryParseServerToLocal(
    dynamic raw, {
    bool assumeUtcIfNoOffset = true,
  }) {
    final parsed = _tryParseInternal(
      raw,
      assumeUtcIfNoOffset: assumeUtcIfNoOffset,
    );
    return parsed?.toLocal();
  }

  /// Same as [tryParseServerToLocal], but returns epoch (0) when parsing fails.
  static DateTime parseServerToLocalOrEpoch(
    dynamic raw, {
    bool assumeUtcIfNoOffset = true,
  }) {
    return tryParseServerToLocal(
          raw,
          assumeUtcIfNoOffset: assumeUtcIfNoOffset,
        ) ??
        DateTime.fromMillisecondsSinceEpoch(0);
  }

  /// Parses a server date/time value and returns it normalized to UTC.
  static DateTime? tryParseServerToUtc(
    dynamic raw, {
    bool assumeUtcIfNoOffset = true,
  }) {
    final parsed = _tryParseInternal(
      raw,
      assumeUtcIfNoOffset: assumeUtcIfNoOffset,
    );
    return parsed?.toUtc();
  }

  /// Same as [tryParseServerToUtc], but returns [fallback] when parsing fails.
  static DateTime parseServerToUtcOr(
    dynamic raw, {
    bool assumeUtcIfNoOffset = true,
    required DateTime fallback,
  }) {
    return tryParseServerToUtc(raw, assumeUtcIfNoOffset: assumeUtcIfNoOffset) ??
        fallback;
  }
}
