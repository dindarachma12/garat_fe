import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tm/home/homepage.dart';
import 'package:flutter_tm/login/login_screen.dart';
import 'package:flutter_tm/widget/styles.dart';
import 'package:flutter_tm/widget/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscure = true;
  final emailController = TextEditingController();
  final namaController = TextEditingController();
  final passwordController = TextEditingController();
  double containerHeight = 270.0; // Tinggi awal kontainer gambar

  Future<void> _signUp() async {
    final email = emailController.text;
    final name = namaController.text;
    final password = passwordController.text;

    if (email.isEmpty || name.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Semua bidang harus diisi",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final url = Uri.parse(
        'http://127.0.0.1:8000/api/users'); // Ganti dengan URL API Anda
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'name': name,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 201) {
      // 201 Created
      Get.snackbar("Success", "Pendaftaran berhasil",
          snackPosition: SnackPosition.BOTTOM);
      Get.to(LoginScreen(), transition: Transition.rightToLeft);
    } else {
      Get.snackbar("Error", "Pendaftaran gagal, coba lagi",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AnimatedContainer(
                  duration: Duration(seconds: 1), // Durasi animasi
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(
                    'assets/images/Garat.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 1.0),
              Text(
                'SignUp Akun',
                style: TextStyles.title.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 16.0),
              // Input email
              CustomTextField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
                hint: 'email or username',
              ),
              const SizedBox(height: 16.0),
              // Input nama
              CustomTextField(
                controller: namaController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.text,
                hint: 'nama',
              ),
              const SizedBox(height: 16.0),
              // Input password
              CustomTextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                hint: 'password',
                isObscure: isObscure,
                hasSuffix: true,
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              const SizedBox(height: 24.0),
              // Tombol SignUp
              Center(
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'SignUp',
                      style: TextStyles.title
                          .copyWith(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
              // Informasi Sign Up
              const SizedBox(height: 16.0),
              Center(
                child: Text(
                  'Already have an account?',
                  style: TextStyles.light
                      .copyWith(fontSize: 12.0, color: Colors.black),
                ),
              ),
              const SizedBox(height: 2.0),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.to(LoginScreen(), transition: Transition.rightToLeft);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
