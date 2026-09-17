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
                    fillColor: const Color.fromARGB(255, 233, 239, 240),
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


                        Stack(
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        color: const Color.fromARGB(255, 216, 17, 60),
                        child: Image(
                          image: AssetImage('assets/images/jkt.jpg'),
                          fit: BoxFit.cover,
                        )             
                      ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Positioned(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 4,
                                            top: 4,
                                          ),
                                          child: Text(
                                            'Jakarta',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
            
                        // Kotak 2
                        Stack(
                    children: [
                      Container(
                        width: 200,
                        height:200,
                        color: const Color.fromARGB(255, 216, 17, 60),
                        child: Image(
                          image: AssetImage('assets/images/bandung.webp'),
                          fit: BoxFit.cover,
                        )
                      
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Positioned(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 4,
                                            top: 4,
                                          ),
                                          child: Text(
                                            'Bandung',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
            
                        Stack(
                          children: [
                            Container(
                              width: 200,
                              height:200,
                              color: const Color.fromARGB(255, 216, 17, 60),
                              child: Image(
                                image: AssetImage('assets/images/yokyakarta.jpg'),
                                fit: BoxFit.cover,
                              )
                            
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Positioned(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                  bottom: 4,
                                                  top: 4,
                                                ),
                                                child: Text(
                                                  'Yogyakarta',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                        // Kotak 4
                          Stack(
                          children: [
                            Container(
                              width: 200,
                              height:200,
                              color: const Color.fromARGB(255, 216, 17, 60),
                              child: Image(
                                image: AssetImage('assets/images/semarang.jpeg'),
                                fit: BoxFit.cover,
                              )
                            
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Positioned(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                  bottom: 4,
                                                  top: 4,
                                                ),
                                                child: Text(
                                                  'Semarang',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                        // Kotak 5
                          Stack(
                          children: [
                            Container(
                              width: 200,
                              height:200,
                              color: const Color.fromARGB(255, 216, 17, 60),
                              child: Image(
                                image: AssetImage('assets/images/lampung.jpeg'),
                                fit: BoxFit.cover,
                              )
                            
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Positioned(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                  bottom: 4,
                                                  top: 4,
                                                ),
                                                child: Text(
                                                  'Lampung',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                        // Kotak 6
                          Stack(
                    children: [
                      Container(
                        width: 200,
                        height:200,
                        color: const Color.fromARGB(255, 216, 17, 60),
                        child: Image(
                          image: AssetImage('assets/images/padang.webp'),
                          fit: BoxFit.cover,
                        )
                      
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Positioned(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 4,
                                            top: 4,
                                          ),
                                          child: Text(
                                            'Padang',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ]
                  ),
                ),
              ),
            ),
          );
        }

