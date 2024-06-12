class Laporan {
  final int id;
  final String pelapor;
  final String noHp;
  final String alamat;
  final String keterangan;
  final int id_user;

  Laporan({
    required this.id,
    required this.pelapor,
    required this.noHp,
    required this.alamat,
    required this.keterangan,
    required this.id_user
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      id: json['id_laporan'],
      pelapor: json['pelapor'],
      noHp: json['no_hp'],
      alamat: json['alamat'],
      keterangan: json['keterangan'],
      id_user: json['id_user']
    );
  }
}
