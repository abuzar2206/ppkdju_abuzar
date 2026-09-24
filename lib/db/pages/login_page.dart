// void register() async {
//     final user = userController.text.trim();
//     final pass = passController.text;

//     if (user.isEmpty || pass.isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Isi semua field!')));
//       return;
//     }

//     final pengguna = UserModelSQL(email: user, password: pass);

//     bool success = await DBHelper().registerUser(pengguna);

//     if (!mounted) return; // Menghindari linter warning: 'Don't use BuildContext across async gaps'

//     if (success) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Akun berhasil dibuat')));
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Email sudah terdaftar!')));
//     }
//   }

//   void login() async {
//     final user = userController.text.trim();
//     final pass = passController.text;

//     if (user.isEmpty || pass.isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Isi semua field!')));
//       return;
//     }

//     final pengguna = await DBHelper().loginUser(user, pass);

//     if (!mounted) return; // Menghindari linter warning penggunaan BuildContext

//     if (pengguna != null) {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (_) => const HomeScreen()),
//         (route) => false,
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Login gagal! email atau Password salah.'),
//         ),
//       );
//     }
//   }