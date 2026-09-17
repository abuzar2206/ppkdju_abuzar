// import 'package:flutter/material.dart';

// void main() {
//   runApp(const Tugas10());
// }

// class Tugas10 extends StatelessWidget {
//   const Tugas10({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Form Pendaftaran',
//       home: const FormPage(),
//     );
//   }
// }

// class FormPage extends StatefulWidget {
//   const FormPage({super.key});

//   @override
//   State<FormPage> createState() => _FormPageState();
// }

// class _FormPageState extends State<FormPage> {
//   final _formKey = GlobalKey<FormState>();

//   final namaController = TextEditingController();
//   final emailController = TextEditingController();
//   final hpController = TextEditingController();
//   final kotaController = TextEditingController();

//   void daftar() {
//     if (_formKey.currentState!.validate()) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Data Pendaftaran'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Nama: ${namaController.text}'),
//                 Text('Email: ${emailController.text}'),
//                 Text('Nomor HP: ${hpController.text}',),
//                 Text('Kota: ${kotaController.text}'),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Batal'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ConfirmationPage(
//                         nama: namaController.text,
//                         kota: kotaController.text,
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text('Lanjut'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   void dispose() {
//     namaController.dispose();
//     emailController.dispose();
//     hpController.dispose();
//     kotaController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Form Pendaftaran'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: namaController,
//                 decoration: const InputDecoration(
//                   labelText: 'Nama Lengkap',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Nama wajib diisi';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Email wajib diisi';
//                   }
//                   if (!value.contains('@')) {
//                     return 'Email harus mengandung @';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 controller: hpController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(
//                   labelText: 'Nomor HP',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 controller: kotaController,
//                 decoration: const InputDecoration(
//                   labelText: 'Kota',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Kota wajib diisi';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 25),
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: daftar,
//                   child: const Text(
//                     'Daftar',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ConfirmationPage extends StatelessWidget {
//   final String nama;
//   final String kota;

//   const ConfirmationPage({
//     super.key,
//     required this.nama,
//     required this.kota,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Konfirmasi'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Text(
//             'Terima kasih, $nama dari $kota telah mendaftar.',
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }