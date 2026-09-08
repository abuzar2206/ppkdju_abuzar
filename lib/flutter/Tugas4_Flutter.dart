import 'package:flutter/material.dart';

class Tugas extends StatelessWidget {
  Tugas({super.key});

  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _skorController = TextEditingController();
  final TextEditingController _pelaporController = TextEditingController();
  final TextEditingController _catatanController = TextEditingController();
  final List<Map<String, dynamic>> riwayatLaporan = const [
    {
      'lokasi': 'Jakarta Pusat',
      'info': 'AQI: 156 - Tidak Sehat. Dilaporkan 5 menit lalu.',
      'icon': Icons.warning_rounded,
      'color': Color.fromARGB(255, 5, 5, 5),
    },
    {
      'lokasi': 'Bandung Kota',
      'info': 'AQI: 95 - Sedang. Dilaporkan 30 menit lalu.',
      'icon': Icons.cloud,
      'color': Color.fromARGB(255, 34, 146, 250),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tugas Flutter4'),
        backgroundColor: const Color.fromARGB(133, 110, 219, 141),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Laporan Kondisi Udara',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _lokasiController,
            decoration: const InputDecoration(
              labelText: 'Titik Lokasi (Nama Jalan/Gedung)',
              prefixIcon: Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _skorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Skor AQI Teramati',
              prefixIcon: Icon(Icons.air),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _pelaporController,
            decoration: const InputDecoration(
              labelText: 'Nama Pelapor',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _catatanController,
            decoration: const InputDecoration(
              labelText: 'Catatan Tambahan (Misal: Berkabut...)',
              prefixIcon: Icon(Icons.notes),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'Riwayat Laporan Terakhir',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 224, 20, 20),
                child: Icon(
                  Icons.warning_rounded,
                  color: Color.fromARGB(255, 235, 228, 228),
                ),
              ),
              title: const Text(
                'Jakarta Pusat',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'AQI: 156 - Tidak Sehat. Dilaporkan 5 menit lalu.',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 8, 132, 233),
                child: Icon(
                  Icons.cloud,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Bandung Kota',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'AQI: 95 - Sedang. Dilaporkan 30 menit lalu.',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Yogyakarta',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'AQI: 42 - Baik. Dilaporkan 1 hari lalu.',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color.fromRGBO(255, 34, 226, 1),
                child: Icon(
                  Icons.masks,
                  color: Color.fromARGB(255, 221, 216, 216),
                ),
              ),
              title: const Text(
                'Semarang',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'AQI: 120 - Sensitif. Dilaporkan 1 hari lalu.',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.cloud_queue,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Surabaya',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'AQI: 68 - Sedang. Dilaporkan 2 hari lalu.',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}