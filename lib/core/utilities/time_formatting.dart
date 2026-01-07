import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class AppTimeFormatting {
  static const String _lri = '\u2066';
  static const String _pdi = '\u2069';

  static DateTime _applyTimezonePreference(
    DateTime dateTime,
    String? timezonePreference,
  ) {
    if (timezonePreference == null || timezonePreference == 'system') {
      return dateTime.toLocal();
    }

    final offsetMinutes = int.tryParse(timezonePreference);
    if (offsetMinutes == null) return dateTime.toLocal();

    // Represent the same instant in a fixed-offset "display timezone" by
    // shifting the UTC time. We intentionally do not call toLocal() after this.
    return dateTime.toUtc().add(Duration(minutes: offsetMinutes));
  }

  /// Converts an instant to the user-selected "display timezone".
  ///
  /// - `timezonePreference == null` or `'system'` -> device local time.
  /// - otherwise must be an integer string offset in minutes from UTC.
  static DateTime toDisplayTime(
    DateTime dateTime, {
    String? timezonePreference,
  }) {
    if (timezonePreference == null || timezonePreference == 'system') {
      return dateTime.toLocal();
    }

    final offsetMinutes = int.tryParse(timezonePreference);
    if (offsetMinutes == null) return dateTime.toLocal();

    final shifted = dateTime.toUtc().add(Duration(minutes: offsetMinutes));
    return DateTime(
      shifted.year,
      shifted.month,
      shifted.day,
      shifted.hour,
      shifted.minute,
      shifted.second,
      shifted.millisecond,
      shifted.microsecond,
    );
  }

  static String _localeTag(BuildContext context) {
    return Localizations.localeOf(context).toLanguageTag();
  }

  /// Isolates a string as LTR so it doesn't get re-ordered in RTL layouts.
  /// Useful when you must pass a String (e.g. calendar widgets).
  static String ltrIsolate(String text) => '$_lri$text$_pdi';

  static String formatTime(
    BuildContext context,
    DateTime dateTime, {
    String? timezonePreference,
  }) {
    final dt = _applyTimezonePreference(dateTime, timezonePreference);
    return DateFormat.jm(_localeTag(context)).format(dt);
  }

  static String formatTimeHm(
    BuildContext context,
    DateTime dateTime, {
    String? timezonePreference,
  }) {
    final dt = _applyTimezonePreference(dateTime, timezonePreference);
    return DateFormat.Hm(_localeTag(context)).format(dt);
  }

  static String formatHourAmPm(
    BuildContext context,
    DateTime dateTime, {
    String? timezonePreference,
  }) {
    final dt = _applyTimezonePreference(dateTime, timezonePreference);
    return DateFormat('h a', _localeTag(context)).format(dt);
  }

  static String formatDateYMMMd(
    BuildContext context,
    DateTime dateTime, {
    String? timezonePreference,
  }) {
    final dt = _applyTimezonePreference(dateTime, timezonePreference);
    return DateFormat.yMMMd(_localeTag(context)).format(dt);
  }

  static String formatDateMd(
    BuildContext context,
    DateTime dateTime, {
    String? timezonePreference,
  }) {
    final dt = _applyTimezonePreference(dateTime, timezonePreference);
    return DateFormat.yMd(_localeTag(context)).format(dt);
  }

  static String formatDayLabelEeeD(
    BuildContext context,
    DateTime dateTime, {
    String? timezonePreference,
  }) {
    final dt = _applyTimezonePreference(dateTime, timezonePreference);
    return DateFormat('EEE d', _localeTag(context)).format(dt);
  }

  static String formatShortMonthDay(
    BuildContext context,
    DateTime dateTime, {
    String? timezonePreference,
  }) {
    final dt = _applyTimezonePreference(dateTime, timezonePreference);
    return DateFormat('MMM d', _localeTag(context)).format(dt);
  }

  static String formatDateTimeYMMMdJm(
    BuildContext context,
    DateTime dateTime, {
    String? timezonePreference,
  }) {
    final dt = _applyTimezonePreference(dateTime, timezonePreference);
    return DateFormat.yMMMd(_localeTag(context)).add_jm().format(dt);
  }

  static String formatTimeRange(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
    String? timezonePreference,
  }) {
    final startText = formatTime(
      context,
      start,
      timezonePreference: timezonePreference,
    );
    final endText = formatTime(
      context,
      end,
      timezonePreference: timezonePreference,
    );
    return '$startText – $endText';
  }

  static String formatDateRangeYMMMd(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
    String? timezonePreference,
  }) {
    final startText = formatDateYMMMd(
      context,
      start,
      timezonePreference: timezonePreference,
    );
    final endText = formatDateYMMMd(
      context,
      end,
      timezonePreference: timezonePreference,
    );
    return '$startText – $endText';
  }

  /// Wraps the time range in LTR direction so it renders correctly in RTL locales.
  static Widget timeRangeText(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
    TextStyle? style,
    String? timezonePreference,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        formatTimeRange(
          context,
          start: start,
          end: end,
          timezonePreference: timezonePreference,
        ),
        style: style,
      ),
    );
  }

  static Widget timeText(
    BuildContext context, {
    required DateTime time,
    TextStyle? style,
    String? timezonePreference,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        formatTime(context, time, timezonePreference: timezonePreference),
        style: style,
      ),
    );
  }

  static Widget hourText(
    BuildContext context, {
    required DateTime time,
    TextStyle? style,
    TextAlign? textAlign,
    String? timezonePreference,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        formatHourAmPm(context, time, timezonePreference: timezonePreference),
        style: style,
        textAlign: textAlign,
      ),
    );
  }

  static Widget dateTimeTextYMMMdJm(
    BuildContext context, {
    required DateTime dateTime,
    TextStyle? style,
    String? timezonePreference,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        formatDateTimeYMMMdJm(
          context,
          dateTime,
          timezonePreference: timezonePreference,
        ),
        style: style,
      ),
    );
  }

  static Widget dateRangeTextYMMMd(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
    TextStyle? style,
    String? timezonePreference,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        formatDateRangeYMMMd(
          context,
          start: start,
          end: end,
          timezonePreference: timezonePreference,
        ),
        style: style,
      ),
    );
  }
}
