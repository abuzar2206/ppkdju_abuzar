import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tugas7 extends StatefulWidget {
  const Tugas7({super.key});

  @override
  State<Tugas7> createState() => _tugas7State();
}

class _tugas7State extends State<Tugas7> {
  int menuAktif = 0;

  bool syaratDisetujui = false;
  bool modeGelap = false;

  String? kategori;
  DateTime? tanggalLahir;
  TimeOfDay? waktuPengingat;    

  final List<String> menu = [
    'Syarat & Ketentuan',
    'Mode Gelap',
    'Pilih Kategori Produk',
    'Pilih Tanggal Lahir',
    'Atur Pengingat',
  ];

  void pilihMenu(int index) {
    setState(() {
      menuAktif = index;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu[menuAktif]),
        centerTitle: true,
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
              selected: menuAktif == 0,
              onTap: () => pilihMenu(0),
            ),

            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Mode Gelap'),
              selected: menuAktif == 1,
              onTap: () => pilihMenu(1),
            ),

            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Pilih Kategori Produk'),
              selected: menuAktif == 2,
              onTap: () => pilihMenu(2),
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Pilih Tanggal Lahir'),
              selected: menuAktif == 3,
              onTap: () => pilihMenu(3),
            ),

            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Atur Pengingat'),
              selected: menuAktif == 4,
              onTap: () => pilihMenu(4),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    switch (menuAktif) {
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