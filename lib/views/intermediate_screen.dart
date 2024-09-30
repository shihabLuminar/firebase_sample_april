import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_april/views/home_screen/home_screen.dart';
import 'package:firebase_sample_april/views/login_screeen/login_screen.dart';
import 'package:flutter/material.dart';

class IntermediateScreen extends StatelessWidget {
  const IntermediateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
