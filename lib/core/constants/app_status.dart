class AppStatus {
  // STATUS PENGADUAN
  static const String waiting =
      'Menunggu';

  static const String processing =
      'Diproses';

  static const String completed =
      'Selesai';

  static const String rejected =
      'Ditolak';

  // LIST STATUS
  static const List<String>
      complaintStatus = [
    waiting,
    processing,
    completed,
    rejected,
  ];
}