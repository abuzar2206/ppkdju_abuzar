// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

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
//     return <String, dynamic>{
//       'id': id,
//       'email': email,
//       'password': password,
//     };
//   }

//   factory UserModelsSQL.fromMap(Map<String, dynamic> map) {
//     return UserModelsSQL(
//       id: map['id'] != null ? map['id'] as int : null,
//       email: map['email'] as String,
//       password: map['password'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserModelsSQL.fromJson(String source) => UserModelsSQL.fromMap(json.decode(source) as Map<String, dynamic>);
// }

// Future<bool> registerUser(UserModelSQL pengguna) async {
//     final db = await database;

//     try {
//       await db.insert('users', pengguna.toMap());
//       print('User registered: ${pengguna.email}');
//       return true;
//     } catch (e) {
//       print('Error registering user: $e');
//       return false;
//     }
//   }

//   Future<UserModelSQL?> loginUser(String email, String password) async {
//     final db = await database;

//     final List<Map<String, dynamic>> results = await db.query(
//       'users',
//       where: 'email = ? AND password = ?',
//       whereArgs: [email, password],
//     );

//     if (results.isNotEmpty) {
//       return UserModelSQL.fromMap(results.first);
//     }
//     return null;
//   }