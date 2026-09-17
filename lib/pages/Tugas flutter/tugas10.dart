import 'package:flutter/material.dart';

void main() {
  runApp(const Tugas10());
}

class Tugas10 extends StatelessWidget {
  const Tugas10({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Pendaftaran',
      home: const FormPage(),
    );
  }
}

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final hpController = TextEditingController();
  final kotaController = TextEditingController();

  void daftar() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Ringkasan Data'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama: ${namaController.text}'),
                Text('Email: ${emailController.text}'),
                Text('No HP: ${hpController.text}'),
                Text('Kota: ${kotaController.text}'),
              
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KonfirmasiPage(
                        nama: namaController.text,
                        kota: kotaController.text,
                      ),
                    ),
                  );
                },
                child: const Text('Lanjut'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    hpController.dispose();
    kotaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pendaftaran'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Silakan isi data pendaftaran',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }

                  if (!value.contains('@')) {
                    return 'Email harus mengandung @';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: hpController,
                decoration: const InputDecoration(
                  labelText: 'Nomor HP (Opsional)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller: kotaController,
                decoration: const InputDecoration(
                  labelText: 'Kota',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kota wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: daftar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
                child: const Text('Daftar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KonfirmasiPage extends StatelessWidget {
  final String nama;
  final String kota;

  const KonfirmasiPage({
    super.key,
    required this.nama,
    required this.kota,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Terima kasih, $nama dari $kota telah mendaftar.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}