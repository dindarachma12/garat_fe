import 'package:flutter/material.dart';
import 'package:flutter_tm/mogok/bengkel_mobil/bengkel_mobil.dart';
import 'package:flutter_tm/mogok/bengkel_motor/bengkel_motor.dart';
import 'package:flutter_tm/mogok/towing/towing.dart';
import 'package:flutter_tm/widget/styles.dart';

class MogokPage extends StatelessWidget {
  const MogokPage({Key? key});

  Future<List<Map<String, String>>> fetchData() async {
    // Simulate fetching data from a source
    await Future.delayed(Duration(seconds: 2));
    return [
      {
        'imagePath': 'assets/images/bengkelmobil.png',
        'title': 'Bengkel Mobil',
        'subtitle': 'Cari bengkel mobil terdekat',
      },
      {
        'imagePath': 'assets/images/bengkelmotor.png',
        'title': 'Bengkel Motor',
        'subtitle': 'Cari bengkel motor terdekat',
      },
      {
        'imagePath': 'assets/images/towing.png',
        'title': 'Towing & Derek',
        'subtitle': 'Cari towing atau derek terdekat',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.red,
      appBar: AppBar(
        backgroundColor: AppColors.red,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Mogok Kendaraan",
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
                child: FutureBuilder<List<Map<String, String>>>(
                  future: fetchData(),
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
                          'No data available',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Text('Pilih Layanan',
                                style: TextStyles.title.copyWith(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 17,
                            ),
                            Text('Pilih sesuai kebutuhan Anda!',
                                style: TextStyles.light.copyWith(
                                    fontSize: 14, color: Colors.black)),
                            SizedBox(
                              height: 35,
                            ),
                            for (var data in snapshot.data!)
                              Column(
                                children: [
                                  buildServiceContainer(
                                    context,
                                    data['imagePath']!,
                                    data['title']!,
                                    data['subtitle']!,
                                    () {
                                      navigateToService(
                                          context, data['title']!);
                                    },
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                          ],
                        ),
                      );
                    }
                  },
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

  Widget buildServiceContainer(BuildContext context, String imagePath,
      String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // Changes the shadow position
            ),
          ],
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 65, 32, 32),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  imagePath,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.title.copyWith(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void navigateToService(BuildContext context, String serviceName) {
    if (serviceName == 'Bengkel Mobil') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BengkelMobil()),
      );
    } else if (serviceName == 'Bengkel Motor') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BengkelMotor()),
      );
    } else if (serviceName == 'Towing & Derek') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Towing()),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: MogokPage(),
  ));
}
