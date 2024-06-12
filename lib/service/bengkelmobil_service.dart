import 'dart:convert';
import 'package:http/http.dart' as http;

class Mobil {
  final int id;
  final String nama;
  final String alamat;
  // final String pemilik;
  // final String deskripsi;

  Mobil({
    required this.id,
    required this.nama,
    required this.alamat,
    // required this.pemilik,
    // required this.deskripsi,
  });

  factory Mobil.fromJson(Map<String, dynamic> json) {
    return Mobil(
      id: json['id_bengkel_mobil'],
      nama: json['nama_bengkel'],
      alamat: json['alamat'],
      // pemilik: json['pemilik'],
      // deskripsi: json['deskripsi'],
    );
  }
}

Future<List<Mobil>> fetchMobil() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/bengkel_mobils'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((mobil) => Mobil.fromJson(mobil)).toList();
  } else {
    throw Exception('Failed to load bengkel mobil');
  }
}

Future<Mobil> fetchMobilDetail(int id) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/bengkel_mobils/$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Mobil.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load bengkel mobil');
  }
}
