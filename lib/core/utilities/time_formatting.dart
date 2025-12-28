import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

class AppTimeFormatting {
  static const String _lri = '\u2066';
  static const String _pdi = '\u2069';

  static String _localeTag(BuildContext context) {
    return Localizations.localeOf(context).toLanguageTag();
  }

  /// Isolates a string as LTR so it doesn't get re-ordered in RTL layouts.
  /// Useful when you must pass a String (e.g. calendar widgets).
  static String ltrIsolate(String text) => '$_lri$text$_pdi';

  static String formatTime(BuildContext context, DateTime dateTime) {
    return DateFormat.jm(_localeTag(context)).format(dateTime.toLocal());
  }

  static String formatTimeHm(BuildContext context, DateTime dateTime) {
    return DateFormat.Hm(_localeTag(context)).format(dateTime.toLocal());
  }

  static String formatHourAmPm(BuildContext context, DateTime dateTime) {
    return DateFormat('h a', _localeTag(context)).format(dateTime.toLocal());
  }

  static String formatDateYMMMd(BuildContext context, DateTime dateTime) {
    return DateFormat.yMMMd(_localeTag(context)).format(dateTime.toLocal());
  }

  static String formatDateMd(BuildContext context, DateTime dateTime) {
    return DateFormat.yMd(_localeTag(context)).format(dateTime.toLocal());
  }

  static String formatDayLabelEeeD(BuildContext context, DateTime dateTime) {
    return DateFormat('EEE d', _localeTag(context)).format(dateTime.toLocal());
  }

  static String formatShortMonthDay(BuildContext context, DateTime dateTime) {
    return DateFormat('MMM d', _localeTag(context)).format(dateTime.toLocal());
  }

  static String formatDateTimeYMMMdJm(BuildContext context, DateTime dateTime) {
    return DateFormat.yMMMd(
      _localeTag(context),
    ).add_jm().format(dateTime.toLocal());
  }

  static String formatTimeRange(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
  }) {
    final startText = formatTime(context, start);
    final endText = formatTime(context, end);
    return '$startText – $endText';
  }

  static String formatDateRangeYMMMd(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
  }) {
    final startText = formatDateYMMMd(context, start);
    final endText = formatDateYMMMd(context, end);
    return '$startText – $endText';
  }

  /// Wraps the time range in LTR direction so it renders correctly in RTL locales.
  static Widget timeRangeText(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
    TextStyle? style,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        formatTimeRange(context, start: start, end: end),
        style: style,
      ),
    );
  }

  static Widget timeText(
    BuildContext context, {
    required DateTime time,
    TextStyle? style,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(formatTime(context, time), style: style),
    );
  }

  static Widget hourText(
    BuildContext context, {
    required DateTime time,
    TextStyle? style,
    TextAlign? textAlign,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        formatHourAmPm(context, time),
        style: style,
        textAlign: textAlign,
      ),
    );
  }

  static Widget dateTimeTextYMMMdJm(
    BuildContext context, {
    required DateTime dateTime,
    TextStyle? style,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(formatDateTimeYMMMdJm(context, dateTime), style: style),
    );
  }

  static Widget dateRangeTextYMMMd(
    BuildContext context, {
    required DateTime start,
    required DateTime end,
    TextStyle? style,
  }) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Text(
        formatDateRangeYMMMd(context, start: start, end: end),
        style: style,
      ),
    );
  }
}
