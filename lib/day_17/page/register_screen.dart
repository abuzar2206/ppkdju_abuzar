import 'package:flutter/material.dart';

import 'package:abuzar_android/day_17/database/database_helper.dart';
import '../model/user.dart';
import 'user_list_screen.dart';

class RegisterScreen extends StatefulWidget {
  final User? user;

  const RegisterScreen({
    super.key,
    this.user,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final cityController = TextEditingController();

  bool get isEdit => widget.user != null;

  @override
  void initState() {
    super.initState();

    if (widget.user != null) {
      nameController.text = widget.user!.name;
      emailController.text = widget.user!.email;
      phoneController.text = widget.user!.phone;
      passwordController.text = widget.user!.password;
      cityController.text = widget.user!.city;
    }
  }

  Future<void> saveUser() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final user = User(
      id: widget.user?.id,
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      password: passwordController.text,
      city: cityController.text,
    );

    if (isEdit) {
      await DatabaseHelper.instance.updateUser(user);

      if (!mounted) return;

      Navigator.pop(context, true);
    } else {
      await DatabaseHelper.instance.insertUser(user);

      nameController.clear();
      emailController.clear();
      phoneController.clear();
      passwordController.clear();
      cityController.clear();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data berhasil disimpan'),
        ),
      );
    }
  }

  Widget inputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool password = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: password,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label wajib diisi';
          }

          if (label == 'Email' && !value.contains('@')) {
            return 'Email tidak valid';
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    cityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'EDIT DATA' : 'DAFTAR AKUN'),
        backgroundColor: const Color.fromARGB(255, 45, 151, 244),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                isEdit
                    ? 'Ubah Data Pengguna'
                    : 'Silakan Isi Data Pendaftaran',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              inputField(
                label: 'Nama',
                controller: nameController,
                icon: Icons.person,
              ),

              inputField(
                label: 'Email',
                controller: emailController,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),

              inputField(
                label: 'Nomor HP',
                controller: phoneController,
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              inputField(
                label: 'Password',
                controller: passwordController,
                icon: Icons.lock,
                password: true,
              ),

              inputField(
                label: 'Asal Kota',
                controller: cityController,
                icon: Icons.location_city,
              ),

              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: saveUser,
                  child: Text(
                    isEdit ? 'Update' : 'Daftar',
                  ),
                ),
              ),

              const SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const UserListScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.people),
                  label: const Text('Pengguna Terdaftar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}