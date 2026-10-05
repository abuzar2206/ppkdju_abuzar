import '../models/attendance_model.dart';
import 'api_service.dart';

class AttendanceResult {
  final bool success;
  final String message;
  final AttendanceModel? attendance;

  AttendanceResult({
    required this.success,
    required this.message,
    this.attendance,
  });
}

class AttendanceService {
  static Future<AttendanceResult> checkIn({
    required double latitude,
    required double longitude,
    required String address,
    String status = 'masuk',
    String? alasanIzin,
  }) async {
    final Map<String, dynamic> body = {
      'check_in_lat': latitude.toString(),
      'check_in_lng': longitude.toString(),
      'check_in_location': '$latitude, $longitude',
      'check_in_address': address,
      'status': status,
    };

    if (status == 'izin' && alasanIzin != null && alasanIzin.isNotEmpty) {
      body['alasan_izin'] = alasanIzin;
    }

    final result = await ApiService.post(
      '/api/absen/check-in',
      body,
    );

    AttendanceModel? model;
    if (result['data'] != null && result['data'] is Map) {
      model = AttendanceModel.fromJson(Map<String, dynamic>.from(result['data']));
    }

    return AttendanceResult(
      success: result['success'] == true,
      message: result['message'] ?? (result['success'] == true ? 'Absen berhasil dicatat' : 'Gagal melakukan absen'),
      attendance: model,
    );
  }

  static Future<AttendanceResult> checkOut({
    required double latitude,
    required double longitude,
    required String address,
  }) async {
    final Map<String, dynamic> body = {
      'check_out_lat': latitude.toString(),
      'check_out_lng': longitude.toString(),
      'check_out_location': '$latitude, $longitude',
      'check_out_address': address,
    };

    final result = await ApiService.post(
      '/api/absen/check-out',
      body,
    );

    AttendanceModel? model;
    if (result['data'] != null && result['data'] is Map) {
      model = AttendanceModel.fromJson(Map<String, dynamic>.from(result['data']));
    }

    return AttendanceResult(
      success: result['success'] == true,
      message: result['message'] ?? (result['success'] == true ? 'Absen keluar berhasil' : 'Gagal absen keluar'),
      attendance: model,
    );
  }

  static Future<List<AttendanceModel>> getHistory({
    String? start,
    String? end,
  }) async {
    Map<String, dynamic>? query;
    if (start != null && end != null) {
      query = {'start': start, 'end': end};
    } else if (start != null) {
      query = {'start': start};
    }

    final result = await ApiService.get(
      '/api/absen/history',
      queryParameters: query,
    );

    if (result['data'] is List) {
      final List list = result['data'];
      return list
          .map((item) => AttendanceModel.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }

    return [];
  }

  static Future<AttendanceResult> deleteAttendance(int id) async {
    final result = await ApiService.delete(
      '/api/absen/$id',
    );

    return AttendanceResult(
      success: result['success'] == true,
      message: result['message'] ?? (result['success'] == true ? 'Data absen berhasil dihapus' : 'Gagal menghapus data absen'),
    );
  }

  static Future<AttendanceModel?> getTodayAttendance() async {
    try {
      final history = await getHistory();
      if (history.isEmpty) return null;

      final now = DateTime.now();
      for (var item in history) {
        final dt = item.checkInDateTime;
        if (dt != null) {
          if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
            return item;
          }
        }
      }
    } catch (_) {}
    return null;
  }
}
