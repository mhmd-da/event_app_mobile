import 'package:flutter/material.dart';

class AppTextStyles {

  static TextStyle headlineLarge = const TextStyle(
    fontSize: 24, // standard for main section headers
    fontWeight: FontWeight.w700,
    height: 1.32,
  );

  static TextStyle headlineMedium = const TextStyle(
    fontSize: 18, // subsection headers
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle headlineSmall = const TextStyle(
    fontSize: 16, // small headers like card titles
    fontWeight: FontWeight.w600,
    height: 1.38,
  );

  static TextStyle headlineTine = const TextStyle(
    fontSize: 15, // small headers like card titles
    fontWeight: FontWeight.w500,
    height: 1.36,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 15, // main paragraph text
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodySmall = const TextStyle(
    fontSize: 13, // captions or secondary text
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static TextStyle bodyTiny = const TextStyle(
    fontSize: 12, // helper text, footnotes, tags
    fontWeight: FontWeight.w300,
    height: 1.3,
  );

}
