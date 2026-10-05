import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/attendance_model.dart';
import '../services/attendance_service.dart';
import '../widgets/attendance_card.dart';

class _C {
  static const navy = Color(0xFF0B2A4A);
  static const navyLight = Color(0xFF1B4B7A);
  static const muted = Color(0xFF6B7A90);
  static const masuk = Color(0xFF1FA463);
  static const pulang = Color(0xFFE5484D);
  static const info = Color(0xFF2F80ED);
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<AttendanceModel> _historyList = [];
  bool _isLoading = true;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  Future<void> _fetchHistory() async {
    setState(() {
      _isLoading = true;
    });

    final String? start =
        _startDate != null ? DateFormat('yyyy-MM-dd').format(_startDate!) : null;
    final String? end =
        _endDate != null ? DateFormat('yyyy-MM-dd').format(_endDate!) : null;

    final list = await AttendanceService.getHistory(start: start, end: end);

    if (!mounted) return;

    setState(() {
      _historyList = list;
      _isLoading = false;
    });
  }

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(now.year + 1),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : DateTimeRange(
              start: now.subtract(const Duration(days: 7)),
              end: now,
            ),
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
      _fetchHistory();
    }
  }

  void _clearFilter() {
    setState(() {
      _startDate = null;
      _endDate = null;
    });
    _fetchHistory();
  }

  Future<void> _confirmDelete(AttendanceModel item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _C.pulang.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.delete_outline_rounded,
                  color: _C.pulang),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Hapus Absensi',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus data absen tanggal ${item.formattedDate}?',
          style: const TextStyle(height: 1.4),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final res = await AttendanceService.deleteAttendance(item.id);
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: res.success ? _C.masuk : _C.pulang,
            content: Row(
              children: [
                Icon(
                  res.success
                      ? Icons.check_circle_rounded
                      : Icons.error_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(res.message)),
              ],
            ),
          ),
        );

      if (res.success) {
        _fetchHistory();
      }
    }
  }

  // ───────────────────────────── BUILD ─────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isFiltered = _startDate != null || _endDate != null;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final bg = dark ? const Color(0xFF0E1726) : const Color(0xFFF3F6FB);

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          _buildHeader(isFiltered),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _historyList.isEmpty
                    ? _buildEmpty(isFiltered, dark)
                    : RefreshIndicator(
                        onRefresh: _fetchHistory,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(4, 12, 4, 24),
                          itemCount: _historyList.length,
                          itemBuilder: (context, index) {
                            final item = _historyList[index];
                            return AttendanceCard(
                              attendance: item,
                              onDelete: () => _confirmDelete(item),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isFiltered) {
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
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _headerIcon('Kembali', Icons.arrow_back_rounded,
                      () => Navigator.maybePop(context)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Riwayat Absensi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (!_isLoading)
                          Text(
                            '${_historyList.length} catatan',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.white.withValues(alpha: 0.75),
                            ),
                          ),
                      ],
                    ),
                  ),
                  _headerIcon(
                      'Filter Tanggal', Icons.date_range_rounded, _pickDateRange),
                  if (isFiltered)
                    _headerIcon(
                        'Reset Filter', Icons.filter_alt_off_rounded, _clearFilter),
                ],
              ),
              if (isFiltered) ...[
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.filter_alt_rounded,
                            size: 16, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Filter: ${_startDate != null ? DateFormat('dd/MM/yyyy').format(_startDate!) : '-'} s/d ${_endDate != null ? DateFormat('dd/MM/yyyy').format(_endDate!) : '-'}',
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: _clearFilter,
                          borderRadius: BorderRadius.circular(8),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                fontSize: 12.5,
                                color: Color(0xFFFFB4B6),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _headerIcon(String tooltip, IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        style: IconButton.styleFrom(
          backgroundColor: Colors.white.withValues(alpha: 0.12),
        ),
      ),
    );
  }

  Widget _buildEmpty(bool isFiltered, bool dark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(26),
              decoration: BoxDecoration(
                color: _C.info.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.history_rounded,
                size: 56,
                color: _C.info,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isFiltered
                  ? 'Tidak ada riwayat pada rentang tanggal ini'
                  : 'Belum ada riwayat absensi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: dark ? const Color(0xFFE8EEF7) : const Color(0xFF16233A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isFiltered
                  ? 'Coba ubah atau reset filter tanggal.'
                  : 'Data absensi Anda akan muncul di sini.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: _C.muted),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: _C.info,
                side: const BorderSide(color: _C.info, width: 1.4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: _fetchHistory,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text(
                'Muat Ulang',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
