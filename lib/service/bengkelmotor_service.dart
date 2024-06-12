import 'dart:convert';
import 'package:http/http.dart' as http;

class Motor {
  final int id;
  final String nama;
  final String alamat;
  // final String pemilik;
  // final String deskripsi;

  Motor({
    required this.id,
    required this.nama,
    required this.alamat,
    // required this.pemilik,
    // required this.deskripsi,
  });

  factory Motor.fromJson(Map<String, dynamic> json) {
    return Motor(
      id: json['id_bengkel_motor'],
      nama: json['nama_bengkel'],
      alamat: json['alamat'],
      // pemilik: json['pemilik'],
      // deskripsi: json['deskripsi'],
    );
  }
}

Future<List<Motor>> fetchMotor() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/bengkel_motors'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((motor) => Motor.fromJson(motor)).toList();
  } else {
    throw Exception('Failed to load bengkel motor');
  }
}

Future<Motor> fetchMotorDetail(int id) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/bengkel_motors/$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Motor.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load bengkel motor');
  }
}
