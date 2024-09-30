import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_sample_april/controller/login_controller.dart';
import 'package:firebase_sample_april/controller/registration_screen_controller.dart';
import 'package:firebase_sample_april/firebase_options.dart';
import 'package:firebase_sample_april/views/home_screen/home_screen.dart';
import 'package:firebase_sample_april/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RegistrationScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginScreenController(),
        )
      ],
      child: MaterialApp(home: SplashScreen()),
    );
  }
}
