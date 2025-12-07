import 'package:rentverse/features/map/data/source/open_map_remote_data_source.dart';
import 'package:rentverse/features/map/domain/entity/map_location_entity.dart';
import 'package:rentverse/features/map/domain/repository/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final OpenMapRemoteDataSource _remote;

  MapRepositoryImpl(this._remote);

  @override
  Future<MapLocationEntity> reverseGeocode({
    required double lat,
    required double lon,
  }) async {
    final model = await _remote.reverseGeocode(lat: lat, lon: lon);
    return model.toEntity();
  }
}
