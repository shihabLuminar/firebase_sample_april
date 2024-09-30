import 'dart:async';

import 'package:firebase_sample_april/views/intermediate_screen.dart';
import 'package:firebase_sample_april/views/login_screeen/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => IntermediateScreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash screen",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
