import 'package:flutter/material.dart';

import '../day_15/preference_handler.dart';
import 'home_screen.dart';
import 'loginscreendb.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    pindahHalaman();
  }

  Future<void> pindahHalaman() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    if (PreferenceHandler.isLogin) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreenDB(),
        ),
      );
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: SizedBox.expand(
      child: Image.asset(
        'assets/images/panda.jpg',
        fit: BoxFit.cover,
      ),
    ),
  );
}
}