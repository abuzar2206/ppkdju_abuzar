import 'package:flutter/material.dart';

class Flutter extends StatelessWidget {

  Flutter({Key? key}) : super(key: key);
 
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _skorController = TextEditingController();
  final TextEditingController _pelaporController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final List<Map<String, dynamic>> riwayatLaporan = const [
    

    {
      'lokasi': 'Jakarta Pusat',     
      'info': 'AQI: 156 - Tidak Sehat. Dilaporkan 5 menit lalu.',     
      'icon': Icons.warning_rounded,   
      'color': Colors.red,
    },
    {
      'lokasi': 'Bandung Kota',     
      'info': 'AQI: 95 - Sedang. Dilaporkan 30 menit lalu.',     
      'icon': Icons.cloud,    
      'color': Colors.orange,     
    },
    {
      'lokasi': 'Yogyakarta',   
      'info': 'AQI: 42 - Baik. Dilaporkan 1 hari lalu.',      
      'icon': Icons.check_circle,      
      'color': Colors.green,      
    },
    {
      'lokasi': 'Semarang',      
      'info': 'AQI: 120 - Sensitif. Dilaporkan 1 hari lalu.',
      'icon': Icons.masks,     
      'color': Colors.deepOrange,     
    },
    {

      'lokasi': 'Surabaya',
      'info': 'AQI: 68 - Sedang. Dilaporkan 2 hari lalu.',      
      'icon': Icons.cloud_queue,     
      'color': Colors.amber,
  
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Fungsi build digunakan untuk membuat tampilan halaman.

    return Scaffold(
     
      appBar: AppBar(
        

        title: Text('Tugas 4'),
        

        backgroundColor: Color.fromRGBO(81, 121, 92, 0.522),
      ),

      
      body: ListView(
        
        padding: const EdgeInsets.all(16),
        // Memberikan jarak 16 pada semua sisi ListView.

        children: [
         
          const Text(
            'Laporan Kondisi Udara',
            // Menampilkan judul form.

            style: TextStyle(
              fontSize: 16,
              // Mengatur ukuran tulisan menjadi 16.

              fontWeight: FontWeight.bold,
              // Membuat tulisan menjadi tebal.
            ),
          ),

          const SizedBox(height: 12),
          // Memberikan jarak 12 pixel setelah judul.

          // ======================================================
          // TEXTFIELD 1 - LOKASI
          // ======================================================
          TextField(
            // Membuat input untuk memasukkan lokasi.

            controller: _lokasiController,
            // Menghubungkan TextField dengan controller lokasi.

            decoration: const InputDecoration(
              // InputDecoration digunakan untuk mengatur tampilan TextField.

              labelText: 'Titik Lokasi (Nama Jalan/Gedung)',
              // Tulisan petunjuk pada TextField.

              prefixIcon: Icon(Icons.location_on_outlined),
              // Menampilkan icon lokasi di sebelah kiri.

              border: OutlineInputBorder(),
              // Memberikan garis/border berbentuk kotak.
            ),
          ),

          const SizedBox(height: 12),
          // Memberikan jarak 12 pixel antar TextField.

          // ======================================================
          // TEXTFIELD 2 - SKOR AQI
          // ======================================================
          TextField(
            // Membuat input untuk skor AQI.

            controller: _skorController,
            // Menghubungkan TextField dengan controller skor.

            keyboardType: TextInputType.number,
            // Mengatur keyboard agar menampilkan keyboard angka.

            decoration: const InputDecoration(
              // Mengatur tampilan TextField.

              labelText: 'Skor AQI Teramati',
              // Tulisan petunjuk untuk memasukkan skor AQI.

              prefixIcon: Icon(Icons.air),
              // Menampilkan icon udara.

              border: OutlineInputBorder(),
              // Memberikan garis kotak pada TextField.
            ),
          ),

          const SizedBox(height: 12),
          // Memberikan jarak 12 pixel.

          // ======================================================
          // TEXTFIELD 3 - NAMA PELAPOR
          // ======================================================
          TextField(
            // Membuat input untuk nama pelapor.

            controller: _pelaporController,
            // Menghubungkan TextField dengan controller pelapor.

            decoration: const InputDecoration(
              // Mengatur tampilan TextField.

              labelText: 'Nama Pelapor',
              // Tulisan petunjuk untuk nama pelapor.

              prefixIcon: Icon(Icons.person_outline),
              // Menampilkan icon orang.

              border: OutlineInputBorder(),
              // Memberikan border berbentuk kotak.
            ),
          ),

          const SizedBox(height: 12),
          // Memberikan jarak 12 pixel.

          // ======================================================
          // TEXTFIELD 4 - CATATAN
          // ======================================================
          TextField(
            // Membuat input untuk catatan tambahan.

            controller: _catatanController,
            // Menghubungkan TextField dengan controller catatan.

            decoration: const InputDecoration(
              // Mengatur tampilan TextField.

              labelText: 'Catatan Tambahan (Misal: Berkabut...)',
              // Memberikan petunjuk mengenai isi catatan.

              prefixIcon: Icon(Icons.notes),
              // Menampilkan icon catatan.

              border: OutlineInputBorder(),
              // Memberikan border kotak.
            ),
          ),

          const SizedBox(height: 24),
          // Memberikan jarak lebih besar setelah form selesai.

          // ======================================================
          // PEMBATAS
          // ======================================================
          const Divider(),
          // Membuat garis pembatas antara form dan daftar laporan.

          const SizedBox(height: 8),
          // Memberikan jarak setelah garis pembatas.

          // ======================================================
          // JUDUL DAFTAR LAPORAN
          // ======================================================
          const Text(
            'Riwayat Laporan Terakhir',
            // Menampilkan judul daftar riwayat laporan.

            style: TextStyle(
              fontSize: 16,
              // Ukuran tulisan 16.

              fontWeight: FontWeight.bold,
              // Membuat tulisan menjadi tebal.
            ),
          ),

          const SizedBox(height: 8),
          // Memberikan jarak setelah judul.

          // ======================================================
          // LIST LAPORAN 1
          // ======================================================
          Card(
            // Card digunakan untuk membuat tampilan seperti kartu.

            margin: const EdgeInsets.symmetric(vertical: 4),
            // Memberikan jarak atas dan bawah sebesar 4.

            child: ListTile(
              // ListTile digunakan untuk membuat satu baris daftar.

              leading: const CircleAvatar(
                // leading adalah bagian sebelah kiri ListTile.
                // CircleAvatar membuat icon berada di dalam lingkaran.

                backgroundColor: Colors.red,
                // Warna background lingkaran merah.

                child: Icon(
                  Icons.warning_rounded,
                  // Icon peringatan.

                  color: Colors.white,
                  // Warna icon putih.
                ),
              ),

              title: const Text(
                'Jakarta Pusat',
                // Nama lokasi laporan.

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // Membuat nama lokasi menjadi tebal.
                ),
              ),

              subtitle: const Text(
                'AQI: 156 - Tidak Sehat. Dilaporkan 5 menit lalu.',
                // Informasi tambahan mengenai laporan.
              ),

              trailing: const Icon(Icons.chevron_right),
              // Icon panah di sebelah kanan.
            ),
          ),

          // ======================================================
          // LIST LAPORAN 2
          // ======================================================
          Card(
            // Membuat kartu laporan kedua.

            margin: const EdgeInsets.symmetric(vertical: 4),
            // Memberikan jarak atas dan bawah.

            child: ListTile(
              // Membuat isi kartu menggunakan ListTile.

              leading: const CircleAvatar(
                // Membuat lingkaran icon di sebelah kiri.

                backgroundColor: Colors.orange,
                // Warna lingkaran orange.

                child: Icon(
                  Icons.cloud,
                  // Icon awan.

                  color: Colors.white,
                  // Warna icon putih.
                ),
              ),

              title: const Text(
                'Bandung Kota',
                // Nama lokasi.

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // Membuat nama lokasi tebal.
                ),
              ),

              subtitle: const Text(
                'AQI: 95 - Sedang. Dilaporkan 30 menit lalu.',
                // Informasi laporan.
              ),

              trailing: const Icon(Icons.chevron_right),
              // Icon panah di sebelah kanan.
            ),
          ),

          // ======================================================
          // LIST LAPORAN 3
          // ======================================================
          Card(
            // Membuat kartu laporan ketiga.

            margin: const EdgeInsets.symmetric(vertical: 4),
            // Memberikan jarak antar kartu.

            child: ListTile(
              // Isi kartu menggunakan ListTile.

              leading: const CircleAvatar(
                // Membuat lingkaran di sebelah kiri.

                backgroundColor: Colors.green,
                // Warna lingkaran hijau.

                child: Icon(
                  Icons.check_circle,
                  // Icon tanda centang.

                  color: Colors.white,
                  // Warna icon putih.
                ),
              ),

              title: const Text(
                'Yogyakarta',
                // Nama lokasi.

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // Membuat nama lokasi tebal.
                ),
              ),

              subtitle: const Text(
                'AQI: 42 - Baik. Dilaporkan 1 hari lalu.',
                // Informasi laporan.
              ),

              trailing: const Icon(Icons.chevron_right),
              // Icon panah di sebelah kanan.
            ),
          ),

          // ======================================================
          // LIST LAPORAN 4
          // ======================================================
          Card(
            // Membuat kartu laporan keempat.

            margin: const EdgeInsets.symmetric(vertical: 4),
            // Memberikan jarak antar kartu.

            child: ListTile(
              // Membuat isi kartu menggunakan ListTile.

              leading: const CircleAvatar(
                // Membuat lingkaran icon.

                backgroundColor: Colors.deepOrange,
                // Warna lingkaran orange tua.

                child: Icon(
                  Icons.masks,
                  // Icon masker.

                  color: Colors.white,
                  // Warna icon putih.
                ),
              ),

              title: const Text(
                'Semarang',
                // Nama lokasi.

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // Membuat nama lokasi tebal.
                ),
              ),

              subtitle: const Text(
                'AQI: 120 - Sensitif. Dilaporkan 1 hari lalu.',
                // Informasi laporan.
              ),

              trailing: const Icon(Icons.chevron_right),
              // Icon panah di sebelah kanan.
            ),
          ),

          // ======================================================
          // LIST LAPORAN 5
          // ======================================================
          Card(
            // Membuat kartu laporan kelima.

            margin: const EdgeInsets.symmetric(vertical: 4),
            // Memberikan jarak antar kartu.

            child: ListTile(
              // Membuat isi kartu menggunakan ListTile.

              leading: const CircleAvatar(
                // Membuat lingkaran icon.

                backgroundColor: Colors.amber,
                // Warna lingkaran kuning.

                child: Icon(
                  Icons.cloud_queue,
                  // Icon awan.

                  color: Colors.white,
                  // Warna icon putih.
                ),
              ),

              title: const Text(
                'Surabaya',
                // Nama lokasi.

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // Membuat nama lokasi tebal.
                ),
              ),

              subtitle: const Text(
                'AQI: 68 - Sedang. Dilaporkan 2 hari lalu.',
                // Informasi laporan.
              ),

              trailing: const Icon(Icons.chevron_right),
              // Icon panah di sebelah kanan.
            ),
          ),
        ],
        // Penutup children ListView.
      ),
      // Penutup ListView.
    );
    // Penutup Scaffold.
  }
  // Penutup fungsi build.
}
// Penutup class Tugas4_Flutter.