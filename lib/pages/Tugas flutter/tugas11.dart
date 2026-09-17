// import 'package:flutter/material.dart';

// void main() {
//   runApp(const Tugas11());
// }

// class Tugas11 extends StatelessWidget {
//   const Tugas11({super.key});

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
//                 Text(
//                   'Nomor HP: ${hpController.text.isEmpty ? '-' : hpController.text}',
//                 ),
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
//   }}