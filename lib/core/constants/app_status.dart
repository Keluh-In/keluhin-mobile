/// Status pengaduan — kontrak data dengan backend (bagian 6 & 9).
/// Nilai enum API (lowercase) dipisah dari label tampil.
class AppStatus {
  // ── NILAI ENUM API (kontrak backend) ──────────────────────────
  static const String menunggu = 'menunggu';
  static const String diproses = 'diproses';
  static const String selesai = 'selesai';
  static const String ditolak = 'ditolak';

  /// Urutan enum API resmi.
  static const List<String> values = [
    menunggu,
    diproses,
    selesai,
    ditolak,
  ];

  // ── LABEL TAMPIL ──────────────────────────────────────────────
  static const Map<String, String> labels = {
    menunggu: 'Menunggu',
    diproses: 'Diproses',
    selesai: 'Selesai',
    ditolak: 'Ditolak',
  };

  /// Label tampil dari nilai enum API. Fallback: nilai apa adanya.
  static String label(String status) =>
      labels[status.toLowerCase()] ?? status;
}
