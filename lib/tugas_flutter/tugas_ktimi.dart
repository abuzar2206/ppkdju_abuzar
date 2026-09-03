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
      title: 'Typing Test 81',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const TypingTestPage(),
    );
  }
}

class TypingTestPage extends StatelessWidget {
  const TypingTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bagian paling atas halaman
      appBar: AppBar(
        title: const Text(
          'Article Timmy',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        leading: const CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
          child: CircleAvatar(
            radius: 29,
            backgroundImage: AssetImage('assets/images/timi.png'),
          ),
        ),

        actions: const [
          Icon(Icons.view_headline, color: Colors.black, size: 50),
        ],

        centerTitle: true,
      ),

      // Isi halaman
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kategori
              Row(
                children: const [
                  Icon(Icons.circle, size: 10, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    'TECHNOLOGY',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // Judul artikel
              const Text(
                'Typing Test 81: Seberapa Cepat Kamu Mengetik?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 12),

              // Tanggal dan penulis
              Row(
                children: const [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  SizedBox(width: 6),
                  Text(
                    '2 September 2026',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 10),
                  Text('• Oleh: Timi', style: TextStyle(color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 20),

              // Gambar artikel
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/hallo.png',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              // Isi artikel
              const Text(
                'Typing Test 81 merupakan sebuah tes untuk mengukur '
                'seberapa cepat dan akurat seseorang dalam mengetik. '
                'Kecepatan mengetik biasanya dihitung menggunakan '
                'satuan Words Per Minute atau WPM.',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),

              const SizedBox(height: 15),

              const Text(
                'Dengan melakukan typing test, kita dapat mengetahui '
                'kemampuan mengetik sekaligus melatih kecepatan dan '
                'ketepatan dalam menggunakan keyboard.',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),

              const SizedBox(height: 20),

              // Kotak hasil typing test
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: const [
                    Text(
                      'HASIL TYPING TEST',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      '81 WPM',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Kecepatan mengetik',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}