import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample_april/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreenController with ChangeNotifier {
  bool isLoading = false;
  onLogin(
      {required String email,
      required String pass,
      required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      if (credential.user?.uid != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("user Loggein successfully")));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      }
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text("Invalid Credential")));
      }

      isLoading = false;
      notifyListeners();
    }
  }
}
