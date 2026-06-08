import 'package:flutter/material.dart';

/// Token elevation Keluh In. Warna bayangan basis ink-950 (#0E1626).
class AppElevation {
  static const Color _shadowColor = Color(0xFF0E1626);

  /// shadow-1 — kartu, list item.
  static const List<BoxShadow> shadow1 = [
    BoxShadow(
      color: Color(0x0F0E1626), // .06
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Color(0x140E1626), // .08
      offset: Offset(0, 1),
      blurRadius: 3,
    ),
  ];

  /// shadow-2 — dropdown, popover.
  static const List<BoxShadow> shadow2 = [
    BoxShadow(
      color: Color(0x140E1626), // .08
      offset: Offset(0, 4),
      blurRadius: 14,
    ),
  ];

  /// shadow-3 — modal, sheet.
  static const List<BoxShadow> shadow3 = [
    BoxShadow(
      color: Color(0x1F0E1626), // .12
      offset: Offset(0, 14),
      blurRadius: 32,
    ),
  ];

  // Elevation numerik untuk widget Material (Card, dll).
  static const double e1 = 1;
  static const double e2 = 4;
  static const double e3 = 14;

  static Color get shadowColor => _shadowColor;
}
