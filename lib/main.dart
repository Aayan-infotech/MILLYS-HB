import 'package:flutter/material.dart';
import 'package:millyshb/screens/login_signup/forget_password.dart';
import 'package:millyshb/screens/login_signup/login_screen.dart';
import 'package:millyshb/screens/login_signup/otp_verify_screen.dart';
import 'package:millyshb/screens/login_signup/sign_up_screen.dart';
import 'package:millyshb/screens/nav_screen.dart';
import 'package:millyshb/screens/select_store_screen.dart';
import 'package:millyshb/screens/splash/splash_screen.dart';
import 'package:millyshb/utills/store_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
