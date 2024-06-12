import 'dart:convert';
import 'package:http/http.dart' as http;

class Tip {
  final int id;
  final String judul;
  final String keterangan;
  final String? foto;

  Tip({required this.id, required this.judul, required this.keterangan, this.foto});

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      id: json['id_tips'],
      judul: json['judul'],
      keterangan: json['keterangan'],
      foto: json['foto'],
    );
  }
}

Future<List<Tip>> fetchTips() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/tips_tricks'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((tip) => Tip.fromJson(tip)).toList();
  } else {
    throw Exception('Failed to load tips');
  }
}

Future<Tip> fetchTipDetail(int id) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/tips_tricks/$id'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Tip.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load tip detail');
  }
}
