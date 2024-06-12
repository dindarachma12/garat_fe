import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tm/service/polisi_service.dart';
import 'update_laporan_page.dart';
import 'laporan_polisi.dart';
import 'package:flutter_tm/widget/styles.dart';

class ReadLaporanPage extends StatefulWidget {
  @override
  _ReadLaporanPageState createState() => _ReadLaporanPageState();
}

class _ReadLaporanPageState extends State<ReadLaporanPage> {
  late Future<List<Laporan>> _futureLaporan;

  @override
  void initState() {
    super.initState();
    _futureLaporan = _fetchLaporan();
  }

  Future<int> _getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int idUser = prefs.getInt('id_user') ?? 0;
    return idUser;
  }

  Future<List<Laporan>> _fetchLaporan() async {
    int idUser = await _getIdUser();
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/polisiUser/$idUser'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Laporan.fromJson(data)).toList();
    } else {
      throw Exception('Belum ada laporan yang dibuat!');
    }
  }

  Future<void> deleteLaporan(int id) async {
    final response =
        await http.delete(Uri.parse('http://127.0.0.1:8000/api/polisis/$id'));

    if (response.statusCode == 200) {
      setState(() {
        _futureLaporan = _fetchLaporan();
      });
    } else {
      throw Exception('Failed to delete laporan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      appBar: AppBar(
        backgroundColor: AppColors.red,
        title: Text('Laporan Polisi', style: TextStyles.title.copyWith(color: Colors.white)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 25),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 25.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: AppColors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder<List<Laporan>>(
                        future: _futureLaporan,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Laporan>? laporan = snapshot.data;
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: laporan?.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          laporan![index].pelapor,
                                          style: TextStyles.title.copyWith(
                                            color: AppColors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(laporan[index].noHp),
                                        SizedBox(height: 5),
                                        Text(laporan[index].alamat),
                                        SizedBox(height: 5),
                                        Text(laporan[index].keterangan),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.edit,
                                                  color: AppColors.red),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateLaporanPage(
                                                      laporan: laporan[index],
                                                    ),
                                                  ),
                                                ).then((_) {
                                                  setState(() {
                                                    _futureLaporan =
                                                        _fetchLaporan();
                                                  });
                                                });
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: AppColors.red),
                                              onPressed: () {
                                                deleteLaporan(
                                                    laporan[index].id);
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Center(child: Text("${snapshot.error}"));
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LaporanPolisi(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(AppColors.red),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                            ),
                          ),
                          child: Text(
                            'Tambahkan Laporan',
                            style:
                                TextStyle(color: AppColors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
