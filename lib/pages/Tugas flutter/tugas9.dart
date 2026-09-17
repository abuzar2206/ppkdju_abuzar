import 'package:flutter/material.dart';

void main() {
  runApp(const Tugas9());
}

class Tugas9 extends StatelessWidget {
  const Tugas9({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kategori Produk',
      home: const HomePage(),
    );
  }
}

// 1. LIST
List<String> kategori = [
  'Buah-buahan',
  'Sayuran',
  'Elektronik',
  'Pakaian',
  'Makanan',
  'Minuman',
  'Alat Kecantikan',
  'Alat Olahraga',
  'kendaraan',
  'Alat Rumah Tangga',
];

// 2. LIST MAP
List<Map<String, dynamic>> kategoriMap = [
  {'nama': 'Buah-buahan', 'icon': Icons.apple},
  {'nama': 'Sayuran', 'icon': Icons.grass},
  {'nama': 'Elektronik', 'icon': Icons.devices},
  {'nama': 'Pakaian', 'icon': Icons.checkroom},
  {'nama': 'Makanan', 'icon': Icons.fastfood},
  {'nama': 'Minuman', 'icon': Icons.local_drink},
  {'nama': 'Alat Kecantikan', 'icon': Icons.face},
  {'nama': 'Alat Olahraga', 'icon': Icons.sports_soccer},
  {'nama': 'Kendaraan', 'icon': Icons.directions_car},
  {'nama': 'Alat Rumah Tangga', 'icon': Icons.home},
];

// 3. MODEL
class Produk {
  final String nama;
  final String gambar;
  final String deskripsi;

  Produk({required this.nama, required this.gambar, required this.deskripsi});
}

// Kategori 1 = Buah-buahan
List<Produk> produk = [
  Produk(
    nama: 'Apel',
    gambar: 'assets/images/apel.png',
    deskripsi: 'Apel segar dan kaya akan vitamin.',
  ),
  Produk(
    nama: 'Wortel',
    gambar: 'assets/images/wortel.png',
    deskripsi: 'Sayuran yang kaya akan vitamin dan baik untuk menjaga kesehatan tubuh.',
  ),
  Produk(
    nama: 'TV',
    gambar: 'assets/images/TV.png',
    deskripsi: 'TV cocok untuk reflesing otak.',
  ),
  Produk(
    nama: 'Baju',
    gambar: 'assets/images/baju.png',
    deskripsi: 'Pakaian yang digunakan untuk melindungi tubuh dan menunjang penampilan.',
  ),
  Produk(
    nama: 'Nasi',
    gambar: 'assets/images/nasi.png',
    deskripsi: 'Makanan pokok yang mengenyangkan dan sering dikonsumsi sehari-hari.',
  ),
  Produk(
    nama: 'Kopi',
    gambar: 'assets/images/kopi.png',
    deskripsi: 'Minuman yang nikmat dan cocok untuk menemani aktivitas sehari-hari.',
  ),
  Produk(
    nama: 'Bedak',
    gambar: 'assets/images/bedak.png',
    deskripsi: 'Produk kecantikan yang digunakan untuk merawat dan mempercantik wajah.',
  ),
  Produk(
    nama: 'Barbel',
    gambar: 'assets/images/barbel.png',
    deskripsi: 'Nanas memiliki rasa manis dan sedikit asam.',
  ),
  Produk(
    nama: 'Mobil',
    gambar: 'assets/images/mobil.png',
    deskripsi: 'Kendaraan yang digunakan untuk membantu kebutuhan transportasi.',
  ),
  Produk(
    nama: 'Lemari',
    gambar: 'assets/images/lemari.png',
    deskripsi: 'Perabot rumah tangga yang digunakan untuk menyimpan pakaian dan barang.',
  ),
];

class ListProduk extends StatelessWidget {
  final Produk produk;

  const ListProduk({super.key, required this.produk});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.asset(
          produk.gambar,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
        ),
        title: Text(
          produk.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(produk.deskripsi),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kategori Produk'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'List'),
              Tab(text: 'Map'),
              Tab(text: 'Model'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [HalamanList(), HalamanMap(), HalamanModel()],
        ),
      ),
    );
  }
}

class HalamanList extends StatelessWidget {
  const HalamanList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kategori.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(kategori[index]));
      },
    );
  }
}

class HalamanMap extends StatelessWidget {
  const HalamanMap({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kategoriMap.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(kategoriMap[index]['icon']),
          title: Text(kategoriMap[index]['nama']),
        );
      },
    );
  }
}

class HalamanModel extends StatelessWidget {
  const HalamanModel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produk.length,
      itemBuilder: (context, index) {
        return ListProduk(produk: produk[index]);
      },
    );
  }
}
