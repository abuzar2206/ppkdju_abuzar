import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationResult {
  final LatLng position;  
  final String address;
  final bool isMockOrFallback;
  final String? errorMessage;

  LocationResult({
    required this.position,
    required this.address,
    this.isMockOrFallback = false,
    this.errorMessage,
  });
}

class LocationService {
  // Default fallback location: Jakarta, Indonesia
  static const LatLng defaultLocation = LatLng(-6.1225, 106.9167);
  static const String defaultAddress = 'Jl. Raya Gereja Tugu No.20, RT.7/RW.6, Semper Bar., Kec. Cilincing, Jkt Utara, Daerah Khusus Ibukota Jakarta 14130';

  static Future<bool> isServiceEnabled() async {
    try {
      return await Geolocator.isLocationServiceEnabled();
    } catch (_) {
      return false;
    }
  }

  static Future<LocationPermission> checkPermission() async {
    try {
      return await Geolocator.checkPermission();
    } catch (_) {
      return LocationPermission.denied;
    }
  }

  static Future<LocationPermission> requestPermission() async {
    try {
      return await Geolocator.requestPermission();
    } catch (_) {
      return LocationPermission.denied;
    }
  }

  static Future<LocationResult> getCurrentLocation() async {
    try {
      bool serviceEnabled = await isServiceEnabled();
      if (!serviceEnabled) {
        return LocationResult(
          position: defaultLocation,
          address: defaultAddress,
          isMockOrFallback: true,
          errorMessage: 'GPS di emulator/perangkat belum aktif. Menggunakan lokasi default.',
        );
      }

      LocationPermission permission = await checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return LocationResult(
          position: defaultLocation,
          address: defaultAddress,
          isMockOrFallback: true,
          errorMessage: 'Izin lokasi belum diberikan. Menggunakan lokasi default.',
        );
      }

      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.medium,
            timeLimit: Duration(seconds: 4),
          ),
        );
      } catch (e) {
        debugPrint('Geolocator getCurrentPosition timeout/error: $e');
      }

      if (position == null) {
        try {
          position = await Geolocator.getLastKnownPosition();
        } catch (e) {
          debugPrint('Geolocator getLastKnownPosition error: $e');
        }
      }

      if (position != null) {
        final latLng = LatLng(position.latitude, position.longitude);
        final address = await getAddressFromCoordinates(
          position.latitude,
          position.longitude,
        );
        return LocationResult(
          position: latLng,
          address: address,
          isMockOrFallback: false,
        );
      }

      return LocationResult(
        position: defaultLocation,
        address: defaultAddress,
        isMockOrFallback: true,
        errorMessage: 'GPS emulator belum mengirim sinyal. Menggunakan lokasi default Jakarta.',
      );
    } catch (e) {
      debugPrint('LocationService exception: $e');
      return LocationResult(
        position: defaultLocation,
        address: defaultAddress,
        isMockOrFallback: true,
        errorMessage: 'Gagal mendeteksi lokasi: $e',
      );
    }
  }

  static Future<String> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final placemarks = await Geocoding()
          .placemarkFromCoordinates(latitude, longitude)
          .timeout(const Duration(seconds: 3));

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final List<String> parts = [];

        if (place.street != null && place.street!.isNotEmpty) {
          parts.add(place.street!);
        }
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          parts.add(place.subLocality!);
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          parts.add(place.locality!);
        }
        if (place.subAdministrativeArea != null &&
            place.subAdministrativeArea!.isNotEmpty) {
          parts.add(place.subAdministrativeArea!);
        }

        if (parts.isNotEmpty) {
          return parts.join(', ');
        }
      }
    } catch (e) {
      debugPrint('Geocoding error/timeout: $e');
    }

    return '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}';
  }
}
