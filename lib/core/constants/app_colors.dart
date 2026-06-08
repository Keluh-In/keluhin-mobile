import 'package:flutter/material.dart';

/// Token warna Keluh In Design System v1.0.
/// Sumber tunggal — dilarang hardcode hex di luar file ini.
class AppColors {
  // ── PRIMARY — Blue ────────────────────────────────────────────
  static const Color blue50 = Color(0xFFEEF3FE);
  static const Color blue100 = Color(0xFFD8E3FD);
  static const Color blue200 = Color(0xFFB3C7FB);
  static const Color blue300 = Color(0xFF84A3F8);
  static const Color blue400 = Color(0xFF527CF4);
  static const Color blue500 = Color(0xFF2B63F0); // Primary
  static const Color blue600 = Color(0xFF1E4FD4); // Hover / pressed
  static const Color blue700 = Color(0xFF1A41AB);
  static const Color blue800 = Color(0xFF173681);
  static const Color blue900 = Color(0xFF142B5E);

  // ── NEUTRAL — Ink ─────────────────────────────────────────────
  static const Color ink0 = Color(0xFFFFFFFF);
  static const Color ink50 = Color(0xFFF6F8FB);
  static const Color ink100 = Color(0xFFEDF1F6);
  static const Color ink200 = Color(0xFFDCE3EC);
  static const Color ink300 = Color(0xFFC2CCD9);
  static const Color ink400 = Color(0xFF9AA7B8);
  static const Color ink500 = Color(0xFF708096);
  static const Color ink600 = Color(0xFF4E5C70);
  static const Color ink700 = Color(0xFF344256);
  static const Color ink800 = Color(0xFF20293B);
  static const Color ink900 = Color(0xFF18233D);
  static const Color ink950 = Color(0xFF0E1626);

  // ── SEMANTIC — Status (core / bg / text) ──────────────────────
  // Info / Baru
  static const Color baru = Color(0xFF2B63F0);
  static const Color baruBg = Color(0xFFEEF3FE);
  static const Color baruText = Color(0xFF1A41AB);
  // Warning / Diproses
  static const Color proses = Color(0xFFF59E0B);
  static const Color prosesBg = Color(0xFFFEF3E2);
  static const Color prosesText = Color(0xFFB45309);
  // Success / Selesai
  static const Color selesai = Color(0xFF16A34A);
  static const Color selesaiBg = Color(0xFFE7F6EC);
  static const Color selesaiText = Color(0xFF0F7A37);
  // Danger / Ditolak
  static const Color ditolak = Color(0xFFE23D3D);
  static const Color ditolakBg = Color(0xFFFCEAEA);
  static const Color ditolakText = Color(0xFFB42318);

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
  static const Color warning = proses;
  static const Color danger = ditolak;
  static const Color info = baru;
}
