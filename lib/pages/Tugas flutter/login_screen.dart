import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const LinkedInLoginApp());
}

class LinkedInLoginApp extends StatelessWidget {
  const LinkedInLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;

          return Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Stack(
              children: [
                // Logo
                Positioned(
                  left: width * 0.075,
                  top: height * 0.035,
                  child: SizedBox(
                    width: width * 1.26,
                    height: height * 0.05,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),

                // Sign in
                Positioned(
                  left: width * 0.085,
                  top: height * 0.120,
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Positioned(
                  left: width * 0.09,
                  top: height * 0.180,
                  child: const Text(
                    'Stay updated on your professional world',
                    style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Email / Phone
                Positioned(
                  left: width * 0.085,
                  right: width * 0.085,
                  top: height * 0.235,
                  height: height * 0.067,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email or Phone',
                      hintStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF777777),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF0A66C2),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                // Password
                Positioned(
                  left: width * 0.085,
                  right: width * 0.085,
                  top: height * 0.335,
                  height: height * 0.067,
                  child: TextField(
                    obscureText: !_showPassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF777777),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF0A66C2),
                          width: 2,
                        ),
                      ),
                      suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Text(
                          _showPassword ? 'hide' : 'show',
                          style: const TextStyle(
                            color: Color(0xFF0A66C2),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Forgot Password
                Positioned(
                  left: width * 0.085,
                  top: height * 0.410,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Forgot Password ditekan');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: const Color(0xFF0A66C2),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF0A66C2),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Sign in button
                Positioned(
                  left: width * 0.085,
                  right: width * 0.085,
                  top: height * 0.475,
                  height: height * 0.067,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2386ED),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Or
                Positioned(
                  left: width * 0.085,
                  right: width * 0.085,
                  top: height * 0.565,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color.fromARGB(255, 167, 166, 166),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color.fromARGB(255, 182, 180, 180),
                        ),
                      ),
                    ],
                  ),
                ),

                // Google
                Positioned(
                  left: width * 0.085,
                  right: width * 0.085,
                  top: height * 0.605,
                  height: height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Apple
                Positioned(
                  left: width * 0.085,
                  right: width * 0.085,
                  top: height * 0.695,
                  height: height * 0.06,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Apple.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Sign in with Apple',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Join now
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New to LinkedIn? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Join now',
                          style: TextStyle(
                            color: Color.fromARGB(255, 47, 77, 248),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InputBox extends StatelessWidget {
  final String hint;

  const _InputBox({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF777777), width: 1),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        hint,
        style: const TextStyle(
          color: Color.fromARGB(255, 134, 133, 133),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _PasswordBox extends StatelessWidget {
  const _PasswordBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 116, 114, 114),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Password',
              style: TextStyle(
                color: Color(0xFF888888),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'show',
              style: TextStyle(
                color: Color(0xFF0A66C2),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
