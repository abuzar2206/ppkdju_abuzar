import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/attendance_model.dart';
import '../views/map_screen.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceModel attendance;
  final VoidCallback? onDelete;

  const AttendanceCard({
    super.key,
    required this.attendance,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isIzin = attendance.isIzin;
    final statusColor = isIzin ? Colors.orange : Colors.green;
    final statusBgColor = isIzin ? Colors.orange.shade50 : Colors.green.shade50;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    Text(
                      attendance.formattedDate,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBgColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor.withValues(alpha: 0.5)),
                  ),
                  child: Text(
                    (attendance.status ?? 'Masuk').toUpperCase(),
                    style: TextStyle(
                      color: statusColor.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.login, size: 16, color: Colors.green.shade600),
                          const SizedBox(width: 4),
                          const Text(
                            'Jam Masuk',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        attendance.formattedCheckInTime,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (attendance.checkInAddress != null &&
                          attendance.checkInAddress!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          attendance.checkInAddress!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.logout, size: 16, color: Colors.red.shade400),
                          const SizedBox(width: 4),
                          const Text(
                            'Jam Keluar',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        attendance.hasCheckedOut
                            ? attendance.formattedCheckOutTime
                            : (isIzin ? '-' : 'Belum Keluar'),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: attendance.hasCheckedOut
                              ? null
                              : (isIzin ? Colors.grey : Colors.orange.shade700),
                        ),
                      ),
                      if (attendance.checkOutAddress != null &&
                          attendance.checkOutAddress!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          attendance.checkOutAddress!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            if (isIzin &&
                attendance.alasanIzin != null &&
                attendance.alasanIzin!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.amber.shade900),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Alasan Izin: ${attendance.alasanIzin}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.amber.shade900,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (attendance.checkInLat != null && attendance.checkInLng != null)
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MapScreen(
                            location: LatLng(
                              attendance.checkInLat!,
                              attendance.checkInLng!,
                            ),
                            title: 'Lokasi Absen (${attendance.formattedDate})',
                            address: attendance.checkInAddress,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.location_on, size: 16),
                    label: const Text('Lihat Peta', style: TextStyle(fontSize: 12)),
                  ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    tooltip: 'Hapus Absen',
                    onPressed: onDelete,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
