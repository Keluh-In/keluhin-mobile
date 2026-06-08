import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Token tipografi Keluh In — Poppins. Skala mengikuti design system.
/// height = line-height / font-size.
class AppTypography {
  static const String fontFamily = 'Poppins';

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;

  static TextStyle _base(double size, double lineHeight, FontWeight weight) =>
      GoogleFonts.poppins(
        fontSize: size,
        height: lineHeight / size,
        fontWeight: weight,
        color: AppColors.ink900,
      );

  static TextStyle get display => _base(40, 48, semibold);
  static TextStyle get heading1 => _base(32, 40, semibold);
  static TextStyle get heading2 => _base(24, 32, semibold);
  static TextStyle get heading3 => _base(20, 28, semibold);
  static TextStyle get bodyLarge => _base(18, 28, regular);
  static TextStyle get body => _base(16, 26, regular);
  static TextStyle get bodySmall => _base(14, 22, regular);
  static TextStyle get caption => _base(12, 18, medium);
  static TextStyle get button => _base(16, 24, semibold);

  /// TextTheme untuk ThemeData.
  static TextTheme textTheme = TextTheme(
    displayLarge: display,
    headlineLarge: heading1,
    headlineMedium: heading2,
    headlineSmall: heading3,
    titleLarge: heading3,
    bodyLarge: bodyLarge,
    bodyMedium: body,
    bodySmall: bodySmall,
    labelLarge: button,
    labelSmall: caption,
  );
}
