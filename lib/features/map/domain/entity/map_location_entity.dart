class MapLocationEntity {
  final double lat;
  final double lon;
  final String displayName;
  final String? city;
  final String? country;

  const MapLocationEntity({
    required this.lat,
    required this.lon,
    required this.displayName,
    this.city,
    this.country,
  });
}
