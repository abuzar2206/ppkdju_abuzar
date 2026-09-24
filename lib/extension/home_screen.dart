import 'package:flutter/material.dart';
import 'package:abuzar_android/day_15/preference_handler.dart';
import 'package:abuzar_android/extension/loginscreendb.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout(BuildContext context) async {
    await PreferenceHandler.setLogin(false);

    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreenDB(
          showLogoutMessage: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Selamat Datang di Home',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}