import 'package:flutter/material.dart';

class ForminputGrid extends StatelessWidget {
  ForminputGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/cieterbang.png',
              fit: BoxFit.fill,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: Center(
                    child: Text(
                      'NPD Final Boss',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 10)],
                      ),
                    ),
                  ),
                ),
                //judul form
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(200, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(62, 0, 0, 0),
                          blurRadius: 8,
                          spreadRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    //
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'Form Pendaftaran Omke Gas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          //field input pendaftaran
                          Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              left: 20,
                              right: 20,
                            ),
                            child: Column(
                              spacing: 20,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    labelText: 'Nama lengkap',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.mail),
                                    labelText: 'Email Pengguna',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                TextField(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    labelText: 'Telfon Pengguna',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.key),
                                    labelText: 'Input Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Silahkan Konfirmasi Password',
                                    labelText: 'Konfirmasi Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Text(
                    'Wilayah Pemantauan Kualitas Udara Terdekat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 7,
                          color: Colors.black,
                          offset: Offset(1, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                GridView.count(
                  padding: EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 50,
                  ),
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    // grid content
                    // Jakarta
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/cities/jkt.jpg',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
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
                    // Bandung
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/cities/bdg.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
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
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Yogyakarta
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/cities/yogya.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
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
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Semarang
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/cities/semarang.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
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
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Lampung
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/cities/lampung.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
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
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Padang
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/cities/padang.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
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
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}