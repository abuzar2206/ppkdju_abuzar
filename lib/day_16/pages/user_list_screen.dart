// import 'package:flutter/material.dart';

// import 'package:abuzar_android/day_16/database/databse_helper.dart';
// import '../model/user.dart';

// class UserListScreen extends StatefulWidget {
//   const UserListScreen({super.key});

//   @override
//   State<UserListScreen> createState() => _UserListScreenState();
// }

// class _UserListScreenState extends State<UserListScreen> {
//   late Future<List<User>> usersFuture;

//   @override
//   void initState() {
//     super.initState();

//     usersFuture = DatabaseHelper.instance.getUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PENGGUNA TERDAFTAR'),
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//       ),
//       body: FutureBuilder<List<User>>(
//         future: usersFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           final users = snapshot.data ?? [];

//           if (users.isEmpty) {
//             return const Center(
//               child: Text('Belum ada pengguna'),
//             );
//           }

//           return ListView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];

//               return Card(
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     child: Text(
//                       user.name[0].toUpperCase(),
//                     ),
//                   ),
//                   title: Text(user.name),
//                   subtitle: Text(
//                     '${user.email}\n'
//                     '${user.phone}\n'
//                     '${user.city}',
//                   ),
//                   isThreeLine: true,
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }