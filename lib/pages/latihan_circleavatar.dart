import 'package:flutter/material.dart';

class LatihanSircleavatar extends StatelessWidget {
const LatihanSircleavatar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          radius: 125, //   Lingkaran luar (berfungsi sebagai border)
          backgroundColor: Colors.blue, // Warna border
          child: CircleAvatar(
            radius: 100, // Lingkaran dalam (foto profil asli)
            backgroundImage: AssetImage('assets/images/panda.jpg'),
          ),
        ),
      ),
    );
  }
}