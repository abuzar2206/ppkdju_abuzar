import 'package:abuzar_android/pages/Tugas%20flutter/tes.dart';
import 'package:abuzar_android/pages/Tugas%20flutter/tugas10.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Contoh Bottom Navbar',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const Tugas10(),
    );
  }
}
