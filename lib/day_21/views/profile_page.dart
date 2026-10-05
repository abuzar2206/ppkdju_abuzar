import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/preference_service.dart';
import 'login_page.dart';

class _C {
  static const navy = Color(0xFF0B2A4A);
  static const navyLight = Color(0xFF1B4B7A);
  static const muted = Color(0xFF6B7A90);
  static const masuk = Color(0xFF1FA463);
  static const pulang = Color(0xFFE5484D);
  static const info = Color(0xFF2F80ED);
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  UserModel? _user;

  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
    });

    // Ambil data user yang tersimpan
    final cachedUser = PreferenceService.getUser();

    if (cachedUser != null) {
      _user = cachedUser;
      _nameController.text = cachedUser.name;
      _emailController.text = cachedUser.email;
    }

    // Ambil data terbaru dari API
    final fetched = await AuthService.getProfile();

    if (!mounted) return;

    if (fetched != null) {
      setState(() {
        _user = fetched;
        _nameController.text = fetched.name;
        _emailController.text = fetched.email;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProfile() async {
    final newName = _nameController.text.trim();

    if (newName.isEmpty) {
      _showSnack('Nama tidak boleh kosong', false);
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final res = await AuthService.updateProfile(newName);

    if (!mounted) return;

    setState(() {
      _isSaving = false;

      if (res.user != null) {
        _user = res.user;
        _nameController.text = res.user!.name;
        _emailController.text = res.user!.email;
      }
    });

    _showSnack(res.message, res.success);
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: const Text(
          'Konfirmasi Logout',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari aplikasi?',
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: _C.pulang,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await AuthService.logout();

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
        (route) => false,
      );
    }
  }

  void _showSnack(String message, bool success) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: success ? _C.masuk : _C.pulang,
          content: Row(
            children: [
              Icon(
                success
                    ? Icons.check_circle_rounded
                    : Icons.error_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(message),
              ),
            ],
          ),
        ),
      );
  }

  String get _initials {
    final name = (_user?.name ?? '').trim();

    if (name.isEmpty) {
      return '?';
    }

    final parts = name.split(RegExp(r'\s+'));

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF3F6FB);
    const card = Colors.white;
    const ink = Color(0xFF16233A);
    const line = Color(0xFFE1E7F0);

    return Scaffold(
      backgroundColor: bg,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      32,
                    ),
                    child: Column(
                      children: [
                        _buildEditCard(
                          card,
                          ink,
                          line,
                        ),
                        const SizedBox(height: 16),
                        _buildSettingsCard(
                          card,
                          ink,
                          line,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _C.navy,
            _C.navyLight,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(36),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            12,
            8,
            12,
            28,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _headerIcon(
                    'Kembali',
                    Icons.arrow_back_rounded,
                    () => Navigator.maybePop(context),
                  ),

                  const Expanded(
                    child: Text(
                      'Profil Saya',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  _headerIcon(
                    'Logout',
                    Icons.logout_rounded,
                    _logout,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                width: 92,
                height: 92,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(
                    alpha: 0.15,
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(
                      alpha: 0.55,
                    ),
                    width: 3,
                  ),
                ),
                child: Text(
                  _initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  _user?.name ?? 'Nama Pengguna',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                _user?.email ?? 'email@example.com',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(
                    alpha: 0.8,
                  ),
                ),
              ),

              if (_user?.id != null) ...[
                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.16,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'ID Pengguna: #${_user!.id}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerIcon(
    String tooltip,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(
          alpha: 0.12,
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration(
    Color card,
    Color line,
  ) {
    return BoxDecoration(
      color: card,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: line,
      ),
    );
  }

  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    required Color fill,
    required Color line,
  }) {
    OutlineInputBorder border(
      Color color, [
      double width = 1,
    ]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: color,
          width: width,
        ),
      );
    }

    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: _C.muted,
      ),
      filled: true,
      fillColor: fill,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: border(line),
      enabledBorder: border(line),
      disabledBorder: border(line),
      focusedBorder: border(
        _C.info,
        1.8,
      ),
    );
  }

  Widget _buildEditCard(
    Color card,
    Color ink,
    Color line,
  ) {
    const fill = Color(0xFFF7F9FC);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(
        card,
        line,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _C.info.withValues(
                    alpha: 0.12,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.edit_rounded,
                  size: 18,
                  color: _C.info,
                ),
              ),

              const SizedBox(width: 10),

              Text(
                'Edit Informasi Akun',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: ink,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          TextField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: _fieldDecoration(
              label: 'Nama Lengkap',
              icon: Icons.person_outline_rounded,
              fill: fill,
              line: line,
            ),
          ),

          const SizedBox(height: 14),

          TextField(
            enabled: false,
            controller: _emailController,
            decoration: _fieldDecoration(
              label: 'Email (Tidak dapat diubah)',
              icon: Icons.email_outlined,
              fill: const Color(0xFFEDF1F7),
              line: line,
            ),
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _C.navyLight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed:
                  _isSaving ? null : _updateProfile,
              icon: _isSaving
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Icon(
                      Icons.save_rounded,
                    ),
              label: Text(
                _isSaving
                    ? 'Menyimpan...'
                    : 'Simpan Perubahan',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(
    Color card,
    Color ink,
    Color line,
  ) {
    return Container(
      decoration: _cardDecoration(
        card,
        line,
      ),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 8,
        ),
        leading: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            color: _C.pulang.withValues(
              alpha: 0.12,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.exit_to_app_rounded,
            color: _C.pulang,
            size: 22,
          ),
        ),
        title: const Text(
          'Keluar (Logout)',
          style: TextStyle(
            color: _C.pulang,
            fontWeight: FontWeight.w800,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: _C.muted,
        ),
        onTap: _logout,
      ),
    );
  }
}
