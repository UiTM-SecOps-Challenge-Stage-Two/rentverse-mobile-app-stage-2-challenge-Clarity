import 'package:rentverse/features/map/domain/entity/map_location_entity.dart';

enum ReverseGeocodeStatus { initial, loading, success, failure }

class ReverseGeocodeState {
  final ReverseGeocodeStatus status;
  final MapLocationEntity? location;
  final String? error;

  const ReverseGeocodeState({required this.status, this.location, this.error});

  factory ReverseGeocodeState.initial() => const ReverseGeocodeState(
    status: ReverseGeocodeStatus.initial,
    location: null,
    error: null,
  );

  ReverseGeocodeState copyWith({
    ReverseGeocodeStatus? status,
    MapLocationEntity? location,
    String? error,
  }) {
    return ReverseGeocodeState(
      status: status ?? this.status,
      location: location ?? this.location,
      error: error,
    );
  }
}
