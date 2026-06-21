class ComplaintStatsModel {
  final int total;

  final int menunggu;

  final int diproses;

  final int selesai;

  final int ditolak;

  ComplaintStatsModel({
    required this.total,
    required this.menunggu,
    required this.diproses,
    required this.selesai,
    required this.ditolak,
  });

  factory ComplaintStatsModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ComplaintStatsModel(
      total: json['total'] ?? 0,

      menunggu: json['menunggu'] ?? 0,

      diproses: json['diproses'] ?? 0,

      selesai: json['selesai'] ?? 0,

      ditolak: json['ditolak'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'menunggu': menunggu,
      'diproses': diproses,
      'selesai': selesai,
      'ditolak': ditolak,
    };
  }

  ComplaintStatsModel copyWith({
    int? total,
    int? menunggu,
    int? diproses,
    int? selesai,
    int? ditolak,
  }) {
    return ComplaintStatsModel(
      total: total ?? this.total,
      menunggu: menunggu ?? this.menunggu,
      diproses: diproses ?? this.diproses,
      selesai: selesai ?? this.selesai,
      ditolak: ditolak ?? this.ditolak,
    );
  }
}
