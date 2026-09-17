import 'package:abuzar_android/pages/latihan_circleavatar.dart' show LatihanSircleavatar;
import 'package:abuzar_android/pages/profile.dart';
import 'package:flutter/material.dart';

class LatihanDrawer extends StatefulWidget {
  const LatihanDrawer({super.key});

  @override
  State<LatihanDrawer> createState() => _LatihanDrawerState();
}

class _LatihanDrawerState extends State<LatihanDrawer> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    'Halaman Profile',
    'Halaman SircleAvatar',
  ];

  final List<Widget> _pages = [
    const Profile(),
    const LatihanSircleavatar(),
  ];

  // Fungsi untuk mengubah halaman aktif
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.blue,
      ), // AppBar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text("Abuzar Al "),
              accountEmail: Text("abuzarAl@email.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "B",
                  style: TextStyle(fontSize: 40.0, color: Colors.blue),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ), // UserAccountsDrawerHeader

            // Menu 1: Beranda
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Profile saya'),
              selected: _selectedIndex == 0, // Highlight jika menu ini aktif
              onTap: () {
                _onItemTapped(0); // Pindah ke indeks 0
                Navigator.pop(context); // Menutup Drawer setelah diklik
              },
            ), // ListTile

            // Menu 2: Pengaturan
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('SircleAvatar'),
              selected: _selectedIndex == 1, // Highlight jika menu ini aktif
              onTap: () {
                _onItemTapped(1); // Pindah ke indeks 1
                Navigator.pop(context); // Menutup Drawer setelah diklik
              },
            ), // ListTile
          ],
        ),
      ), // Drawer
      body: _pages[_selectedIndex],
    ); // Scaffold
  }
}