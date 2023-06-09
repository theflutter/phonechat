import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login-page.dart';
import 'otp-page.dart';
import './home-page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'home-page',
    routes: {
      'login-page': (context) => const LoginPage(),
      'otp-page': (context) => const OtpPage(),
      'home-page': (context) => HomeScreen()
    },
  ));
}
