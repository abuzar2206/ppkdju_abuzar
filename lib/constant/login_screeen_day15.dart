
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart' as p;
// import 'package:abuzar_android/day_15/preference_handler.dart';

// // MODEL
// class UserModelsSQL {
//   final int? id;
//   final String email;
//   final String password;

//   UserModelsSQL({
//     this.id,
//     required this.email,
//     required this.password,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'email': email,
//       'password': password,
//     };
//   }

//   factory UserModelsSQL.fromMap(Map<String, dynamic> map) {
//     return UserModelsSQL(
//       id: map['id'],
//       email: map['email'],
//       password: map['password'],
//     );
//   }
// }

// // DATABASE
// class DBHelper {
//   Future<Database> get database async {
//     final path = p.join(
//   await getDatabasesPath(),
//   'users.db',
// );
//     return openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE users (
//             id INTEGER PRIMARY KEY AUTOINCREMENT,
//             email TEXT UNIQUE,
//             password TEXT
//           )
//         ''');
//       },
//     );
//   }

//   Future<bool> registerUser(UserModelsSQL pengguna) async {
//     final db = await database;

//     try {
//       await db.insert('users', pengguna.toMap());
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<UserModelsSQL?> loginUser(
//     String email,
//     String password,
//   ) async {
//     final db = await database;

//     final results = await db.query(
//       'users',
//       where: 'email = ? AND password = ?',
//       whereArgs: [email, password],
//     );

//     if (results.isNotEmpty) {
//       return UserModelsSQL.fromMap(results.first);
//     }

//     return null;
//   }
// }

// // LOGIN SCREEN
// class LoginScreenDay15 extends StatefulWidget {
//   const LoginScreenDay15({super.key});

//   @override
//   State<LoginScreenDay15> createState() =>
//       _LoginScreenDay15State();
// }

// class _LoginScreenDay15State
//     extends State<LoginScreenDay15> {
//   final _formKey = GlobalKey<FormState>();
//   final userController = TextEditingController();
//   final passController = TextEditingController();

//   void register() async {
//     final user = userController.text.trim();
//     final pass = passController.text;

//     if (!_formKey.currentState!.validate()) return;

//     final pengguna = UserModelsSQL(
//       email: user,
//       password: pass,
//     );

//     final success =
//         await DBHelper().registerUser(pengguna);

//     if (!mounted) return;

//     ScaffoldMessenger.of(this.context).showSnackBar(
//       SnackBar(
//         content: Text(
//           success
//               ? 'Akun berhasil dibuat'
//               : 'Email sudah terdaftar!',
//         ),
//       ),
//     );
//   }

//   void login() async {
//     if (!_formKey.currentState!.validate()) return;

//     final user = userController.text.trim();
//     final pass = passController.text;

//     final pengguna =
//         await DBHelper().loginUser(user, pass);

//     if (!mounted) return;

//     if (pengguna != null) {
//       await PreferenceHandler.setLogin(true);

//       if (!mounted) return;

//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (_) =>
//               HalamanTerimaKasih(email: user),
//         ),
//         (route) => false,
//       );
//     } else {
//       ScaffoldMessenger.of(this.context).showSnackBar(
//         const SnackBar(
//           content: Text('Email atau password salah!'),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     userController.dispose();
//     passController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: Padding(
//             padding: const EdgeInsets.all(24),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     const Icon(
//                       Icons.lock,
//                       size: 80,
//                       color: Colors.blue,
//                     ),

//                     const SizedBox(height: 24),

//                     const Text(
//                       'Login',
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 32),

//                     TextFormField(
//                       controller: userController,
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty) {
//                           return 'Email wajib diisi';
//                         }

//                         if (!value.contains('@')) {
//                           return 'Format email tidak valid';
//                         }

//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         prefixIcon:
//                             const Icon(Icons.email),
//                         border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     TextFormField(
//                       controller: passController,
//                       obscureText: true,
//                       validator: (value) {
//                         if (value == null ||
//                             value.isEmpty) {
//                           return 'Password wajib diisi';
//                         }

//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         prefixIcon:
//                             const Icon(Icons.lock),
//                         border: OutlineInputBorder(
//                           borderRadius:
//                               BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: login,
//                         child: const Text('LOGIN'),
//                       ),
//                     ),

//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: register,
//                         child: const Text('REGISTER'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // HALAMAN UTAMA
// class HalamanTerimaKasih extends StatelessWidget {
//   final String email;

//   const HalamanTerimaKasih({
//     super.key,
//     required this.email,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Halaman Utama'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Selamat datang, $email',
//               style: const TextStyle(fontSize: 18),
//             ),

//             const SizedBox(height: 24),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await PreferenceHandler.logOut();

//                   if (!context.mounted) return;

//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) =>
//                           const LoginScreenDay15(),
//                     ),
//                     (route) => false,
//                   );
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.red,
//                 ),
//                 child: const Text(
//                   'LOGOUT',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }