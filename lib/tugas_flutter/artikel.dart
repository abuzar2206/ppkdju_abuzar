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
      title: '',
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
          'Article Abuzar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        leading: const CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
          child: CircleAvatar(
            radius: 29,
            backgroundImage: AssetImage('assets/images/abuzar.jpg'),
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
                    'TEKNOLOGI',
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
                '',
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
                    '3 September 2026',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 10),
                  Text('• Oleh: Abuzar', style: TextStyle(color: Colors.grey)),
                ],
              ),

              const SizedBox(height: 20),

              // Gambar artikel
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/tugas.jpeg',
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              // Isi artikel
              const Text(
                'Kendaraan listrik di Indonesia terus berkembang dengan dukungan pemerintah dan industri otomotif.'
                'Penggunaan kendaraan ramah lingkungan diharapkan dapat mengurangi emisi karbon serta menciptakan '
                'transportasi yang lebih hemat energi dan berkelanjutan.',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),

              const SizedBox(height: 15),

              const Text(
                'Selain mengurangi emisi karbon, kendaraan listrik juga dinilai lebih hemat dalam biaya operasional.'
                'Dengan semakin banyaknya produsen yang memasarkan mobil dan motor listrik, masyarakat memiliki lebih banyak '
                'pilihan untuk beralih ke transportasi yang lebih bersih dan efisien.',
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
                      'EVISIENSI ENERGI',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Lebih hemat dibanding bensin',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Inovasi Kendaraan Listrik di Indonesia',
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