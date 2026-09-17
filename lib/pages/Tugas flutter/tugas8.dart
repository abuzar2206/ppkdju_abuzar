import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const Tugas8());
}

class Tugas8 extends StatefulWidget {
  const Tugas8({super.key});

  @override
  State<Tugas8> createState() => _Tugas8State();
}

class _Tugas8State extends State<Tugas8> {
  int _selectedIndex = 0;
  int menuAktif = 0;

  final List<String> menu = [
    'Syarat & Ketentuan',
    'Mode Gelap',
    'Pilih Kategori Produk',
    'Pilih Tanggal Lahir',
    'Atur Pengingat',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? menu[menuAktif]
              : 'Tentang Aplikasi',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.dashboard,
                    color: Colors.white,
                    size: 45,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menu Input',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.check_box),
              title: const Text('Syarat & Ketentuan'),
              selected: _selectedIndex == 0 && menuAktif == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                  menuAktif = 0;
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Mode Gelap'),
              selected: _selectedIndex == 0 && menuAktif == 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                  menuAktif = 1;
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Pilih Kategori Produk'),
              selected: _selectedIndex == 0 && menuAktif == 2,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                  menuAktif = 2;
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Pilih Tanggal Lahir'),
              selected: _selectedIndex == 0 && menuAktif == 3,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                  menuAktif = 3;
                });
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Atur Pengingat'),
              selected: _selectedIndex == 0 && menuAktif == 4,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                  menuAktif = 4;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: _selectedIndex == 0
          ? Tugasprd(menuAktif: menuAktif)
          : const TentangPage(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tugas 7',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}

class Tugasprd extends StatefulWidget {
  final int menuAktif;

  const Tugasprd({
    super.key,
    required this.menuAktif,
  });

  @override
  State<Tugasprd> createState() => _TugasprdState();
}

class _TugasprdState extends State<Tugasprd> {
  bool syaratDisetujui = false;
  bool modeGelap = false;

  String? kategori;
  DateTime? tanggalLahir;
  TimeOfDay? waktuPengingat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (widget.menuAktif) {
      case 0:
        return _formCheckbox();
      case 1:
        return _formSwitch();
      case 2:
        return _formDropdown();
      case 3:
        return _formTanggal();
      case 4:
        return _formWaktu();
      default:
        return Container();
    }
  }

  Widget _formCheckbox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Syarat & Ketentuan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Saya menyetujui semua persyaratan yang berlaku',
          ),
          value: syaratDisetujui,
          onChanged: (value) {
            setState(() {
              syaratDisetujui = value ?? false;
            });
          },
        ),
        const SizedBox(height: 20),
        Text(
          syaratDisetujui
              ? 'Lanjutkan pendaftaran diperbolehkan'
              : 'Anda belum bisa melanjutkan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: syaratDisetujui ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _formSwitch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mode Gelap',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Aktifkan Mode Gelap'),
          value: modeGelap,
          onChanged: (value) {
            setState(() {
              modeGelap = value;
            });
          },
        ),
        const SizedBox(height: 20),
        Text(
          modeGelap ? 'Mode Gelap Aktif' : 'Mode Terang Aktif',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _formDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Kategori Produk',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Kategori Produk',
            border: OutlineInputBorder(),
          ),
          value: kategori,
          items: const [
            DropdownMenuItem(
              value: 'Elektronik',
              child: Text('Elektronik'),
            ),
            DropdownMenuItem(
              value: 'Pakaian',
              child: Text('Pakaian'),
            ),
            DropdownMenuItem(
              value: 'Makanan',
              child: Text('Makanan'),
            ),
            DropdownMenuItem(
              value: 'Lainnya',
              child: Text('Lainnya'),
            ),
          ],
          onChanged: (value) {
            setState(() {
              kategori = value;
            });
          },
        ),
        const SizedBox(height: 20),
        Text(
          kategori == null
              ? 'Silakan pilih kategori'
              : 'Anda memilih kategori: $kategori',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _formTanggal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Tanggal Lahir',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton.icon(
          onPressed: () async {
            DateTime? hasil = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (hasil != null) {
              setState(() {
                tanggalLahir = hasil;
              });
            }
          },
          icon: const Icon(Icons.calendar_month),
          label: const Text('Pilih Tanggal Lahir'),
        ),
        const SizedBox(height: 20),
        Text(
          tanggalLahir == null
              ? 'Belum memilih tanggal lahir'
              : 'Tanggal Lahir: ${DateFormat('dd MMMM yyyy', 'id_ID').format(tanggalLahir!)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _formWaktu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Atur Pengingat',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton.icon(
          onPressed: () async {
            TimeOfDay? hasil = await showTimePicker(
              context: context,
              initialTime: const TimeOfDay(
                hour: 7,
                minute: 30,
              ),
            );

            if (hasil != null) {
              setState(() {
                waktuPengingat = hasil;
              });
            }
          },
          icon: const Icon(Icons.access_time),
          label: const Text('Pilih Waktu Pengingat'),
        ),
        const SizedBox(height: 20),
        Text(
          waktuPengingat == null
              ? 'Belum memilih waktu pengingat'
              : 'Pengingat diatur pukul: ${waktuPengingat!.format(context)}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Icon(
              Icons.apps,
              size: 80,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Aplikasi Form Input',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Tentang Aplikasi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Aplikasi ini dibuat untuk memenuhi tugas Flutter,'
            'dengan menggunakan BottomNavigationBar dan Drawer. '
            'Aplikasi memiliki halaman Tugas 7 dan halaman '
            'Tentang Aplikasi.',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 25),
          Text(
            'Nama Pembuat: Abuzar Al',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Versi: 1.0.0',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}