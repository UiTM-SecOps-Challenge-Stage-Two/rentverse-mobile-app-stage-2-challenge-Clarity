import 'package:rentverse/core/usecase/usecase.dart';
import 'package:rentverse/features/map/domain/entity/map_location_entity.dart';
import 'package:rentverse/features/map/domain/repository/map_repository.dart';

class ReverseGeocodeUseCase
    implements UseCase<MapLocationEntity, ReverseGeocodeParams> {
  final MapRepository _repository;

  ReverseGeocodeUseCase(this._repository);

  @override
  Future<MapLocationEntity> call({ReverseGeocodeParams? param}) {
    if (param == null) {
      throw const FormatException('ReverseGeocodeParams tidak boleh null');
    }
    return _repository.reverseGeocode(lat: param.lat, lon: param.lon);
  }
}

class ReverseGeocodeParams {
  final double lat;
  final double lon;

  const ReverseGeocodeParams({required this.lat, required this.lon});
}
