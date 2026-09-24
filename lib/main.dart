import 'package:flutter/material.dart';

import 'package:abuzar_android/day_15/preference_handler.dart';
import 'package:abuzar_android/extension/home_screen.dart';
import 'package:abuzar_android/extension/loginscreendb.dart';
import 'package:abuzar_android/extension/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceHandler.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/login': (context) => const LoginScreenDB(),
        '/home': (context) => const HomeScreen(),
      },
      home: const SplashScreen(),
    );
  }
}