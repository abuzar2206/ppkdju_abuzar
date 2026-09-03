import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Foto profil
          const CircleAvatar(
            radius: 100, // Lingkaran luar
            backgroundColor: Colors.blue,
            child: CircleAvatar(
              radius: 90, // Lingkaran dalam
              backgroundImage: AssetImage('assets/images/abuzar.jpg'),
            ),
          ),

          const SizedBox(height: 20),

          // Baris 1: Nama lengkap
          const Text(
            'Abuzar',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          // Baris 2: Kota
          const Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 5),
              Text(
                'Jakarta',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Baris 3: Deskripsi
          const Text(
            'Seseorang yang sedang belajar Flutter dan pengembangan aplikasi.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}