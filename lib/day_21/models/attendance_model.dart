import 'package:intl/intl.dart';

class AttendanceModel {
  final int id;
  final int? userId;
  final String? checkIn;
  final String? checkOut;
  final String? checkInLocation;
  final String? checkInAddress;
  final String? checkOutLocation;
  final String? checkOutAddress;
  final double? checkInLat;
  final double? checkInLng;
  final double? checkOutLat;
  final double? checkOutLng;
  final String? status;
  final String? alasanIzin;
  final String? createdAt;
  final String? updatedAt;

  AttendanceModel({
    required this.id,
    this.userId,
    this.checkIn,
    this.checkOut,
    this.checkInLocation,
    this.checkInAddress,
    this.checkOutLocation,
    this.checkOutAddress,
    this.checkInLat,
    this.checkInLng,
    this.checkOutLat,
    this.checkOutLng,
    this.status,
    this.alasanIzin,
    this.createdAt,
    this.updatedAt,
  });

  static double? _parseDouble(dynamic val) {
    if (val == null) return null;
    if (val is num) return val.toDouble();
    if (val is String) return double.tryParse(val);
    return null;
  }

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    double? lat = _parseDouble(json['check_in_lat']);
    double? lng = _parseDouble(json['check_in_lng']);

    if ((lat == null || lng == null) && json['check_in_location'] != null) {
      final parts = json['check_in_location'].toString().split(',');
      if (parts.length == 2) {
        lat ??= double.tryParse(parts[0].trim());
        lng ??= double.tryParse(parts[1].trim());
      }
    }

    double? outLat = _parseDouble(json['check_out_lat']);
    double? outLng = _parseDouble(json['check_out_lng']);
    if ((outLat == null || outLng == null) && json['check_out_location'] != null) {
      final parts = json['check_out_location'].toString().split(',');
      if (parts.length == 2) {
        outLat ??= double.tryParse(parts[0].trim());
        outLng ??= double.tryParse(parts[1].trim());
      }
    }

    return AttendanceModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      userId: json['user_id'] is int ? json['user_id'] : int.tryParse(json['user_id']?.toString() ?? ''),
      checkIn: json['check_in']?.toString(),
      checkOut: json['check_out']?.toString(),
      checkInLocation: json['check_in_location']?.toString(),
      checkInAddress: json['check_in_address']?.toString(),
      checkOutLocation: json['check_out_location']?.toString(),
      checkOutAddress: json['check_out_address']?.toString(),
      checkInLat: lat,
      checkInLng: lng,
      checkOutLat: outLat,
      checkOutLng: outLng,
      status: json['status']?.toString(),
      alasanIzin: json['alasan_izin']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'check_in': checkIn,
      'check_out': checkOut,
      'check_in_location': checkInLocation,
      'check_in_address': checkInAddress,
      'check_out_location': checkOutLocation,
      'check_out_address': checkOutAddress,
      'check_in_lat': checkInLat,
      'check_in_lng': checkInLng,
      'check_out_lat': checkOutLat,
      'check_out_lng': checkOutLng,
      'status': status,
      'alasan_izin': alasanIzin,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  bool get isIzin => (status ?? '').toLowerCase() == 'izin';
  bool get isMasuk => (status ?? '').toLowerCase() == 'masuk';
  bool get hasCheckedOut => checkOut != null && checkOut!.isNotEmpty;

  DateTime? get checkInDateTime {
    if (checkIn == null) return null;
    try {
      return DateTime.parse(checkIn!);
    } catch (_) {
      return null;
    }
  }

  DateTime? get checkOutDateTime {
    if (checkOut == null) return null;
    try {
      return DateTime.parse(checkOut!);
    } catch (_) {
      return null;
    }
  }

  String get formattedDate {
    final dt = checkInDateTime ?? (createdAt != null ? DateTime.tryParse(createdAt!) : null);
    if (dt == null) return '-';
    return DateFormat('EEEE, dd MMM yyyy', 'id_ID').format(dt);
  }

  String get formattedCheckInTime {
    final dt = checkInDateTime;
    if (dt == null) return '-';
    return DateFormat('HH:mm').format(dt.toLocal());
  }

  String get formattedCheckOutTime {
    final dt = checkOutDateTime;
    if (dt == null) return '-';
    return DateFormat('HH:mm').format(dt.toLocal());
  }
}
