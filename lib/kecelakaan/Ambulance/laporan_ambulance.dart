import 'package:flutter/material.dart';
import 'package:flutter_tm/widget/custom_navbar.dart';
import 'package:flutter_tm/home/homepage.dart';
import 'package:flutter_tm/tips/tips.dart';
import 'package:flutter_tm/widget/styles.dart';

class LaporanAmbulance extends StatefulWidget {
  @override
  _LaporanAmbulanceState createState() => _LaporanAmbulanceState();
}

class _LaporanAmbulanceState extends State<LaporanAmbulance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
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
                    style: TextStyle(
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
                        Text(
                          "Layanan Ambulance",
                          style: TextStyles.title.copyWith(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        buildTextField('Nama Pelapor', 'Masukkan nama pelapor'),
                        const SizedBox(height: 24),
                        buildTextField('Nomor Telepon Pelapor',
                            'Masukkan nomor telepon pelapor'),
                        const SizedBox(height: 24),
                        buildTextField('Alamat Pasien',
                            'Masukkan alamat pasien gawat darurat'),
                        const SizedBox(height: 24),
                        buildTextField('Arahan Alamat',
                            'Masukkan arahan alamat untuk mempermudah'),
                        const SizedBox(height: 24),
                        buildTextField(
                            'Keterangan', 'Masukkan keterangan pasien'),
                        const SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.red),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15),
                              ),
                            ),
                            child: Text(
                              'Laporkan',
                              style: TextStyle(color: AppColors.white),
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
        backgroundColor: const Color(0xff9E2D35),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const [
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

  Widget buildTextField(String label, String placeholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.red, // Set the label color to red
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            style: TextStyle(
                color: AppColors.red), // Set the input text color to red
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
    return Center(
      child: Text("Profile Page"),
    );
  }
}
