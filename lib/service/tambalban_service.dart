import 'dart:convert';
import 'package:http/http.dart' as http;

class TambalBan {
  final int id;
  final String nama;
  final String alamat;
  // final String pemilik;
  // final String deskripsi;

  TambalBan({
    required this.id,
    required this.nama,
    required this.alamat,
    // required this.pemilik,
    // required this.deskripsi,
  });

  factory TambalBan.fromJson(Map<String, dynamic> json) {
    return TambalBan(
      id: json['id_tambal_ban'],
      nama: json['nama_tambal_ban'],
      alamat: json['alamat'],
      // pemilik: json['pemilik'],
      // deskripsi: json['deskripsi'],
    );
  }
}

Future<List<TambalBan>> fetchTambalBans() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/tambal_bans'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((tambalBan) => TambalBan.fromJson(tambalBan)).toList();
  } else {
    throw Exception('Failed to load tambal bans');
  }
}

Future<TambalBan> fetchBanDetail(int id) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/tambal_bans/$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return TambalBan.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load tambal ban');
  }
}
