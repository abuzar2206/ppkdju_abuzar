import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext c) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi & Edukasi'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 48, 148, 230),
      ),
      body:SingleChildScrollView(
        child:Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Form Registrasi',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ...['Nama Pengguna', 'Email Pengguna', 'Telephone Pengguna',
              'Input Password', 'Konfirmasi Password'].map(
              (e) => Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  obscureText: e.contains('Password'),
                  decoration: InputDecoration(
                    hintText: e,
                    filled: true,
                    fillColor: const Color.fromARGB(255, 143, 251, 255),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Wilayah Pemantauan Kualitas Udara Terdekat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true, // Membuat GridView menyesuaikan tinggi kon
              physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 3,// Menampilkan 2 kolom kotak menyamping
        crossAxisSpacing: 10, // Jarak horizontal antar kotak
        mainAxisSpacing: 10, // Jarak vertikal antar kotak
        padding: const EdgeInsets.all(10), // Jarak luar di sekeliling grid
        children: [
          // Kotak 1
          Container(
            color: const Color.fromARGB(255, 216, 17, 60),
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/jkt.jpg'),
                fit: BoxFit.cover,
              )
            ),
          ),
          // Kotak 2
          Container(
            color: Colors.blue,
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/bandung.webp'),
                fit: BoxFit.cover,
              )
            ),
          ),
          // Kotak 3
          Container(
            color: const Color.fromARGB(255, 121, 226, 23),
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/yokyakarta.jpg'),
                // fit: BoxFit.cover,
              ),
            ),
          ),
          // Kotak 4
          Container(
            color: const Color.fromARGB(255, 243, 240, 63),
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/semarang.jpeg'),
                fit: BoxFit.cover,
              )
            ),
          ),
          // Kotak 5
          Container(
            color: const Color.fromARGB(255, 235, 88, 191),
            child: const Center(
              child: Image(
                image: AssetImage('assets/images/lampung.jpeg'),
                fit: BoxFit.cover,
              )
            ),
          ),
          // Kotak 6
          Container(
            color: const Color.fromARGB(255, 250, 167, 42),
            child: const Center(
              child:Image(
                image: AssetImage('assets/images/padang.webp'),
                fit: BoxFit.cover,
              )
            ),
          ),
        ],
      ),
               
          
          ],
        ),
      ),
      )
      
       
    ),
  );
}