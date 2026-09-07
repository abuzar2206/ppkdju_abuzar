import 'package:flutter/material.dart';
// Mengambil library Flutter untuk membuat tampilan aplikasi.

class Store extends StatelessWidget {
  // Membuat halaman Store.

  const Store({Key? key}) : super(key: key);
  // Constructor untuk halaman Store.

  @override
  Widget build(BuildContext context) {
    // Fungsi untuk membuat tampilan halaman.

    return Scaffold(
      // Scaffold adalah kerangka utama halaman Flutter.

      // ================= APP BAR =================

      appBar: AppBar(
        // Membuat bagian atas aplikasi.

        title: Text(
          // Judul yang ditampilkan di AppBar.

          'Detail Toko',

          style: TextStyle(
            // Mengatur tampilan tulisan.

            color: const Color.fromARGB(255, 0, 0, 0),
            // Warna tulisan putih.

            fontSize: 20,
            // Ukuran tulisan 20.

            fontWeight: FontWeight.bold,
            // Membuat tulisan menjadi tebal.
          ),
        ),

        centerTitle: true,
        // Membuat judul berada di tengah.

        backgroundColor: Color.fromARGB(255, 28, 175, 204),
        // Memberikan warna biru pada AppBar.

        elevation: 0,
        // Menghilangkan bayangan AppBar.
      ),

      // ================= BODY =================

      backgroundColor: Color.fromARGB(255, 232, 235, 237),
      // Memberikan warna biru muda pada background halaman.

      body: Column(
        // Column digunakan untuk menyusun widget
        // dari atas ke bawah.

        children: [
          // ================= NAMA TOKO =================

          Padding(
            // Memberikan jarak di sekitar nama toko.

            padding: EdgeInsets.all(20),

            child: Text(
              // Menampilkan nama toko.

              'Harmony Mystic Emporium',

              textAlign: TextAlign.center,
              // Membuat tulisan berada di tengah.

              style: TextStyle(
                fontSize: 20,
                // Ukuran tulisan 20.

                fontStyle: FontStyle.italic,
                // Membuat tulisan menjadi miring.
              ),
            ),
          ),

          // ================= EMAIL =================

          Container(
            // Membuat kotak untuk email.

            margin: EdgeInsets.symmetric(horizontal: 15),
            // Memberikan jarak kiri dan kanan 15.

            padding: EdgeInsets.all(10),
            // Memberikan jarak isi dengan tepi Container.

            width: double.infinity,
            // Membuat Container memenuhi lebar layar.

            decoration: BoxDecoration(
              // Mengatur tampilan Container.

              color: Color.fromARGB(255, 70, 185, 206),
              // Memberikan warna biru tua.

              borderRadius: BorderRadius.circular(30),
              // Membuat sudut Container menjadi bulat.
            ),

            child: Row(
              // Row digunakan untuk menempatkan icon dan email
              // secara berdampingan.

              children: [
                Icon(
                  Icons.email,
                  // Menampilkan icon email.

                  color: const Color.fromARGB(255, 0, 0, 0),
                  // Warna icon putih.
                ),

                SizedBox(width: 10),
                // Memberikan jarak antara icon dan email.

                Text(
                  'abuzaraboyy@gmail.com',

                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    // Warna tulisan putih.

                    fontSize: 16,
                    // Ukuran tulisan 16.

                    fontWeight: FontWeight.bold,
                    // Membuat tulisan tebal.
                  ),
                ),
              ],
            ),
          ),

          // ================= TELEPON DAN LOKASI =================

          Padding(
            // Memberikan jarak pada bagian telepon dan lokasi.

            padding: EdgeInsets.all(20),

            child: Row(
              // Membuat telepon dan lokasi berada dalam satu baris.

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // Memberikan jarak antara bagian kiri dan kanan.

              children: [
                // ================= TELEPON =================

                Row(
                  children: [
                    Icon(Icons.phone),
                    // Icon telepon.

                    SizedBox(width: 10),
                    // Jarak antara icon dan nomor.

                    Text('081284057625'),
                    // Nomor telepon toko.
                  ],
                ),

                // ================= LOKASI =================

                Row(
                  children: [
                    Icon(Icons.location_on),
                    // Icon lokasi.

                    SizedBox(width: 10),
                    // Jarak antara icon dan lokasi.

                    Text('Jakarta, Indonesia'),
                    // Lokasi toko.
                  ],
                ),
              ],
            ),
          ),

          // ================= STATISTIK =================

          Row(
            // Membuat dua kotak statistik berdampingan.

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // Memberikan jarak yang sama di antara kedua kotak.

            children: [
              // ================= JUMLAH BUKU =================

              Container(
                width: 150,
                // Lebar kotak 150.

                padding: EdgeInsets.all(10),
                // Memberikan jarak isi dengan tepi kotak.

                decoration: BoxDecoration(
                  color: Color.fromRGBO(100, 192, 245, 1),
                  // Warna kotak.

                  borderRadius: BorderRadius.circular(10),
                  // Membuat sudut kotak sedikit membulat.
                ),

                child: Column(
                  // Menyusun isi kotak dari atas ke bawah.

                  children: [
                    Text(
                      '300+',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // Membuat angka tebal.

                        fontSize: 16,
                        // Ukuran angka.
                      ),
                    ),

                    Text(
                      'books sold per month',

                      style: TextStyle(
                        fontSize: 12,
                        // Ukuran tulisan keterangan.
                      ),
                    ),
                  ],
                ),
              ),

              // ================= RATING =================

              Container(
                width: 150,
                // Lebar kotak 150.

                padding: EdgeInsets.all(10),
                // Memberikan jarak isi dengan tepi kotak.

                decoration: BoxDecoration(
                  color:    Color.fromARGB(255, 77, 177, 243),
                  // Warna kotak.

                  borderRadius: BorderRadius.circular(10),
                  // Membuat sudut kotak membulat.
                ),

                child: Column(
                  children: [
                    Text(
                      '4.8/5 ⭐',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // Membuat rating tebal.

                        fontSize: 16,
                        // Ukuran rating.
                      ),
                    ),

                    Text(
                      'rating by user',

                      style: TextStyle(
                        fontSize: 12,
                        // Ukuran keterangan.
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // ================= DESKRIPSI =================

          Padding(
            // Memberikan jarak di sekitar deskripsi.

            padding: EdgeInsets.all(20),

            child: Text(
              // Deskripsi toko dibuat lebih pendek
              // supaya halaman tidak terlalu panjang.

              'Harmony Mystic Emporium adalah toko buku bernuansa magis '
              'yang menghadirkan berbagai koleksi buku seperti novel fantasi, '
              'misteri, mitologi, spiritualitas, dan literatur klasik. '
              'Tempat ini dirancang dengan suasana hangat dan estetik '
              'sehingga nyaman untuk membaca dan menemukan cerita baru. ✨',

              textAlign: TextAlign.justify,
              // Membuat tulisan rata kanan dan kiri.

              style: TextStyle(
                fontSize: 16,
                // Ukuran tulisan 16.

                height: 1.5,
                // Memberikan jarak antarbaris.
              ),
            ),
          ),

          // ================= GAMBAR / LOGO =================

          Container(          
            margin: EdgeInsets.symmetric(horizontal: 15),
            height: 150,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),            
              child: Image.asset(
                'assets/images/foto.avif',
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ================= JARAK BAWAH =================

          SizedBox(
            height: 20,
            // Memberikan jarak 20 di bagian bawah.
          ),
        ],
      ),
    );
  }
}