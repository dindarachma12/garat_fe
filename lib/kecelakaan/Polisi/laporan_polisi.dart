import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'read_laporan_page.dart';
import 'package:flutter_tm/widget/styles.dart';

class LaporanPolisi extends StatefulWidget {
  @override
  _LaporanPolisiState createState() => _LaporanPolisiState();
}

class _LaporanPolisiState extends State<LaporanPolisi> {
  late TextEditingController _namaController;
  late TextEditingController _nomorTeleponController;
  late TextEditingController _alamatController;
  late TextEditingController _keteranganController;
  

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController();
    _nomorTeleponController = TextEditingController();
    _alamatController = TextEditingController();
    _keteranganController = TextEditingController();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nomorTeleponController.dispose();
    _alamatController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }

  Future<void> _laporkanData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idUser = prefs.getInt('id_user');

    if (idUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Anda belum login')),
      );
      return;
    }

    final Map<String, dynamic> data = {
      'laporan': 'Kecelakaan',
      'id_user': idUser,
      'pelapor': _namaController.text,
      'no_hp': _nomorTeleponController.text,
      'alamat': _alamatController.text,
      'keterangan': _keteranganController.text,
    };

    final url = Uri.parse('http://127.0.0.1:8000/api/polisis');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      print('Data terkirim: $data');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Laporan berhasil dikirim')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReadLaporanPage()),
      );
    } else {
      print('Gagal mengirim data: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengirim laporan')),
      );
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: AppColors.red,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'Kecelakaan',
                    style: TextStyles.title.copyWith(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: AppColors.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Layanan Polisi",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        buildTextField('Nama Pelapor', 'Masukkan nama pelapor',
                            _namaController),
                        const SizedBox(height: 24),
                        buildTextField(
                            'Nomor Telepon Pelapor',
                            'Masukkan nomor telepon pelapor',
                            _nomorTeleponController),
                        const SizedBox(height: 24),
                        buildTextField('Alamat Pelapor',
                            'Masukkan alamat kejadian', _alamatController),
                        const SizedBox(height: 24),
                        buildTextField('Keterangan', 'Masukkan keterangan',
                            _keteranganController),
                        const SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _laporkanData();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.red),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15),
                              ),
                            ),
                            child: Text(
                              'Laporkan',
                              style: TextStyles.title
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xff9E2D35),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      String label, String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: const TextStyle(color: AppColors.red),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              hintText: placeholder,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Page"),
    );
  }
}
