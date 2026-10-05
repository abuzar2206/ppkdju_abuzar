import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart';

class _C {
  static const navy = Color(0xFF0B2A4A);
  static const navyLight = Color(0xFF1B4B7A);
  static const muted = Color(0xFF6B7A90);
  static const info = Color(0xFF2F80ED);
}

class MapScreen extends StatefulWidget {
  final LatLng? location;
  final String? title;
  final String? address;

  const MapScreen({
    super.key,
    this.location,
    this.title,
    this.address,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  late LatLng _currentPosition;
  String _address = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.location != null) {
      _currentPosition = widget.location!;
      _address = widget.address ??
          '${_currentPosition.latitude.toStringAsFixed(4)}, ${_currentPosition.longitude.toStringAsFixed(4)}';
    } else {
      _currentPosition = LocationService.defaultLocation;
      _address = LocationService.defaultAddress;
      _fetchCurrentLocation();
    }
  }

  Future<void> _fetchCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    final result = await LocationService.getCurrentLocation();

    if (!mounted) return;

    setState(() {
      _currentPosition = result.position;
      _address = result.address;
      _isLoading = false;
    });

    _animateToPosition(_currentPosition);

    if (result.errorMessage != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            content: Row(
              children: [
                const Icon(Icons.info_rounded, color: Colors.white),
                const SizedBox(width: 10),
                Expanded(child: Text(result.errorMessage!)),
              ],
            ),
            duration: const Duration(seconds: 3),
          ),
        );
    }
  }

  void _animateToPosition(LatLng pos) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: pos,
          zoom: 16,
        ),
      ),
    );
  }

  // ───────────────────────────── BUILD ─────────────────────────────

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final card = dark ? const Color(0xFF16233A) : Colors.white;
    final ink = dark ? const Color(0xFFE8EEF7) : const Color(0xFF16233A);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 16,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('current_location_marker'),
                position: _currentPosition,
                infoWindow: InfoWindow(
                  title: widget.title ?? 'Lokasi Terpilih',
                  snippet: _address,
                ),
              ),
            },
            onMapCreated: (controller) {
              _mapController = controller;
              _animateToPosition(_currentPosition);
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),

          // Top bar: kembali + judul + status loading
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _roundButton(
                          icon: Icons.arrow_back_rounded,
                          tooltip: 'Kembali',
                          onTap: () => Navigator.maybePop(context),
                          card: card,
                          iconColor: ink,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 48,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: card,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: _shadow(),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.map_rounded,
                                    size: 20, color: _C.info),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    widget.title ?? 'Peta Lokasi',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                      color: ink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_isLoading) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: card,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: _shadow(),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Mengambil lokasi terkini...',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ink,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Tombol lokasi saya + kartu detail
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    heroTag: 'map_my_location',
                    tooltip: 'Lokasi Saya',
                    elevation: 4,
                    backgroundColor: _C.navy,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    onPressed: _fetchCurrentLocation,
                    child: const Icon(Icons.my_location_rounded),
                  ),
                  const SizedBox(height: 14),
                  _buildDetailCard(card, ink),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BoxShadow> _shadow() => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.18),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ];

  Widget _roundButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    required Color card,
    required Color iconColor,
  }) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: card,
        shape: BoxShape.circle,
        boxShadow: _shadow(),
      ),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onTap,
        icon: Icon(icon, color: iconColor),
      ),
    );
  }

  Widget _buildDetailCard(Color card, Color ink) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  color: _C.info.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_rounded,
                  color: _C.info,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title ?? 'Detail Lokasi',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15.5,
                        color: ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _C.muted.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${_currentPosition.latitude.toStringAsFixed(5)}, ${_currentPosition.longitude.toStringAsFixed(5)}',
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: _C.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            _address.isNotEmpty ? _address : 'Sedang memuat alamat...',
            style: TextStyle(fontSize: 13.5, height: 1.4, color: ink),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _C.navy,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, {
                  'location': _currentPosition,
                  'address': _address,
                });
              },
              icon: const Icon(Icons.check_rounded),
              label: const Text(
                'Gunakan Lokasi Ini',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
