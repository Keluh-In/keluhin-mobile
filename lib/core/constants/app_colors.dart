import 'package:flutter/material.dart';

/// Token warna Keluh In Design System (Mobile / Flutter) — bagian 2.
/// Sumber tunggal — dilarang hardcode hex di luar file ini.
class AppColors {
  // ── PRIMARY — Blue (brand #2563EB) ────────────────────────────
  static const Color blue50 = Color(0xFFEFF6FF);
  static const Color blue100 = Color(0xFFDBEAFE);
  static const Color blue200 = Color(0xFFBFDBFE);
  static const Color blue300 = Color(0xFF93C5FD);
  static const Color blue400 = Color(0xFF60A5FA);
  static const Color blue500 = Color(0xFF2563EB); // Primary
  static const Color blue600 = Color(0xFF1D4ED8); // Hover / pressed
  static const Color blue700 = Color(0xFF1E40AF);
  static const Color blue800 = Color(0xFF1E3A8A);
  static const Color blue900 = Color(0xFF172554);

  // ── NEUTRAL — Ink ─────────────────────────────────────────────
  static const Color ink0 = Color(0xFFFFFFFF);
  static const Color ink50 = Color(0xFFF7F9FB);
  static const Color ink100 = Color(0xFFEDF1F5);
  static const Color ink200 = Color(0xFFE5E7EB);
  static const Color ink300 = Color(0xFFD1D5DB);
  static const Color ink400 = Color(0xFF94A3B8);
  static const Color ink500 = Color(0xFF6B7280);
  static const Color ink600 = Color(0xFF4B5563);
  static const Color ink700 = Color(0xFF374151);
  static const Color ink800 = Color(0xFF1F2937);
  static const Color ink900 = Color(0xFF111827);

  // ── SEMANTIC — Status (core / bg / text) ──────────────────────
  // Menunggu (Amber)
  static const Color menunggu = Color(0xFFF59E0B);
  static const Color menungguBg = Color(0xFFFFF7ED);
  static const Color menungguText = Color(0xFFC2410C);
  // Diproses (Blue)
  static const Color diproses = Color(0xFF2563EB);
  static const Color diprosesBg = Color(0xFFEEF6FF);
  static const Color diprosesText = Color(0xFF1D4ED8);
  // Selesai (Green)
  static const Color selesai = Color(0xFF16A34A);
  static const Color selesaiBg = Color(0xFFECFDF5);
  static const Color selesaiText = Color(0xFF047857);
  // Ditolak (Red)
  static const Color ditolak = Color(0xFFE23D3D);
  static const Color ditolakBg = Color(0xFFFEF2F2);
  static const Color ditolakText = Color(0xFFB91C1C);

  // ── ALIAS SEMANTIK (kompat & keterbacaan) ─────────────────────
  static const Color primary = blue500;
  static const Color primaryHover = blue600;
  static const Color primarySoft = blue50;
  static const Color secondary = blue600;

  static const Color background = ink50;
  static const Color surface = ink0;
  static const Color card = ink0;
  static const Color white = ink0;
  static const Color black = ink900;

  static const Color textPrimary = ink900;
  static const Color textSecondary = ink600;
  static const Color textSubtle = ink400;

  static const Color border = ink200;
  static const Color borderStrong = ink300;
  static const Color inputFill = ink0;

  // Status alias (mapping warna app dipertahankan via Helper)
  static const Color success = selesai;
  static const Color warning = menunggu;
  static const Color danger = ditolak;
  static const Color info = diproses;
}
