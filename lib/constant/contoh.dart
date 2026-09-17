// import 'package:abuzar_android/constant/app_colors.dart';
// import 'package:flutter/material.dart';


// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: AppColors.white,
//         appBar: AppBar(
//           backgroundColor: AppColors.primary,
//           title: AppText.button('Reusable Class'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AppImages.linkedin(
//                 width: 180,
//                 height: 60,
//               ),

//               const SizedBox(height: 20),

//               AppText.title('Welcome'),

//               const SizedBox(height: 10),

//               AppText.normal('Contoh penggunaan reusable class'),

//               const SizedBox(height: 20),

//               AppImages.google(
//                 width: 30,
//                 height: 30,
//               ),

//               const SizedBox(height: 10),

//               AppImages.apple(
//                 width: 30,
//                 height: 30,
//               ),

//               const SizedBox(height: 20),

//               Text(
//                 'Font Weight Reusable',
//                 style: TextStyle(
//                   color: AppColors.primary,
//                   fontSize: 18,
//                   fontWeight: AppFontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 20),

//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.blue,
//                 ),
//                 onPressed: () {},
//                 child: AppText.button('Continue'),
//               ),

//               const SizedBox(height: 10),

//               AppText.link('Forgot Password?'),

//               const SizedBox(height: 10),

//               Text(
//                 AppAssets.google,
//                 style: TextStyle(
//                   color: AppColors.grey,
//                   fontWeight: AppFontWeight.medium,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }