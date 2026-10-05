import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../models/attendance_model.dart';
import '../models/user_model.dart';
import '../services/attendance_service.dart';
import '../services/auth_service.dart';
import '../services/location_service.dart';
import '../services/preference_service.dart';
import 'history_page.dart';
import 'login_page.dart';
import 'map_screen.dart';
import 'profile_page.dart';

/// Palet warna dashboard
class _C {
  static const navy = Color.fromARGB(255, 17, 63, 109);
  static const navyLight = Color(0xFF1B4B7A);
  static const bg = Color(0xFFF3F6FB);
  static const ink = Color(0xFF16233A);
  static const muted = Color(0xFF6B7A90);
  static const masuk = Color(0xFF1FA463);
  static const pulang = Color(0xFFE5484D);
  static const izin = Color(0xFFF59E0B);
  static const info = Color(0xFF2F80ED);
  static const selesai = Color(0xFF3B6FD8);
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isLoading = false;
  bool isLocationLoading = false;
  String? _activeAction; // 'masuk' | 'pulang' | 'izin'

  String locationText = 'Lokasi belum ditemukan';
  LatLng? currentLocation;
  String currentAddress = '';

  UserModel? currentUser;
  AttendanceModel? todayAttendance;
  List<AttendanceModel> historyList = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    currentUser = PreferenceService.getUser();
    _fetchUserData();
    _fetchLocation();
    _fetchAttendanceStats();
  }

  Future<void> _fetchUserData() async {
    final user = await AuthService.getProfile();
    if (mounted && user != null) {
      setState(() {
        currentUser = user;
      });
    }
  }

  Future<void> _fetchLocation() async {
    if (!mounted) return;
    setState(() {
      isLocationLoading = true;
    });

    final res = await LocationService.getCurrentLocation();

    if (!mounted) return;

    setState(() {
      currentLocation = res.position;
      currentAddress = res.address;
      locationText = res.address.isNotEmpty
          ? res.address
          : '${res.position.latitude.toStringAsFixed(4)}, ${res.position.longitude.toStringAsFixed(4)}';
      isLocationLoading = false;
    });
  }

  Future<void> _fetchAttendanceStats() async {
    try {
      final list = await AttendanceService.getHistory();
      if (!mounted) return;

      setState(() {
        historyList = list;
        todayAttendance = null;
        final now = DateTime.now();
        for (var item in list) {
          final dt = item.checkInDateTime;
          if (dt != null &&
              dt.year == now.year &&
              dt.month == now.month &&
              dt.day == now.day) {
            todayAttendance = item;
            break;
          }
        }
      });
    } catch (_) {}
  }

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 11) return 'Selamat Pagi';
    if (hour >= 11 && hour < 15) return 'Selamat Siang';
    if (hour >= 15 && hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  String get _initials {
    final name = (currentUser?.name ?? '').trim();
    if (name.isEmpty) return '?';
    final parts = name.split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  Future<void> openMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(
          location: currentLocation,
          title: 'Lokasi Presensi',
          address: currentAddress.isNotEmpty ? currentAddress : null,
        ),
      ),
    );

    if (result != null && result is Map && mounted) {
      setState(() {
        if (result['location'] is LatLng) {
          currentLocation = result['location'];
        }
        if (result['address'] is String) {
          currentAddress = result['address'];
          locationText = currentAddress;
        }
      });
    }
  }

  Future<void> checkIn() async {
    setState(() {
      isLoading = true;
      _activeAction = 'masuk';
    });

    try {
      if (currentLocation == null) {
        await _fetchLocation();
      }

      final pos = currentLocation ?? LocationService.defaultLocation;
      final addr = currentAddress.isNotEmpty
          ? currentAddress
          : '${pos.latitude}, ${pos.longitude}';

      final res = await AttendanceService.checkIn(
        latitude: pos.latitude,
        longitude: pos.longitude,
        address: addr,
        status: 'masuk',
      );

      if (!mounted) return;

      _showSnack(res.message, res.success);

      if (res.success) {
        await _fetchAttendanceStats();
      }
    } catch (e) {
      if (mounted) _showSnack('Check In gagal: $e', false);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
          _activeAction = null;
        });
      }
    }
  }

  Future<void> checkOut() async {
    setState(() {
      isLoading = true;
      _activeAction = 'pulang';
    });

    try {
      if (currentLocation == null) {
        await _fetchLocation();
      }

      final pos = currentLocation ?? LocationService.defaultLocation;
      final addr = currentAddress.isNotEmpty
          ? currentAddress
          : '${pos.latitude}, ${pos.longitude}';

      final res = await AttendanceService.checkOut(
        latitude: pos.latitude,
        longitude: pos.longitude,
        address: addr,
      );

      if (!mounted) return;

      _showSnack(res.message, res.success);

      if (res.success) {
        await _fetchAttendanceStats();
      }
    } catch (e) {
      if (mounted) _showSnack('Check Out gagal: $e', false);
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
          _activeAction = null;
        });
      }
    }
  }

  Future<void> submitIzin() async {
    final reasonController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _C.izin.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.assignment_outlined, color: _C.izin),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Pengajuan Izin',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ),
          ],
        ),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Silakan masukkan alasan izin Anda hari ini (misal: Izin Sakit, Keperluan Keluarga):',
                style: TextStyle(fontSize: 13, color: _C.muted, height: 1.4),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Alasan Izin',
                  hintText: 'Tuliskan alasan izin...',
                  filled: true,
                  fillColor: _C.bg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: _C.izin, width: 1.5),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'Alasan izin wajib diisi';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal', style: TextStyle(color: _C.muted)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: _C.izin,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx, true);
              }
            },
            child: const Text('Kirim Izin'),
          ),
        ],
      ),
    );

    if (confirmed == true && reasonController.text.trim().isNotEmpty) {
      setState(() {
        isLoading = true;
        _activeAction = 'izin';
      });

      if (currentLocation == null) {
        await _fetchLocation();
      }

      final pos = currentLocation ?? LocationService.defaultLocation;
      final addr = currentAddress.isNotEmpty
          ? currentAddress
          : '${pos.latitude}, ${pos.longitude}';

      final res = await AttendanceService.checkIn(
        latitude: pos.latitude,
        longitude: pos.longitude,
        address: addr,
        status: 'izin',
        alasanIzin: reasonController.text.trim(),
      );

      if (!mounted) return;

      setState(() {
        isLoading = false;
        _activeAction = null;
      });

      _showSnack(res.message, res.success);

      if (res.success) {
        await _fetchAttendanceStats();
      }
    }
  }

  Future<void> logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Konfirmasi Logout',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
        content: const Text(
          'Apakah Anda yakin ingin keluar dari akun?',
          style: TextStyle(color: _C.muted),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal', style: TextStyle(color: _C.muted)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: _C.pulang,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
      await PreferenceService.logout();
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          backgroundColor: success ? _C.masuk : _C.pulang,
          content: Row(
            children: [
              Icon(
                success ? Icons.check_circle_rounded : Icons.error_rounded,
                color: Colors.white,
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      );
  }

  // ───────────────────────────── BUILD ─────────────────────────────

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final formattedToday =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(today);

    String statusHariIni = 'Belum Absen';
    String statusSub = 'Ketuk "Absen Masuk" untuk memulai hari';
    IconData statusIcon = Icons.schedule_rounded;
    Color statusColor = const Color(0xFF9AA8BD);
    if (todayAttendance != null) {
      if (todayAttendance!.isIzin) {
        statusHariIni = 'Izin: ${todayAttendance!.alasanIzin ?? ''}';
        statusColor = _C.izin;
        statusIcon = Icons.assignment_turned_in_rounded;
      } else if (todayAttendance!.hasCheckedOut) {
        statusHariIni =
            'Selesai (Pulang ${todayAttendance!.formattedCheckOutTime})';
        statusColor = _C.selesai;
        statusIcon = Icons.verified_rounded;
      } else {
        statusHariIni =
            'Sudah Masuk (${todayAttendance!.formattedCheckInTime})';
        statusColor = _C.masuk;
        statusIcon = Icons.check_circle_rounded;
      }
      statusSub =
          'Alamat: ${todayAttendance!.checkInAddress ?? todayAttendance!.checkInLocation ?? '-'}';
    }

    final totalAbsen = historyList.length;
    final totalMasuk = historyList.where((e) => e.isMasuk).length;
    final totalIzin = historyList.where((e) => e.isIzin).length;

    return Scaffold(
      backgroundColor: _C.bg,
      body: RefreshIndicator(
        color: _C.navy,
        onRefresh: () async {
          await _fetchUserData();
          await _fetchLocation();
          await _fetchAttendanceStats();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(formattedToday, statusHariIni, statusSub,
                  statusIcon, statusColor),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem('Total', totalAbsen.toString(),
                              _C.info, Icons.event_note_rounded),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatItem('Masuk', totalMasuk.toString(),
                              _C.masuk, Icons.login_rounded),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildStatItem('Izin', totalIzin.toString(),
                              _C.izin, Icons.assignment_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildLocationCard(),
                    const SizedBox(height: 24),
                    const Text(
                      'Presensi',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: _C.ink,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            label: 'Absen Masuk',
                            icon: Icons.login_rounded,
                            color: _C.masuk,
                            loading: isLoading && _activeAction == 'masuk',
                            onTap: isLoading ? null : checkIn,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            label: 'Absen Pulang',
                            icon: Icons.logout_rounded,
                            color: _C.pulang,
                            loading: isLoading && _activeAction == 'pulang',
                            onTap: isLoading ? null : checkOut,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTile(
                            label: 'Form Izin',
                            sub: 'Ajukan izin hari ini',
                            icon: Icons.assignment_outlined,
                            color: _C.izin,
                            loading: isLoading && _activeAction == 'izin',
                            onTap: isLoading ? null : submitIzin,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTile(
                            label: 'Lihat Map',
                            sub: 'Cek lokasi presensi',
                            icon: Icons.map_rounded,
                            color: _C.info,
                            onTap: openMap,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ───────────────────────────── WIDGETS ─────────────────────────────

  Widget _buildHeader(String date, String status, String sub, IconData icon,
      Color statusColor) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_C.navy, _C.navyLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 12, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'ABSENSI PPKD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  _headerIcon('Riwayat Absen', Icons.history_rounded, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const HistoryPage()),
                    ).then((_) => _fetchAttendanceStats());
                  }),
                  _headerIcon('Profil Saya', Icons.person_rounded, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    ).then((_) => _loadInitialData());
                  }),
                  _headerIcon('Logout', Icons.logout_rounded, logout),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.15),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                      child: Text(
                        _initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$_greeting,',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                          Text(
                            currentUser?.name ?? 'Pengguna',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today_rounded,
                        size: 14, color: Colors.white.withValues(alpha: 0.7)),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(icon, color: statusColor, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Status Absen Hari Ini',
                              style: TextStyle(
                                color: _C.muted,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              status,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _C.ink,
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              sub,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _C.muted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerIcon(String tooltip, IconData icon, VoidCallback onPressed) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.12),
      ),
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildStatItem(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: _C.navy.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: _C.ink,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: _C.muted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    final found = currentLocation != null;
    final color = found ? _C.info : _C.izin;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      shadowColor: Colors.transparent,
      child: InkWell(
        onTap: openMap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.location_on_rounded, size: 26, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            found
                                ? 'Lokasi Anda (Klik untuk Buka Peta)'
                                : 'Lokasi Belum Ditemukan (Klik Buka Peta)',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                              color: color,
                            ),
                          ),
                        ),
                        if (isLocationLoading) ...[
                          const SizedBox(width: 8),
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      locationText,
                      style: const TextStyle(
                        fontSize: 14,
                        color: _C.ink,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: _C.muted),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required bool loading,
    required VoidCallback? onTap,
  }) {
    final disabled = onTap == null;
    return Opacity(
      opacity: disabled && !loading ? 0.55 : 1,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 112,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Icon(icon, color: Colors.white, size: 22),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile({
    required String label,
    required String sub,
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
    bool loading = false,
  }) {
    return Opacity(
      opacity: onTap == null && !loading ? 0.55 : 1,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: loading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: color,
                            strokeWidth: 2.5,
                          ),
                        )
                      : Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: _C.ink,
                        ),
                      ),
                      Text(
                        sub,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 11, color: _C.muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}