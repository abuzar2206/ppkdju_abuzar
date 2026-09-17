import 'package:flutter/material.dart';

class LatihanSircleavatar extends StatelessWidget {
const LatihanSircleavatar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Belajar CircleAvatar'),
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: CircleAvatar(
          radius: 100, //   Lingkaran luar (berfungsi sebagai border)
          backgroundColor: Colors.blue, // Warna border
          child: CircleAvatar(
            radius: 90, // Lingkaran dalam (foto profil asli)
            backgroundImage: AssetImage('assets/images/abuzar.jpg'),
          ),
        ),
      ),
    );
  }
}