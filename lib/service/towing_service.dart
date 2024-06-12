import 'dart:convert';
import 'package:http/http.dart' as http;

class TowingService {
  final int id;
  final String nama;
  final String alamat;
  // final String pemilik;
  // final String deskripsi;

  TowingService({
    required this.id,
    required this.nama,
    required this.alamat,
    // required this.pemilik,
    // required this.deskripsi,
  });

  factory TowingService.fromJson(Map<String, dynamic> json) {
    return TowingService(
      id: json['id_towing'],
      nama: json['nama_bengkel'],
      alamat: json['alamat'],
      // pemilik: json['pemilik'],
      // deskripsi: json['deskripsi'],
    );
  }
}

Future<List<TowingService>> fetchTowingData() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/towings'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((towing) => TowingService.fromJson(towing)).toList();
  } else {
    throw Exception('Failed to load towing');
  }
}

Future<TowingService> fetchTowingDetail(int id) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/towings/$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return TowingService.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load towing');
  }
}
