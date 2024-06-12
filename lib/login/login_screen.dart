import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tm/home/homepage.dart';
import 'package:flutter_tm/signup/signup.dart';
import 'package:flutter_tm/widget/styles.dart';
import 'package:flutter_tm/widget/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  final emailController = TextEditingController(text: 'natasya@gmail.com');
  final passwordController = TextEditingController(text: 'natasyaryka');
  double containerHeight = 270.0; // Tinggi awal kontainer gambar

  Future<void> _login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password tidak boleh kosong",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final url = Uri.parse('http://127.0.0.1:8000/api/user/login');
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      if (data['status'] == 'success') {
        final idUser = data['data']['id_user'];
        final name = data['data']['name'];
        final email = data['data']['email'];
        final accessToken = data['access_token'];

        // Simpan data ke SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('id_user', idUser);
        await prefs.setString('name', name);
        await prefs.setString('email', email);
        await prefs.setString('access_token', accessToken);

        Get.to(HomePage(), transition: Transition.rightToLeft);
      } else {
        Get.snackbar("Error", data['message'],
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar("Error", "Login gagal, periksa kembali email dan password",
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
                'Login Akun',
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
              const SizedBox(height: 8.0),
              // Text('Forgot Password?',
              //     style: TextStyles.body.copyWith(fontSize: 12)),
              Text('Forgot Password?', // Tambahkan Text untuk "Forgot Password?"
                  style: TextStyles.body.copyWith(fontSize: 12),
                  textAlign: TextAlign.center),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => ForgotPassword()), // Routing ke halaman ForgotPassword
              //     );
              //   },
              //   child: Text(
              //     'Forgot Password?',
              //     style: TextStyle(
              //       fontSize: 12.0,
              //       color: Colors.red,
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              const SizedBox(height: 24.0),
              // Tombol Login
              Center(
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Login',
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
                  'Don\'t have an account?',
                  style: TextStyles.light
                      .copyWith(fontSize: 12.0, color: Colors.black),
                ),
              ),
              const SizedBox(height: 2.0),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: Text(
                    'Sign Up',
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
