import 'package:rentverse/features/map/domain/entity/map_location_entity.dart';

abstract class MapRepository {
  Future<MapLocationEntity> reverseGeocode({
    required double lat,
    required double lon,
  });
}
