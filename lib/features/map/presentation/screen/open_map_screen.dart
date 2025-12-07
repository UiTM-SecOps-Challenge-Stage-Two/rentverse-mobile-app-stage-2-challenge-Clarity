import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentverse/common/colors/custom_color.dart';
import 'package:rentverse/core/services/service_locator.dart';
import 'package:rentverse/features/map/presentation/cubit/reverse_geocode_cubit.dart';
import 'package:rentverse/features/map/presentation/cubit/reverse_geocode_state.dart';

class OpenMapScreen extends StatefulWidget {
  const OpenMapScreen({
    super.key,
    this.initialLat = -6.200000,
    this.initialLon = 106.816666,
  });

  final double initialLat;
  final double initialLon;

  @override
  State<OpenMapScreen> createState() => _OpenMapScreenState();
}

class _OpenMapScreenState extends State<OpenMapScreen> {
  late LatLng _center;

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.initialLat, widget.initialLon);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ReverseGeocodeCubit(sl())..fetch(_center.latitude, _center.longitude),
      child: Scaffold(
        appBar: AppBar(title: const Text('OpenStreetMap Preview')),
        body: Column(
          children: [
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: _center,
                  initialZoom: 14,
                  onTap: (tapPosition, point) {
                    setState(() => _center = point);
                    context.read<ReverseGeocodeCubit>().fetch(
                      point.latitude,
                      point.longitude,
                    );
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                    userAgentPackageName: 'com.example.rentverse',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: _center,
                        width: 44,
                        height: 44,
                        child: const Icon(
                          Icons.location_pin,
                          size: 44,
                          color: appSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: BlocBuilder<ReverseGeocodeCubit, ReverseGeocodeState>(
                builder: (context, state) {
                  if (state.status == ReverseGeocodeStatus.loading) {
                    return const Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 10),
                        Text('Memuat alamat...'),
                      ],
                    );
                  }
                  if (state.status == ReverseGeocodeStatus.failure) {
                    return Text(
                      state.error ?? 'Gagal memuat alamat',
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  final location = state.location;
                  if (location == null) {
                    return const Text('Sentuh peta untuk mendapatkan alamat');
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.displayName,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lat: ${location.lat.toStringAsFixed(5)}, Lon: ${location.lon.toStringAsFixed(5)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
