import 'package:flutter/material.dart';
import 'package:flutter_tm/kecelakaan/Ambulance/laporan_ambulance.dart';
import 'package:flutter_tm/kecelakaan/Polisi/laporan_polisi.dart';
// import 'package:flutter_tm/kecelakaan/Polisi/polisi.dart';
import 'package:flutter_tm/kecelakaan/Polisi/read_laporan_page.dart';
import 'package:flutter_tm/widget/styles.dart';

class KecelakaanPage extends StatefulWidget {
  @override
  _KecelakaanPageState createState() => _KecelakaanPageState();
}

class _KecelakaanPageState extends State<KecelakaanPage> {
  Future<List<String>> getLayanan() async {
    await Future.delayed(Duration(seconds: 2)); // Simulasi waktu tunggu
    return ['Ambulance', 'Polisi'];
  }

  void _showPopup(BuildContext context, String type) {
    List<Widget> actions = [
      TextButton(
        child: Text('Hubungi'),
        onPressed: () {
          Navigator.of(context).pop();
          // Tambahkan kode aksi "Hubungi" di sini
        },
      ),
    ];

    if (type == 'Polisi') {
      actions.add(
        TextButton(
          child: Text('Laporkan'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReadLaporanPage()),
            );
          },
        ),
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tindakan'),
          content: Text('Pilih tindakan yang ingin Anda lakukan:'),
          actions: actions,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      appBar: AppBar(
        backgroundColor: AppColors.red,
      ),
      body: SafeArea(
        child: FutureBuilder<List<String>>(
          future: getLayanan(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No services available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              final layanan = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Kecelakaan",
                              style: TextStyles.title.copyWith(
                                fontSize: 24,
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 22),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: AppColors.white,
                      ),
                      padding: EdgeInsets.all(35),
                      child: Column(
                        children: [
                          Text(
                            'Pilih Layanan',
                            style: TextStyles.title.copyWith(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Text(
                            'Anda akan langsung terhubung dengan layanan yang tersedia!',
                            style: TextStyles.light.copyWith(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          for (var service in layanan)
                            GestureDetector(
                              onTap: () {
                                _showPopup(context, service);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(bottom: 30),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: const Color.fromARGB(
                                            255, 65, 32, 32),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                          service == 'Ambulance'
                                              ? 'assets/images/ambulance.png'
                                              : 'assets/images/polisi.png',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          service,
                                          style: TextStyles.title.copyWith(
                                            fontSize: 16,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'Hubungi ${service}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
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
}

void main() {
  runApp(MaterialApp(
    home: KecelakaanPage(),
  ));
}
