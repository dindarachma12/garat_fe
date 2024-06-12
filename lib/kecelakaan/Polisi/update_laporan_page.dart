import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tm/service/polisi_service.dart';
import 'package:flutter_tm/widget/styles.dart';

class UpdateLaporanPage extends StatefulWidget {
  final Laporan laporan;

  UpdateLaporanPage({required this.laporan});

  @override
  _UpdateLaporanPageState createState() => _UpdateLaporanPageState();
}

class _UpdateLaporanPageState extends State<UpdateLaporanPage> {
  late TextEditingController _pelaporController;
  late TextEditingController _noHpController;
  late TextEditingController _alamatController;
  late TextEditingController _keteranganController;

  @override
  void initState() {
    super.initState();
    _pelaporController = TextEditingController(text: widget.laporan.pelapor);
    _noHpController = TextEditingController(text: widget.laporan.noHp);
    _alamatController = TextEditingController(text: widget.laporan.alamat);
    _keteranganController =
        TextEditingController(text: widget.laporan.keterangan);
  }

  Future<void> _updateLaporan() async {
    final Map<String, String> data = {
      'pelapor': _pelaporController.text,
      'no_hp': _noHpController.text,
      'alamat': _alamatController.text,
      'keterangan': _keteranganController.text,
    };

    final response = await http.put(
      Uri.parse('http://127.0.0.1:8000/api/polisis/${widget.laporan.id}'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      throw Exception('Failed to update laporan');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      appBar: AppBar(
        backgroundColor: AppColors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Update Laporan',
          style: TextStyles.title.copyWith(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              color: AppColors.red,
              // child: Text(
              //   'Update Laporan',
              //   style: TextStyles.title.copyWith(
              //     color: Colors.white,
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    buildTextField('Pelapor', _pelaporController),
                    buildTextField('No HP', _noHpController),
                    buildTextField('Alamat', _alamatController),
                    buildTextField('Keterangan', _keteranganController),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: _updateLaporan,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(AppColors.red),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15),
                          ),
                        ),
                        child: Text(
                          'Update',
                          style: TextStyles.title.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.body.copyWith(
              fontSize: 16,
              color: AppColors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: controller,
            style: TextStyles.body.copyWith(color: AppColors.red),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
