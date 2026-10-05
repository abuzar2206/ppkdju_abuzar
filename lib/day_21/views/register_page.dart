import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dashboard_page.dart';
import 'login_page.dart';

class _C {
  static const navy = Color(0xFF0B2A4A);
  static const navyLight = Color(0xFF1B4B7A);
  static const bg = Color(0xFFF3F6FB);
  static const ink = Color.fromARGB(255, 25, 39, 65);
  static const muted = Color(0xFF6B7A90);
  static const masuk = Color(0xFF1FA463);
  static const pulang = Color(0xFFE5484D);
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool loading = false;

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loading = true;
    });

    final res = await AuthService.register(
      namaController.text.trim(),
      emailController.text.trim(),
      passwordController.text,
    );

    if (!mounted) return;

    setState(() {
      loading = false;
    });

    showMessage(
      res.message,
      isError: !res.success,
    );

    if (res.success) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardPage(),
        ),
        (route) => false,
      );
    }
  }

  void showMessage(
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          backgroundColor: isError ? _C.pulang : _C.masuk,
          content: Row(
            children: [
              Icon(
                isError ? Icons.error_rounded : Icons.check_circle_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      );
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration _decoration({
    required String label,
    required IconData icon,
    Widget? suffix,
  }) {
    OutlineInputBorder border(Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c, width: w),
        );
    return InputDecoration(
      labelText: label,
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
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 32),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          tooltip: 'Kembali',
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back_rounded,
                              color: Colors.white),
                          style: IconButton.styleFrom(
                            backgroundColor:
                                Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_add_alt_1_rounded,
                          size: 38,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Buat Akun Baru',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Lengkapi form di bawah untuk mendaftar akun',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
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
                  children: [
                    // NAMA
                    TextFormField(
                      controller: namaController,
                      textCapitalization: TextCapitalization.words,
                      decoration: _decoration(
                        label: 'Nama Lengkap',
                        icon: Icons.person_outline_rounded,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Nama lengkap wajib diisi';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // EMAIL
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _decoration(
                        label: 'Email',
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

                    // PASSWORD
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

                        if (val.length < 6) {
                          return 'Password minimal 6 karakter';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 28),

                    // TOMBOL REGISTER
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
                        onPressed: loading ? null : register,
                        child: loading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'DAFTAR SEKARANG',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.6,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // KE LOGIN
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah punya akun? ',
                          style: TextStyle(color: _C.muted),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(6),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 6),
                            child: Text(
                              'Login di sini',
                              style: TextStyle(
                                color: _C.navyLight,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
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
