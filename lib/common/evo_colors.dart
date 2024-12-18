import 'package:flutter/material.dart';

class EvoColors {
  // Prevent instantiation and extension.
  EvoColors._();

  // Primary: Purple
  static const int _primaryPrimaryValue = 0xFFC00080;
  static const MaterialColor primary =
      MaterialColor(_primaryPrimaryValue, <int, Color>{
    50: Color(0xFFFEE5F1),
    100: Color(0xFFFCCBE1),
    200: Color(0xFFF999C2),
    300: Color(0xFFF667A3),
    400: Color(0xFFF3458E),
    500: Color(_primaryPrimaryValue),
    600: Color(0xFFAE0073),
    700: Color(0xFF9D0068),
    800: Color(0xFF8D005E),
    900: Color(0xFF6E0049),
  });

  // Secondary: Cool Green
  static const int _secondaryPrimaryValue = 0xFF00A86B;
  static const MaterialColor secondary =
      MaterialColor(_secondaryPrimaryValue, <int, Color>{
    50: Color(0xFFE5F7F1),
    100: Color(0xFFBCECDC),
    200: Color(0xFF8FE0C6),
    300: Color(0xFF62D5B0),
    400: Color(0xFF40CC9F),
    500: Color(_secondaryPrimaryValue),
    600: Color(0xFF009A60),
    700: Color(0xFF008A56),
    800: Color(0xFF007A4C),
    900: Color(0xFF005C3B),
  });

  // Accent: Pinkish Orange
  static const int _accentPrimaryValue = 0xFFFA8072;
  static const MaterialColor accent =
      MaterialColor(_accentPrimaryValue, <int, Color>{
    50: Color(0xFFFFECE8),
    100: Color(0xFFFFC9BF),
    200: Color(0xFFFFA191),
    300: Color(0xFFFF7862),
    400: Color(0xFFFF5B45),
    500: Color(_accentPrimaryValue),
    600: Color(0xFFEB6E62),
    700: Color(0xFFD75F54),
    800: Color(0xFFC25147),
    900: Color(0xFF9F3C34),
  });

  // Supporting Colors
  static const error = Color(0xFFCC3333); // Red
  static const good = secondary;
}
