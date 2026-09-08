import 'package:abuzar_ppkd_app_devt/ngetes/ngetes.dart';
import 'package:abuzar_ppkd_app_devt/tugasS_flutter/App.dart';
import 'package:abuzar_ppkd_app_devt/tugas_flutter/Tugas4_Flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
        ),
      ),
      home: Tugas(),
    );
  }
}
