import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_april/views/login_screeen/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home screen"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
