// import 'package:flutter/material.dart';

// import 'package:abuzar_android/day_16/database/databse_helper.dart';
// import '../model/user.dart';
// import 'user_list_screen.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final formKey = GlobalKey<FormState>();

//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final passwordController = TextEditingController();
//   final cityController = TextEditingController();

//   Future<void> saveUser() async {
//     if (formKey.currentState!.validate()) {
//       final user = User(
//         name: nameController.text,
//         email: emailController.text,
//         phone: phoneController.text,
//         password: passwordController.text,
//         city: cityController.text,
//       );

//       await DatabaseHelper.instance.insertUser(user);

//       nameController.clear();
//       emailController.clear();
//       phoneController.clear();
//       passwordController.clear();
//       cityController.clear();

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Data berhasil disimpan'),
//         ),
//       );
//     }
//   }

//   Widget inputField({
//     required String label,
//     required TextEditingController controller,
//     required IconData icon,
//     bool password = false,
//     TextInputType? keyboardType,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextFormField(
//         controller: controller,
//         obscureText: password,
//         keyboardType: keyboardType,
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return '$label wajib diisi';
//           }

//           if (label == 'Email' && !value.contains('@')) {
//             return 'Email tidak valid';
//           }

//           return null;
//         },
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           border: const OutlineInputBorder(),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     passwordController.dispose();
//     cityController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('DAFTAR AKUN'),
//         backgroundColor: const Color.fromARGB(255, 13, 113, 190),
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               const Text(
//                 'Silakan isi data pendaftaran',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 20),

//               inputField(
//                 label: 'Nama',
//                 controller: nameController,
//                 icon: Icons.person,
//               ),

//               inputField(
//                 label: 'Email',
//                 controller: emailController,
//                 icon: Icons.email,
//                 keyboardType: TextInputType.emailAddress,
//               ),

//               inputField(
//                 label: 'Nomor HP',
//                 controller: phoneController,
//                 icon: Icons.phone,
//                 keyboardType: TextInputType.phone,
//               ),

//               inputField(
//                 label: 'Password',
//                 controller: passwordController,
//                 icon: Icons.lock,
//                 password: true,
//               ),

//               inputField(
//                 label: 'Asal Kota',
//                 controller: cityController,
//                 icon: Icons.location_city,
//               ),

//               const SizedBox(height: 8),

//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: saveUser,
//                   child: const Text('Daftar'),
//                 ),
//               ),

//               const SizedBox(height: 15),

//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: OutlinedButton.icon(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const UserListScreen(),
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.people),
//                   label: const Text('Pengguna Terdaftar'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }