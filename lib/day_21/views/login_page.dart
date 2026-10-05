import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dashboard_page.dart';
import 'register_page.dart';

class _C {
  static const navy = Color(0xFF0B2A4A);
  static const navyLight = Color(0xFF1B4B7A);
  static const bg = Color(0xFFF3F6FB);
  static const ink = Color(0xFF16233A);
  static const muted = Color(0xFF6B7A90);
  static const masuk = Color(0xFF1FA463);
  static const pulang = Color(0xFFE5484D);
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool isLoading = false;

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final res = await AuthService.login(
      emailController.text.trim(),
      passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          backgroundColor: res.success ? _C.masuk : _C.pulang,
          content: Row(
            children: [
              Icon(
                res.success ? Icons.check_circle_rounded : Icons.error_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(res.message)),
            ],
          ),
        ),
      );

    if (res.success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPage()),
        (route) => false,
      );
    }
  }

  void goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration _decoration({
    required String label,
    required IconData icon,
    String? hint,
    Widget? suffix,
  }) {
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c, width: w),
        );
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: _C.muted),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: border(const Color(0xFFE1E7F0)),
      enabledBorder: border(const Color(0xFFE1E7F0)),
      focusedBorder: border(_C.navyLight, 1.8),
      errorBorder: border(_C.pulang),
      focusedErrorBorder: border(_C.pulang, 1.8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [_C.navy, _C.navyLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 36, 24, 44),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          size: 46,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'ABSENSI PPKD',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Silakan masuk dengan akun Anda',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selamat datang kembali',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: _C.ink,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _decoration(
                        label: 'Email',
                        hint: 'nama@example.com',
                        icon: Icons.email_outlined,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Email wajib diisi';
                        }
                        if (!val.contains('@') || !val.contains('.')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: !showPassword,
                      decoration: _decoration(
                        label: 'Password',
                        icon: Icons.lock_outline_rounded,
                        suffix: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility_rounded
                                : Icons.visibility_off_rounded,
                            color: _C.muted,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Password wajib diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: _C.navy,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: isLoading ? null : login,
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'Belum punya akun?',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: _C.muted.withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _C.navy,
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: _C.navy, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: isLoading ? null : goToRegister,
                        child: const Text(
                          'DAFTAR AKUN BARU',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
