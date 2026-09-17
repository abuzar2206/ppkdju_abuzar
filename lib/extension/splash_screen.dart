import 'package:flutter/material.dart';

// Class SplashScreen digunakan untuk membuat halaman splash screen.
class SplashScreen extends StatefulWidget {
  // Constructor dari SplashScreen.
  const SplashScreen({super.key});

  // Membuat State untuk SplashScreen.
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// State dari SplashScreen.
class _SplashScreenState extends State<SplashScreen> {
  // Method yang dijalankan satu kali ketika halaman pertama kali dibuat.
  @override
  void initState() {
    // Memanggil initState milik parent.
    super.initState();

    // Menunggu selama 3 detik.
    Future.delayed(const Duration(seconds: 3), () {
      // Mengecek apakah widget masih ada di layar.
      if (!mounted) return;

      // Berpindah ke halaman login.
      // pushReplacement berarti halaman splash diganti dengan halaman login.
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  // Method untuk membuat tampilan halaman.
  @override
  Widget build(BuildContext context) {
    // Scaffold sebagai struktur dasar halaman.
    return Scaffold(
      // Isi utama halaman.
      body: Padding(
        // Memberikan jarak 28 pixel dari semua sisi.
        padding: const EdgeInsets.all(28.0),

        // Membuat logo berada di tengah.
        child: Center(
          // Mengambil gambar logo dari folder assets.
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }
}