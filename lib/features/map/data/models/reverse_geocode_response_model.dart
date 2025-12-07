import 'package:rentverse/features/map/domain/entity/map_location_entity.dart';

class ReverseGeocodeResponseModel {
  final String displayName;
  final double lat;
  final double lon;
  final String? city;
  final String? country;

  ReverseGeocodeResponseModel({
    required this.displayName,
    required this.lat,
    required this.lon,
    this.city,
    this.country,
  });

  factory ReverseGeocodeResponseModel.fromJson(Map<String, dynamic> json) {
    final address = json['address'] as Map<String, dynamic>?;
    return ReverseGeocodeResponseModel(
      displayName: (json['display_name'] ?? '') as String,
      lat: double.tryParse(json['lat']?.toString() ?? '') ?? 0,
      lon: double.tryParse(json['lon']?.toString() ?? '') ?? 0,
      city: address != null
          ? (address['city'] ?? address['town'] ?? address['village'])
                as String?
          : null,
      country: address != null ? address['country'] as String? : null,
    );
  }

  MapLocationEntity toEntity() => MapLocationEntity(
    lat: lat,
    lon: lon,
    displayName: displayName,
    city: city,
    country: country,
  );
}
